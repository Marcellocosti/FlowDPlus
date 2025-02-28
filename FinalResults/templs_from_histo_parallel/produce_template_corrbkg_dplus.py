"""
Script to obtain the templates for D+ correlated backgrounds
"""

import argparse
import uproot
import numpy as np
import pandas as pd
import ROOT


def get_templates(infile_names, pt_bins, outfile_name):
    """
    """

    df = pd.DataFrame()
    for infile_name in infile_names:
        infile = ROOT.TFile.Open(infile_name)
        for key in infile.GetListOfKeys():
            df = pd.concat(
                [df, uproot.open(infile_name)[f"{key.GetName()}/O2hfcanddplite"].arrays(library="pd")])

    df_bkg = df.query("abs(fFlagMcMatchRec) == 4")
    df_signal = df.query("abs(fFlagMcMatchRec) == 1")

    hist_templ_dplustokkpi, hist_templ_dstokkpi, hist_templ, hist_signal = [], [], [], []
    hist_frac_bkg_to_signal = ROOT.TH1D("hist_frac_bkg_to_signal",
                                        ";#it{p}_{T} (GeV/#it{c});bkg corr / signal",
                                        len(pt_bins)-1, np.array(pt_bins, dtype=np.float64))
    for ipt, (pt_min, pt_max) in enumerate(zip(pt_bins[:-1], pt_bins[1:])):
        hist_templ.append(ROOT.TH1D(
            f"hist_templ_pt{pt_min:.1f}_{pt_max:.1f}",
            ";#it{M}(K#pi#pi) (GeV/#it{c})", 600, 1.67, 2.27))
        hist_templ_dplustokkpi.append(ROOT.TH1D(
            f"hist_templ_dplustokkpi_pt{pt_min:.1f}_{pt_max:.1f}",
            ";#it{M}(K#pi#pi) (GeV/#it{c})", 600, 1.67, 2.27))
        hist_templ_dstokkpi.append(ROOT.TH1D(
            f"hist_templ_dstokkpi_pt{pt_min:.1f}_{pt_max:.1f}",
            ";#it{M}(K#pi#pi) (GeV/#it{c})", 600, 1.67, 2.27))
        hist_signal.append(ROOT.TH1D(
            f"hist_signal_pt{pt_min:.1f}_{pt_max:.1f}",
            ";#it{M}(K#pi#pi) (GeV/#it{c})", 600, 1.67, 2.27))

        df_pt_dplustokkpi = df_bkg.query(f"{pt_min} < fPt < {pt_max} and abs(fFlagMcDecayChanRec) > 2")
        for mass in df_pt_dplustokkpi["fM"].to_numpy():
            hist_templ_dplustokkpi[ipt].Fill(mass)
        df_pt_dstokkpi = df_bkg.query(f"{pt_min} < fPt < {pt_max} and abs(fFlagMcDecayChanRec) <= 2")
        for mass in df_pt_dstokkpi["fM"].to_numpy():
            hist_templ_dstokkpi[ipt].Fill(mass)
        df_pt_signal = df_signal.query(f"{pt_min} < fPt < {pt_max}")
        for mass in df_pt_signal["fM"].to_numpy():
            hist_signal[ipt].Fill(mass)

        hist_templ[ipt].Add(hist_templ_dplustokkpi[ipt],
                            9.68e-3 / 0.0752 * (0.0752 + 0.0156 + 0.0104 + 0.0752))
        # Ds/D+ is underestimated in pythia CRMode2
        hist_templ[ipt].Add(hist_templ_dstokkpi[ipt], 5.37e-2 * 1.25)
        hist_signal[ipt].Scale(9.38e-2 / (0.0752 + 0.0156 + 0.0104) * (0.0752 + 0.0156 + 0.0104 + 0.0752))

        hist_frac_bkg_to_signal.SetBinContent(ipt+1,
                                              hist_templ[ipt].Integral() / hist_signal[ipt].Integral())

    outfile = ROOT.TFile(outfile_name, "recreate")
    hist_frac_bkg_to_signal.Write()
    for hist in hist_templ_dplustokkpi:
        hist.Write()
    for hist in hist_templ_dstokkpi:
        hist.Write()
    for hist in hist_signal:
        hist.Write()
    for hist in hist_templ:
        hist.Write()
        hist_smooth = hist.Clone(f"{hist.GetName()}_smooth")
        hist_smooth.Smooth(100)
        hist_smooth.Write()
    outfile.Close()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Arguments")
    parser.add_argument("--infiles", "-i", nargs="+", type=str,
                        default=["inputs/AO2D_dplus_templates_LHC24k3.root",
                                 "inputs/AO2D_dplus_templates_LHC24g5.root",
                                 "inputs/AO2D_dplus_templates_LHC24h1.root"],
                        help="input files")
    parser.add_argument("--pt_bins", "-p", nargs="+", type=float,
                        default=[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10., 12., 16., 24.],
                        help="pt intervals")
    parser.add_argument("--max_bdtbkg", "-b", type=float,
                        default=0.04, help="BDT bkg cut")
    parser.add_argument("--output", "-o", metavar="text",
                        default="inputs/dplusbkg_templates_mb_trigger.root",
                        help="output file name")
    args = parser.parse_args()

    get_templates(args.infiles, args.pt_bins, args.output)
