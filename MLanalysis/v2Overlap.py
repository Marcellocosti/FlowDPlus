import ROOT

def plot_tgraphs(filenames, graphname, legentries, colors):
    graphs = []
    graph_opt = "L"
    legend = ROOT.TLegend(0.7, 0.7, 0.9, 0.9)
    multigraph = ROOT.TMultiGraph()
    # Load the ROOT filenames
    for filename, legentry, color in zip(filenames, legentries, colors):
        file = ROOT.TFile.Open(filename)
        graphs.append(file.Get(graphname))
        
        print(type(color))
        graphs[-1].SetLineColor(color)
        graphs[-1].SetLineWidth(2)
        graphs[-1].SetTitle("v2 inclusive centrality comparison;p_{T} (GeV/c);v_{2}")  # Set title and axis labels
        legend.AddEntry(graphs[-1], legentry, "l")
        multigraph.Add(graphs[-1], graph_opt)

    out_file = ROOT.TFile(f"{graphname}Overlap.root", "recreate")
    multigraph.Write()
    out_file.Close()
    
    # Create a canvas
    canvas = ROOT.TCanvas("canvas", "Multiple TGraphs", 800, 600)
    multigraph.Draw("ap")
    legend.Draw()
 
 
    canvas.Update()
    canvas.SaveAs(f"{graphname}Overlap.pdf")  # Save the canvas as an image

files = [
    "/Users/mcosti/Analysis/FlowDPlus/MLanalysis/PAG/3040/allstat/sp/ry/raw_yieldsallstat.root", 
    "/Users/mcosti/Analysis/FlowDPlus/MLanalysis/PAG/4050/allstat/sp/ry/raw_yieldsallstat.root", 
    "/Users/mcosti/Analysis/FlowDPlus/MLanalysis/PAG/6080/allstat/sp/ry/raw_yieldsallstat.root"
]
legentries = [
    "3040",
    "4050",
    "6080"
]
colors = [
          ROOT.kRed, 
          ROOT.kBlue, 
          ROOT.kGreen+2
        ]

plot_tgraphs(files, "gvnSimFit", legentries, colors)

plot_tgraphs(files, "gvnUnc", legentries, colors)











# from ROOT import TFile, TCanvas

# file_3040 = TFile.Open("file_3040.root", "r")
# v2_3040 = file_3040.Get("gvnSimFit")
# v2unc_3040 = file_3040.Get("gvnUnc")

# file_4050 = TFile.Open("file_4050.root", "r")
# v2_4050 = file_4050.Get("gvnSimFit")
# v2unc_4050 = file_4050.Get("gvnUnc")

# file_6080 = TFile.Open("file_6080.root", "r")
# v2_6080 = file_6080.Get("gvnSimFit")
# v2unc_6080 = file_6080.Get("gvnUnc")