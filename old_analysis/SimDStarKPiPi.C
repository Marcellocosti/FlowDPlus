#include "TH1F.h"
#include "TTree.h"
#include "TParticle.h"
#include "TDatabasePDG.h"
#include "TCanvas.h"

#include <array>
#include <map>
#include <string>
#include <vector>

#include <TFile.h>
#include <TMath.h>
#include <TROOT.h>
#include <TSystem.h>
#include <TRandom3.h>

#include "Pythia8/Pythia.h"
using namespace Pythia8;

void SimDStarKPiPi(int nevents=10000, int seed = 1233) { 

    /*  
        Script that computes the invariant mass spectrum obtained
        from Dstar->D0pi->KPiPi with the K misidentified as a pion
    */
    Pythia8::Pythia pythia;
    
    pythia.readString(Form("Random:seed %d", seed));
    pythia.readString("Random:setSeed = on");
    pythia.readString("Tune:pp = 14");
    pythia.readString("SoftQCD:nonDiffractive = on");
    pythia.readString("413::onMode = off");
    pythia.readString("413:onIfMatch = 421 211");
    pythia.readString("421::onMode = off");
    pythia.readString("421:onIfMatch = -321 211");

    int DStarPDG = 413;
    pythia.init();

    TH1F * hInvMass = new TH1F("hInvMass", ";M(#pi K#pi) (GeV/c^{2});Counts", 5000, 1.3, 2.5);
    TH1F * hPt = new TH1F("hPt", ";p_{T} (GeV/c);Counts", 200, 0, 50);
    
    // Create a ROOT Tree
    double invMass;
    double pt;
    TTree tree("DStarKPiPi","DStarKPiPi");
    tree.Branch("mass",&invMass,"M(#pi K#pi)/D");    
    tree.Branch("pt",&pt,"p_{T}/D");    

    for (int iEvent = 0; iEvent < nevents; ++iEvent) {
        if (!pythia.next()) {
            continue;
        }
        for (int iPart = 2; iPart < pythia.event.size(); iPart++) {
            Particle part = pythia.event.at(iPart);
            if(abs(part.id()) == DStarPDG) {
                invMass = part.m();
                pt = part.pT();
            //     Particle KMinus, PiPlus1, PiPlus2;
            //     bool firstPionFound = false;
            //     std::vector<int> allDaughtersIdxs = part.daughterListRecursive();
            //     for(int iFirstPart=0; iFirstPart<allDaughtersIdxs.size(); iFirstPart++) {
            //         Particle daug = pythia.event.at(allDaughtersIdxs[iFirstPart]); 
            //         if(pythia.event.at(allDaughtersIdxs[iFirstPart]).id() == -321) KMinus=daug;
            //         if(pythia.event.at(allDaughtersIdxs[iFirstPart]).id() == 211 && !firstPionFound) {
            //             PiPlus1 = daug;
            //             firstPionFound = true;
            //         }
            //         if(pythia.event.at(allDaughtersIdxs[iFirstPart]).id() == 211 && firstPionFound) PiPlus2=daug;
            //     }

            //     double totE =  KMinus.e()  + PiPlus1.e()  + PiPlus2.e();
            //     double totPx = KMinus.px() + PiPlus1.px() + PiPlus2.px();
            //     double totPy = KMinus.py() + PiPlus1.py() + PiPlus2.py();
            //     double totPz = KMinus.pz() + PiPlus1.pz() + PiPlus2.pz();
            //     TLorentzVector RecoDStar(totPx, totPy, totPz, totE);
            //     invMass = RecoDStar.M();
            //     pt = RecoDStar.Pt();
                hInvMass->Fill(invMass);
                hPt->Fill(pt);
                tree.Fill();
            }
        }
    }
    
    TFile oFile(Form("DStarToKPiPi_%i.root", seed), "recreate"); 
    oFile.cd();
    hInvMass->Write();
    hPt->Write();
    tree.Write();
    oFile.Close();      
    
}