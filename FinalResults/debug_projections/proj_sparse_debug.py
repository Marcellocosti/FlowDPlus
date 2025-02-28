import ROOT
from ROOT import TFile

AN_file_80_100 = TFile.Open("/home/mdicosta/Datasets/3050/skim3040keepbkg/pre/AnRes/AnalysisResults_pt_80_100.root", 'r')
out_file_80_100 = TFile("/home/mdicosta/FlowDplus/FinalResults/debug_projections/check_projections_80_100.root", 'recreate')
print(f"projecting {AN_file_80_100} to {out_file_80_100}")

out_file_80_100.cd()
thn_sparse_80_100 = AN_file_80_100.Get('hf-task-flow-charm-hadrons/hSparseFlowCharm')

thn_sparse_80_100.GetAxis(2).SetRangeUser(0.00, 0.30)
thn_sparse_80_100.GetAxis(3).SetRangeUser(0, 0.006)

for idim in range(thn_sparse_80_100.GetNdimensions()):
    histo = thn_sparse_80_100.Projection(idim)
    histo.SetName(thn_sparse_80_100.GetAxis(idim).GetName())
    histo.SetTitle(thn_sparse_80_100.GetAxis(idim).GetTitle())
    histo.Write()

out_file_80_100.Close()

AN_file_60_70 = TFile.Open("/home/mdicosta/Datasets/3050/skim3040keepbkg/pre/AnRes/AnalysisResults_pt_60_70.root", 'r')
out_file_60_70 = TFile("/home/mdicosta/FlowDplus/FinalResults/debug_projections/check_projections_60_70.root", 'recreate')
print(f"projecting {AN_file_60_70} to {out_file_60_70}")

out_file_60_70.cd()
thn_sparse_60_70 = AN_file_60_70.Get('hf-task-flow-charm-hadrons/hSparseFlowCharm')

thn_sparse_60_70.GetAxis(2).SetRangeUser(0.00, 0.25)
thn_sparse_60_70.GetAxis(3).SetRangeUser(0, 0.1)

for idim in range(thn_sparse_60_70.GetNdimensions()):
    histo = thn_sparse_60_70.Projection(idim)
    histo.SetName(thn_sparse_60_70.GetAxis(idim).GetName())
    histo.SetTitle(thn_sparse_60_70.GetAxis(idim).GetTitle())
    histo.Write()

out_file_60_70.Close()