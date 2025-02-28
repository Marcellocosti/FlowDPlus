import ROOT
from ROOT import TFile

file = TFile.Open("test.root", "RECREATE")
# Create two TH2 histograms
h2_num = ROOT.TH2F("h2_num", "Numerator;X axis;Y axis", 10, 0, 10, 10, 0, 10)
h2_den = ROOT.TH2F("h2_den", "Denominator;X axis;Y axis", 10, 0, 10, 10, 0, 10)
# Fill histograms with some values
for x in range(1, 11):
    for y in range(1, 11):
        h2_num.SetBinContent(x, y, 5)  # Numerator: example values
        h2_den.SetBinContent(x, y, 2.5)  # Denominator: nonzero values
h2_num.Write()
h2_den.Write()

# Clone numerator to avoid modifying the original
h2_ratio = h2_num.Clone("h2_ratio")
h2_ratio.SetTitle("Ratio of TH2 Histograms;X axis;Y axis")
# Perform bin-by-bin division
h2_ratio.Divide(h2_den)
h2_ratio.Write()

# Scale the result (optional)
# h2_ratio.Scale(2.0)  # Example: Multiply all bins by 2
h2_ratio.Write()
# Draw histograms
canvas = ROOT.TCanvas("canvas", "TH2 Division & Scaling", 800, 600)
canvas.Divide(2, 2)  # Split into 4 pads

canvas.cd(1)
h2_num.Draw("COLZ")  # Original numerator
ROOT.gPad.SetTitle("Numerator")

canvas.cd(2)
h2_den.Draw("COLZ")  # Original denominator
ROOT.gPad.SetTitle("Denominator")

canvas.cd(3)
h2_ratio.Draw("COLZ")  # Ratio histogram
ROOT.gPad.SetTitle("Ratio (Scaled)")

canvas.Update()
canvas.Write()

file.Close()
