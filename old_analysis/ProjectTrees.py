from ROOT import TFile, TH1D

inFilePathData = '/data/shared/Dflow/Dplus/2050/data/AO2D.root'
inFilePathMC = '/data/shared/Dflow/Dplus/2050/mc/AO2D.root'

dataFile = TFile.Open(inFilePathData) 
dataFile.ls()

mcFile = TFile.Open(inFilePathMC) 
mcFile.ls()

