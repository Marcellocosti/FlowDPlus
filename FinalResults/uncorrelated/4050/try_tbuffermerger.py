import ROOT
import threading

### setup parallel processing
ROOT.EnableThreadSafety()
nWorkers = 2
proj_merger = ROOT.TBufferMerger('./parallel_writing.root', 'recreate')

def work_function(worker_id):
    f = proj_merger.GetFile()  # Each worker gets a thread-safe file handle
    print(type(f))
    tree = ROOT.TTree(f"tree_worker_{worker_id}", "Worker Data")
    value = ROOT.std.vector('float')()
    tree.Branch("values", value)

    # Fill the tree with data
    for i in range(10):  # Modify as needed
        value.clear()
        value.push_back(worker_id * 10 + i)
        tree.Fill()

    # Do NOT call Write() or Close(), just flush changes
    # f.Flush()  # Ensures thread-safe updates
    f.Write()  # Ensures thread-safe updates
    
# Create worker threads
workers = []

for i in range(nWorkers):
    thread = threading.Thread(target=work_function, args=(i + 1,))
    workers.append(thread)
    thread.start()

# Wait for all workers to complete
for thread in workers:
    thread.join()

print("All workers are done!")