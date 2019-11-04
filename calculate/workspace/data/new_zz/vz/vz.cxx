#include <cstdlib>
#include <vector>
#include <iostream>
#include <map>
#include <string>

#include "TFile.h"
#include "TTree.h"
#include "TString.h"
#include "TSystem.h"
#include "TROOT.h"
#include "TStopwatch.h"

// #if not defined(__CINT__) || defined(__MAKECINT__)
// #include "TMVA/Tools.h"
// #include "TMVA/Reader.h"
// #include "TMVA/MethodCuts.h"
// #endif

void vv_ntuple(TString a,TString b);
void vz()
{


    vv_ntuple("vz_az.root"  ,   "new_vz_az.root");
    vv_ntuple("vz_sm.root"  ,   "new_vz_sm.root");
    vv_ntuple("vz_tt.root"  ,   "new_vz_tt.root");
    vv_ntuple("vz_ww.root"  ,   "new_vz_ww.root");
    vv_ntuple("vz_zz.root"  ,   "new_vz_zz.root");
    vv_ntuple("vz_bb.root"  ,   "new_vz_bb.root");
    vv_ntuple("vz_cc.root"  ,   "new_vz_cc.root");
    vv_ntuple("vz_gg.root"  ,   "new_vz_gg.root");
    vv_ntuple("vz_sig.root"  ,  "new_vz_sig.root");

}

void vv_ntuple(TString a,TString b)
{

  TFile *f       = new TFile(a);
  TFile *target  = new TFile(b,"RECREATE");
  TTree *Ts = (TTree *)f->Get("Higgs Tree");
  // TTree *Tb = (TTree *)f->Get("TreeB");
 
//   Float_t      RecoMass,TauTauM;
//   Double_t     recmass,
  Double_t VisMass,  MisMass;
  Float_t  VisMassf, MisMassf, VisMassf2, MisMassf2, mZ, mH, mjj, rjj;
  Double_t      weight;

  Int_t   MCtau=0;
  Int_t   Tau,nTauP,nTauM;
  weight=1;

  Float_t g1CosPolar,g2CosPolar, g1E, g2E, g1rcCos, g2rcCos, ggE, ggM, rcM, g1PTrans, g2PTrans, ggPTrans, rcCosPolar, g1g2cos;
  Float_t LD0, LZ0, NLD0, NLZ0, weightf;

//    data->SetBranchAddress("ggM",          &ggM); // For recoil M, recoilM is MCtruth.
  //  data->SetBranchAddress("KMass34",   &mH);
  //  data->SetBranchAddress("KReco34",   &mZ);
  //  data->SetBranchAddress("KMass12",   &mjj);
  //  data->SetBranchAddress("KReco12",   &rjj);

  Long64_t nentries = Ts->GetEntries();
  // Long64_t nentriesb = Tb->GetEntries();

  cout<<nentries<<endl;
  // cout<<nentriesb<<endl;
   Double_t BDTs, BDTb, recoEs, recoEb, invmass, recmass, type;
   Ts->SetBranchAddress("scale",   &weight);
  //  Tb->SetBranchAddress("BDT",   &BDTb);
   Ts->SetBranchAddress("dimuon_rec_m",  &invmass);
//    Ts->SetBranchAddress("higtype",    &type);
//    Ts->SetBranchAddress("invmass",   &invmass);
//    Ts->SetBranchAddress("recoilmass",   &recmass);
  
  //  Tb->SetBranchAddress("allrecoE",   &recoEb);

//  Float_t sums, sumb, pmax;
//  for (Float_t test=-0.4; test<0.33; test+=0.01)
//  {

  TTree *output=new TTree("HiggsTree","HiggsTree");
  output->Branch("Mass_H"     ,&mH,    "Mass_H/F");                             //M2: ee不变； M1:qq反冲
//   output->Branch("Mass_H"     ,&recmass,    "Mass_H/F");
  // output->Branch("weight2"        ,&weight,      "weight2/F");
  output->Branch("weight"        ,&weightf,      "weight/F");
//   output->Branch("Blikeness"     ,&Blikeness,   "Blikeness/F");
//   output->Branch("Clikeness"     ,&Clikeness,   "Clikeness/F");
//   output->Branch("BDT"      ,&BDTs,    "BDT/F");
//   output->Branch("type"     ,&type,   "type/F");
//   output->Branch("allrecoE"     ,&recoEs,   "recoEs/F");

     for (Long64_t i=0; i<nentries;i++)
    {
      Ts->GetEntry(i);
      mH=(Float_t)invmass;
      weightf=(Float_t)weight;
      output->Fill();;
    }
 cout<<a<<"->begin:"<<nentries<<endl;
 cout<<a<<"->after:"<<output->GetEntries()<<endl;
 output->Write("",TObject::kOverwrite);
 target->Close();
 f->Close();



}
