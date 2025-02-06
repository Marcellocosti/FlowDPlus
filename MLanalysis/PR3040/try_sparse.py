import ROOT
from ROOT import TFile
import array
import numpy as np
import itertools

# Step 1: Define bin edges for each dimension
bin_edges = [
    [0.0, 1.0, 3.0, 6.0, 10.0],  # Bin edges for dimension 1
    [0.0, 2.5, 5.0, 7.5, 10.0],  # Bin edges for dimension 2
    [0.0, 5.0, 10.0]             # Bin edges for dimension 3
]
n_dims = len(bin_edges)  # Number of dimensions
n_bins = [len(edges) - 1 for edges in bin_edges]  # Number of bins per dimension
xmin = [min(edges) for edges in bin_edges]
xmax = [max(edges) for edges in bin_edges]

sparse = ROOT.THnSparseD(
    "sparse", "Sparse Histogram Example",
    n_dims,
    array.array('i', n_bins),  # Number of bins per dimension
    array.array('d', xmin),   # Minimum values
    array.array('d', xmax)    # Maximum values
)
for dim in range(n_dims):
    axis = sparse.GetAxis(dim)
    axis.Set(len(bin_edges[dim]) - 1, array.array('d', bin_edges[dim]))
for i in range(1000):
    x = ROOT.gRandom.Uniform(0, 10)
    y = ROOT.gRandom.Uniform(0, 10)
    z = ROOT.gRandom.Uniform(0, 10)
    sparse.Fill(np.asarray([x, y, z], 'd'))

out_file = TFile('try_sparse.root', 'recreate')
out_file.mkdir('original')
out_file.cd('original')
for idim in range(sparse.GetNdimensions()):
    histo = sparse.Projection(idim)
    histo.SetName(sparse.GetAxis(idim).GetName())
    histo.SetTitle(sparse.GetAxis(idim).GetTitle())
    histo.Write()

#######################################################
bin_edges_refilled = [
    [0.0, 1.0, 6.0, 10.0],  # Bin edges for dimension 1
    [0.0, 2.5, 5.0, 10.0],  # Bin edges for dimension 2
    [0.0, 10.0]             # Bin edges for dimension 3
]
list_ranges = [list(range(1,len(bin))) for bin in bin_edges_refilled]
result = list(itertools.product(*list_ranges))
n_dims = len(bin_edges_refilled)  # Number of dimensions
n_bins = [len(edges) - 1 for edges in bin_edges_refilled]  # Number of bins per dimension
xmin = [min(edges) for edges in bin_edges_refilled]
xmax = [max(edges) for edges in bin_edges_refilled]
print(list_ranges)
print(result)
print(f"n_bins: {n_bins}")
print(f"array.array('d', xmin): {array.array('d', xmin)}")
print(f"array.array('d', xmax): {array.array('d', xmax)}")
sparse_refilled = ROOT.THnSparseD(
    "sparse_refilled", "Sparse Refilled",
    n_dims,
    array.array('i', n_bins),  # Number of bins per dimension
    array.array('d', xmin),   # Minimum values
    array.array('d', xmax)    # Maximum values
)

# Step 4: Set custom bin edges for each dimension
for dim in range(n_dims):
    axis = sparse_refilled.GetAxis(dim)
    axis.Set(len(bin_edges_refilled[dim]) - 1, array.array('d', bin_edges_refilled[dim]))

# print(type(sparse))
# print(f"sparse.GetNbins(): {sparse.GetNbins()}")
# print(type(sparse_refilled))
# print(f"sparse_refilled.GetNbins(): {sparse_refilled.GetNbins()}")
# print(f"bin_edges: {bin_edges}")
for ibin in result:
    print("\n")
    print(f"ibin: {ibin}")
    for idim in range(len(bin_edges_refilled)):
        # print(f"bin_edges_refilled[idim]: {bin_edges_refilled[idim]}")
        # print(f"bin_edges_refilled[idim][ibin[idim]-1]: {bin_edges_refilled[idim][ibin[idim]-1]}")
        # print(f"bin_edges_refilled[idim][ibin[idim]]: {bin_edges_refilled[idim][ibin[idim]]}")
        sparse.GetAxis(idim).SetRangeUser(bin_edges_refilled[idim][ibin[idim]-1], bin_edges_refilled[idim][ibin[idim]])
    
    # print(f"sparse.Projection(0).Integral(): {sparse.Projection(0).Integral()}")
    sparse_refilled.SetBinContent(np.asarray(ibin, 'i'), sparse.Projection(0).Integral())

# print(f"sparse_refilled.GetNbins(): {sparse_refilled.GetNbins()}")

out_file.mkdir('original_after_refill')
out_file.cd('original_after_refill')
for idim in range(sparse.GetNdimensions()):
    histo = sparse.Projection(idim)
    histo.SetName(sparse.GetAxis(idim).GetName())
    histo.SetTitle(sparse.GetAxis(idim).GetTitle())
    histo.Write()

out_file.mkdir('refilled')
out_file.cd('refilled')

for idim in range(sparse_refilled.GetNdimensions()):
    histo = sparse_refilled.Projection(idim)
    histo.SetName(sparse_refilled.GetAxis(idim).GetName())
    histo.SetTitle(sparse_refilled.GetAxis(idim).GetTitle())
    histo.Write()

out_file.cd()
sparse.Write()
sparse_refilled.Write()

out_file.Close()