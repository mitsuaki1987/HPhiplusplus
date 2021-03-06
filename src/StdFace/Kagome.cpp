/*
HPhi-mVMC-StdFace - Common input generator
Copyright (C) 2015 The University of Tokyo

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
/**@file
@brief Standard mode for the kagome lattice
*/
#include "StdFace_vals.hpp"
#include "StdFace_ModelUtil.hpp"
#include <cstdlib>
#include <cstdio>
#include <cmath>
#include <complex>
#include <cstring>

/**
@brief Setup a Hamiltonian for the Kagome lattice
@author Mitsuaki Kawamura (The University of Tokyo)
*/
void StdFace::Kagome()
{
  int isite, jsite, isiteUC, kCell;
  int iL, iW;
  FILE *fp;
  std::complex<double> Cphase;
  double dR[3];

  /**@brief
  (1) Compute the shape of the super-cell and sites in the super-cell
  */
  fp = fopen("lattice.gp", "w");
  /**/
  StdI::NsiteUC = 3;
  /**/
  fprintf(stdout, "  @ Lattice Size & Shape\n\n");
  
  StdFace::PrintVal_d("a", &StdI::a, 1.0);
  StdFace::PrintVal_d("Wlength", &StdI::length[0], StdI::a);
  StdFace::PrintVal_d("Llength", &StdI::length[1], StdI::a);
  StdFace::PrintVal_d("Wx", &StdI::direct[0][0], StdI::length[0]);
  StdFace::PrintVal_d("Wy", &StdI::direct[0][1], 0.0);
  StdFace::PrintVal_d("Lx", &StdI::direct[1][0], StdI::length[1] * 0.5);
  StdFace::PrintVal_d("Ly", &StdI::direct[1][1], StdI::length[1] * 0.5 * sqrt(3.0));
  
  StdFace::PrintVal_d("phase0", &StdI::phase[0], 0.0);
  StdFace::PrintVal_d("phase1", &StdI::phase[1], 0.0);
  /**/
  StdFace::InitSite(fp, 2);
  StdI::tau[0][0] = 0.0; StdI::tau[0][1] = 0.0; StdI::tau[0][2] = 0.0;
  StdI::tau[1][0] = 0.5; StdI::tau[1][1] = 0.0; StdI::tau[1][2] = 0.0;
  StdI::tau[2][0] = 0.0; StdI::tau[2][1] = 0.5; StdI::tau[2][2] = 0.0;
  /**@brief
  (2) check & store parameters of Hamiltonian
  */
  fprintf(stdout, "\n  @ Hamiltonian \n\n");
  /**/
  StdFace::NotUsed_d("K", StdI::K);
  StdFace::PrintVal_d("h", &StdI::h, 0.0);
  StdFace::PrintVal_d("Gamma", &StdI::Gamma, 0.0);
  /**/
  if (strcmp(StdI::model, "spin") == 0 ) {
    StdFace::PrintVal_i("2S", &StdI::S2, 1);
    StdFace::PrintVal_d("D", &StdI::D[2][2], 0.0);
    StdFace::InputSpinNN(StdI::J, StdI::JAll, StdI::J0, StdI::J0All, "J0");
    StdFace::InputSpinNN(StdI::J, StdI::JAll, StdI::J1, StdI::J1All, "J1");
    StdFace::InputSpinNN(StdI::J, StdI::JAll, StdI::J2, StdI::J2All, "J2");
    StdFace::InputSpinNN(StdI::Jp, StdI::JpAll, StdI::J0p, StdI::J0pAll, "J0'");
    StdFace::InputSpinNN(StdI::Jp, StdI::JpAll, StdI::J1p, StdI::J1pAll, "J1'");
    StdFace::InputSpinNN(StdI::Jp, StdI::JpAll, StdI::J2p, StdI::J2pAll, "J2'");
    /**/
    StdFace::NotUsed_d("mu", StdI::mu);
    StdFace::NotUsed_d("U", StdI::U);
    StdFace::NotUsed_c("t", StdI::t);
    StdFace::NotUsed_c("t0", StdI::t);
    StdFace::NotUsed_c("t0", StdI::t0);
    StdFace::NotUsed_c("t1", StdI::t1);
    StdFace::NotUsed_c("t2", StdI::t2);
    StdFace::NotUsed_c("t'", StdI::tp);
    StdFace::NotUsed_c("t0'", StdI::t0p);
    StdFace::NotUsed_c("t1'", StdI::t1p);
    StdFace::NotUsed_c("t2'", StdI::t2p);
    StdFace::NotUsed_d("V", StdI::V);
    StdFace::NotUsed_d("V0", StdI::V0);
    StdFace::NotUsed_d("V1", StdI::V1);
    StdFace::NotUsed_d("V2", StdI::V2);
    StdFace::NotUsed_d("V'", StdI::Vp);
    StdFace::NotUsed_d("V0'", StdI::V0p);
    StdFace::NotUsed_d("V1'", StdI::V1p);
    StdFace::NotUsed_d("V2'", StdI::V2p);
  }/*if (strcmp(StdI::model, "spin") == 0 )*/
  else {
    StdFace::PrintVal_d("mu", &StdI::mu, 0.0);
    StdFace::PrintVal_d("U", &StdI::U, 0.0);
    StdFace::InputHopp(StdI::t, &StdI::t0, "t0");
    StdFace::InputHopp(StdI::t, &StdI::t1, "t1");
    StdFace::InputHopp(StdI::t, &StdI::t2, "t2");
    StdFace::InputHopp(StdI::tp, &StdI::t0p, "t0'");
    StdFace::InputHopp(StdI::tp, &StdI::t1p, "t1'");
    StdFace::InputHopp(StdI::tp, &StdI::t2p, "t2'");
    StdFace::InputCoulombV(StdI::V, &StdI::V0, "V0");
    StdFace::InputCoulombV(StdI::V, &StdI::V1, "V1");
    StdFace::InputCoulombV(StdI::V, &StdI::V2, "V2");
    StdFace::InputCoulombV(StdI::Vp, &StdI::V0p, "V0'");
    StdFace::InputCoulombV(StdI::Vp, &StdI::V1p, "V1'");
    StdFace::InputCoulombV(StdI::Vp, &StdI::V2p, "V2'");
    /**/
    StdFace::NotUsed_J("J0", StdI::J0All, StdI::J0);
    StdFace::NotUsed_J("J1", StdI::J1All, StdI::J1);
    StdFace::NotUsed_J("J2", StdI::J2All, StdI::J2);
    StdFace::NotUsed_J("J'", StdI::JpAll, StdI::Jp);
    StdFace::NotUsed_J("J0'", StdI::J0pAll, StdI::J0p);
    StdFace::NotUsed_J("J1'", StdI::J1pAll, StdI::J1p);
    StdFace::NotUsed_J("J2'", StdI::J2pAll, StdI::J2p);
    StdFace::NotUsed_d("D", StdI::D[2][2]);

    if (strcmp(StdI::model, "hubbard") == 0 ) {
      StdFace::NotUsed_i("2S", StdI::S2);
      StdFace::NotUsed_J("J", StdI::JAll, StdI::J);
    }/*if (strcmp(StdI::model, "hubbard") == 0 )*/
    else {
      StdFace::PrintVal_i("2S", &StdI::S2, 1);
      StdFace::InputSpin(StdI::J, StdI::JAll, "J");
    }/*if (model != "hubbard")*/

  }/*if (model != "spin")@@*/
  fprintf(stdout, "\n  @ Numerical conditions\n\n");
  /**@brief
  (3) Set local spin flag (StdI::locspinflag) and
  the number of sites (StdI::nsite)
  */
  StdI::nsite = StdI::NsiteUC * StdI::NCell;
  if (strcmp(StdI::model, "kondo") == 0 ) StdI::nsite *= 2;
  StdI::locspinflag = (int *)malloc(sizeof(int) * StdI::nsite);
  /**/
  if (strcmp(StdI::model, "spin") == 0 )
    for (isite = 0; isite < StdI::nsite; isite++) StdI::locspinflag[isite] = StdI::S2;
  else if (strcmp(StdI::model, "hubbard") == 0 )
    for (isite = 0; isite < StdI::nsite; isite++) StdI::locspinflag[isite] = 0;
  else
    for (iL = 0; iL < StdI::nsite / 2; iL++) {
      StdI::locspinflag[iL] = StdI::S2;
      StdI::locspinflag[iL + StdI::nsite / 2] = 0;
    }
  /**@brief
  (5) Set Transfer & Interaction
  */
  for (kCell = 0; kCell < StdI::NCell; kCell++) {
    /**/
    iW = StdI::Cell[kCell][0];
    iL = StdI::Cell[kCell][1];
    /*>>
    Local term
    */
    isite = StdI::NsiteUC * kCell;
    if (strcmp(StdI::model, "kondo") == 0 ) isite += StdI::nsite / 2;
    /**/
    if (strcmp(StdI::model, "spin") == 0 ) {
      for (isiteUC = 0; isiteUC < StdI::NsiteUC; isiteUC++) {
        StdFace::MagField(StdI::S2, -StdI::h, -StdI::Gamma, isite + isiteUC);
        StdFace::GeneralJ(StdI::D, StdI::S2, StdI::S2, isite + isiteUC, isite + isiteUC);
      }/*for (jsite = 0; jsite < StdI::NsiteUC; jsite++)*/
    }/*if (strcmp(StdI::model, "spin") == 0 )*/
    else {
      for (isiteUC = 0; isiteUC < StdI::NsiteUC; isiteUC++)
        StdFace::HubbardLocal(StdI::mu, -StdI::h, -StdI::Gamma, StdI::U, isite + isiteUC);
      /**/
      if (strcmp(StdI::model, "kondo") == 0 ) {
        jsite = StdI::NsiteUC * kCell;
        for (isiteUC = 0; isiteUC < StdI::NsiteUC; isiteUC++) {
          StdFace::GeneralJ(StdI::J, 1, StdI::S2, isite + isiteUC, jsite + isiteUC);
          StdFace::MagField(StdI::S2, -StdI::h, -StdI::Gamma, jsite + isiteUC);
        }/*for (isiteUC = 0; isiteUC < StdI::NsiteUC; isiteUC++)*/
      }/*if (strcmp(StdI::model, "kondo") == 0 )*/
    }/*if (strcmp(StdI::model, "spin") != 0 )<<*/
    /*>>
    Nearest neighbor intra cell 0 -> 1
    */
    StdFace::SetLabel(fp, iW, iL, 0, 0, 0, 1, &isite, &jsite, 1, &Cphase, dR);
    /**/
    if (strcmp(StdI::model, "spin") == 0 ) {
      StdFace::GeneralJ(StdI::J2, StdI::S2, StdI::S2, isite, jsite);
    }/*if (strcmp(StdI::model, "spin") == 0 )*/
    else {
      StdFace::Hopping(Cphase * StdI::t2, isite, jsite, dR);
      StdFace::Coulomb(StdI::V2, isite, jsite);
    }//<<
    /*
    Nearest neighbor intra cell 0 -> 2
    */
    StdFace::SetLabel(fp, iW, iL, 0, 0, 0, 2, &isite, &jsite, 1, &Cphase, dR);
    /**/
    if (strcmp(StdI::model, "spin") == 0 ) {
      StdFace::GeneralJ(StdI::J1, StdI::S2, StdI::S2, isite, jsite);
    }/*if (strcmp(StdI::model, "spin") == 0 )*/
    else {
      StdFace::Hopping(Cphase * StdI::t1, isite, jsite, dR);
      StdFace::Coulomb(StdI::V1, isite, jsite);
    }
    /*
    Nearest neighbor intra cell 1 -> 2
    */
    StdFace::SetLabel(fp, iW, iL, 0, 0, 1, 2, &isite, &jsite, 1, &Cphase, dR);
    /**/
    if (strcmp(StdI::model, "spin") == 0 ) {
      StdFace::GeneralJ(StdI::J0, StdI::S2, StdI::S2, isite, jsite);
    }/*if (strcmp(StdI::model, "spin") == 0 )*/
    else {
      StdFace::Hopping(Cphase * StdI::t0, isite, jsite, dR);
      StdFace::Coulomb(StdI::V0, isite, jsite);
    }
    /*
    Nearest neighbor along W 1 -> 0
    */
    StdFace::SetLabel(fp, iW, iL, 1, 0, 1, 0, &isite, &jsite, 1, &Cphase, dR);
    /**/
    if (strcmp(StdI::model, "spin") == 0 ) {
      StdFace::GeneralJ(StdI::J2, StdI::S2, StdI::S2, isite, jsite);
    }/*if (strcmp(StdI::model, "spin") == 0 )*/
    else {
      StdFace::Hopping(Cphase * StdI::t2, isite, jsite, dR);
      StdFace::Coulomb(StdI::V2, isite, jsite);
    }
    /*
    Nearest neighbor along L 2 -> 0
    */
    StdFace::SetLabel(fp, iW, iL, 0, 1, 2, 0, &isite, &jsite, 1, &Cphase, dR);
    /**/
    if (strcmp(StdI::model, "spin") == 0 ) {
      StdFace::GeneralJ(StdI::J1, StdI::S2, StdI::S2, isite, jsite);
    }
    else {
      StdFace::Hopping(Cphase * StdI::t1, isite, jsite, dR);
      StdFace::Coulomb(StdI::V1, isite, jsite);
    }
    /*
    Nearest neighbor along W-L 1 -> 2
    */
    StdFace::SetLabel(fp, iW, iL, 1, - 1, 1, 2, &isite, &jsite, 1, &Cphase, dR);
    /**/
    if (strcmp(StdI::model, "spin") == 0 ) {
      StdFace::GeneralJ(StdI::J0, StdI::S2, StdI::S2, isite, jsite);
    }/*if (strcmp(StdI::model, "spin") == 0 )*/
    else {
      StdFace::Hopping(Cphase * StdI::t0, isite, jsite, dR);
      StdFace::Coulomb(StdI::V0, isite, jsite);
    }
    /*
    Second nearest neighbor along W 2 -> 0
    */
    StdFace::SetLabel(fp, iW, iL, 1, 0, 2, 0, &isite, &jsite, 2, &Cphase, dR);
    /**/
    if (strcmp(StdI::model, "spin") == 0 ) {
      StdFace::GeneralJ(StdI::J1p, StdI::S2, StdI::S2, isite, jsite);
    }/*if (strcmp(StdI::model, "spin") == 0 )*/
    else {
      StdFace::Hopping(Cphase * StdI::t1p, isite, jsite, dR);
      StdFace::Coulomb(StdI::V1p, isite, jsite);
    }
    /*
    Second nearest neighbor along W 1 -> 2
    */
    StdFace::SetLabel(fp, iW, iL, 1, 0, 1, 2, &isite, &jsite, 2, &Cphase, dR);
    /**/
    if (strcmp(StdI::model, "spin") == 0 ) {
      StdFace::GeneralJ(StdI::J0p, StdI::S2, StdI::S2, isite, jsite);
    }/*if (strcmp(StdI::model, "spin") == 0 )*/
    else {
      StdFace::Hopping(Cphase * StdI::t0p, isite, jsite, dR);
      StdFace::Coulomb(StdI::V0p, isite, jsite);
    }
    /*
    Second nearest neighbor along L 1 -> 0
    */
    StdFace::SetLabel(fp, iW, iL, 0, 1, 1, 0, &isite, &jsite, 2, &Cphase, dR);
    /**/
    if (strcmp(StdI::model, "spin") == 0 ) {
      StdFace::GeneralJ(StdI::J2p, StdI::S2, StdI::S2, isite, jsite);
    }/*if (strcmp(StdI::model, "spin") == 0 )*/
    else {
      StdFace::Hopping(Cphase * StdI::t2p, isite, jsite, dR);
      StdFace::Coulomb(StdI::V2p, isite, jsite);
    }
    /*
    Second nearest neighbor along L 2 -> 1
    */
    StdFace::SetLabel(fp, iW, iL, 0, 1, 2, 1, &isite, &jsite, 2, &Cphase, dR);
    /**/
    if (strcmp(StdI::model, "spin") == 0 ) {
      StdFace::GeneralJ(StdI::J0p, StdI::S2, StdI::S2, isite, jsite);
    }/*if (strcmp(StdI::model, "spin") == 0 )*/
    else {
      StdFace::Hopping(Cphase * StdI::t0p, isite, jsite, dR);
      StdFace::Coulomb(StdI::V0p, isite, jsite);
    }
    /*
    Second nearest neighbor along W-L 0 -> 2
    */
    StdFace::SetLabel(fp, iW, iL, 1, - 1, 0, 2, &isite, &jsite, 2, &Cphase, dR);
    /**/
    if (strcmp(StdI::model, "spin") == 0 ) {
      StdFace::GeneralJ(StdI::J1p, StdI::S2, StdI::S2, isite, jsite);
    }/*if (strcmp(StdI::model, "spin") == 0 )*/
    else {
      StdFace::Hopping(Cphase * StdI::t1p, isite, jsite, dR);
      StdFace::Coulomb(StdI::V1p, isite, jsite);
    }
    /*
    Second nearest neighbor along L-W 0 -> 1
    */
    StdFace::SetLabel(fp, iW, iL, - 1, 1, 0, 1, &isite, &jsite, 2, &Cphase, dR);
    /**/
    if (strcmp(StdI::model, "spin") == 0 ) {
      StdFace::GeneralJ(StdI::J2p, StdI::S2, StdI::S2, isite, jsite);
    }/*if (strcmp(StdI::model, "spin") == 0 )*/
    else {
      StdFace::Hopping(Cphase * StdI::t2p, isite, jsite, dR);
      StdFace::Coulomb(StdI::V2p, isite, jsite);
    }
  }/*for (kCell = 0; kCell < StdI::NCell; kCell++)*/

  fprintf(fp, "plot \'-\' w d lc 7\n0.0 0.0\nend\npause -1\n");
  fclose(fp);
  StdFace::PrintGeometry();
}/*void StdFace::Kagome*/

#if defined(_HPhi)
/**
*
* Setup a Hamiltonian for the generalized Heisenberg model on a Heisenberg lattice
*
* @author Mitsuaki Kawamura (The University of Tokyo)
*/
void StdFace::Kagome_Boost()
{
  int isite, ipivot, i1, i2;
  int kintr;
  FILE *fp;

  if (StdI::box[0][1] != 0 || StdI::box[1][0] != 0) {
    fprintf(stdout, "\nERROR ! (a0W, a0L, a1W, a1L) can not be used with SpinGCBoost.\n\n");
    StdFace::exit(-1);
  }
  for (i1 = 0; i1 < 3; i1++) {
    for (i2 = 0; i2 < 3; i2++) {
      if (fabs(StdI::Jp[i1][i2]) > 1.0e-8) {
        fprintf(stdout, "\nERROR ! J' can not be used with SpinGCBoost.\n\n");
        StdFace::exit(-1);
      }
    }
  }
  /*
  Magnetic field
  */
  fp = fopen("boost.def", "w");
  fprintf(fp, "# Magnetic field\n");
  fprintf(fp, "%25.15e %25.15e %25.15e\n",
    -0.5 * StdI::Gamma, 0.0, -0.5 * StdI::h);
  /*
  Interaction
  */
  fprintf(fp, "%d  # Number of type of J\n", 3);
  fprintf(fp, "# J 0\n");
  fprintf(fp, "%25.15e %25.15e %25.15e\n",
    0.25 * StdI::J0[0][0], 0.25 * StdI::J0[0][1], 0.25 * StdI::J0[0][2]);
  fprintf(fp, "%25.15e %25.15e %25.15e\n",
    0.25 * StdI::J0[0][1], 0.25 * StdI::J0[1][1], 0.25 * StdI::J0[1][2]);
  fprintf(fp, "%25.15e %25.15e %25.15e\n",
    0.25 * StdI::J0[0][2], 0.25 * StdI::J0[1][2], 0.25 * StdI::J0[2][2]);
  fprintf(fp, "# J 1\n");
  fprintf(fp, "%25.15e %25.15e %25.15e\n",
    0.25 * StdI::J1[0][0], 0.25 * StdI::J1[0][1], 0.25 * StdI::J1[0][2]);
  fprintf(fp, "%25.15e %25.15e %25.15e\n",
    0.25 * StdI::J1[0][1], 0.25 * StdI::J1[1][1], 0.25 * StdI::J1[1][2]);
  fprintf(fp, "%25.15e %25.15e %25.15e\n",
    0.25 * StdI::J1[0][2], 0.25 * StdI::J1[1][2], 0.25 * StdI::J1[2][2]);
  fprintf(fp, "# J 2\n");
  fprintf(fp, "%25.15e %25.15e %25.15e\n",
    0.25 * StdI::J2[0][0], 0.25 * StdI::J2[0][1], 0.25 * StdI::J2[0][2]);
  fprintf(fp, "%25.15e %25.15e %25.15e\n",
    0.25 * StdI::J2[0][1], 0.25 * StdI::J2[1][1], 0.25 * StdI::J2[1][2]);
  fprintf(fp, "%25.15e %25.15e %25.15e\n",
    0.25 * StdI::J2[0][2], 0.25 * StdI::J2[1][2], 0.25 * StdI::J2[2][2]);  /*
  Topology
  */
  if (StdI::S2 != 1) {
    fprintf(stdout, "\n ERROR! S2 must be 1 in Boost. \n\n");
    StdFace::exit(-1);
  }
  StdI::ishift_nspin = 3;
  if (StdI::L < 2) {
    fprintf(stdout, "\n ERROR! L < 2 \n\n");
    StdFace::exit(-1);
  }
  if (StdI::W % StdI::ishift_nspin != 0) {
    fprintf(stdout, "\n ERROR! W %% %d != 0 \n\n", StdI::ishift_nspin);
    StdFace::exit(-1);
  }
  StdI::num_pivot = 4;
  if (StdI::W != 3) {
    fprintf(stdout, "DEBUG: W != 3\n");
    StdFace::exit(-1);
  }
  StdI::W = 9;
  fprintf(fp, "# W0  R0  StdI::num_pivot  StdI::ishift_nspin\n");
  fprintf(fp, "%d %d %d %d\n", StdI::W, StdI::L, StdI::num_pivot, StdI::ishift_nspin);

  StdI::list_6spin_star = (int **)malloc(sizeof(int*) * StdI::num_pivot);
  for (ipivot = 0; ipivot < StdI::num_pivot; ipivot++) {
    StdI::list_6spin_star[ipivot] = (int *)malloc(sizeof(int) * 7);
  }

  StdI::list_6spin_star[0][0] = 1; // num of J
  StdI::list_6spin_star[0][1] = 1;
  StdI::list_6spin_star[0][2] = 1;
  StdI::list_6spin_star[0][3] = 1;
  StdI::list_6spin_star[0][4] = 4;
  StdI::list_6spin_star[0][5] = 2;
  StdI::list_6spin_star[0][6] = -1; // flag

  StdI::list_6spin_star[1][0] = 6; // num of J
  StdI::list_6spin_star[1][1] = 1;
  StdI::list_6spin_star[1][2] = 1;
  StdI::list_6spin_star[1][3] = 1;
  StdI::list_6spin_star[1][4] = 6;
  StdI::list_6spin_star[1][5] = 7;
  StdI::list_6spin_star[1][6] = 1; // flag

  StdI::list_6spin_star[2][0] = 6; // num of J
  StdI::list_6spin_star[2][1] = 1;
  StdI::list_6spin_star[2][2] = 1;
  StdI::list_6spin_star[2][3] = 1;
  StdI::list_6spin_star[2][4] = 4;
  StdI::list_6spin_star[2][5] = 2;
  StdI::list_6spin_star[2][6] = 1; // flag

  StdI::list_6spin_star[3][0] = 5; // num of J
  StdI::list_6spin_star[3][1] = 1;
  StdI::list_6spin_star[3][2] = 1;
  StdI::list_6spin_star[3][3] = 1;
  StdI::list_6spin_star[3][4] = 4;
  StdI::list_6spin_star[3][5] = 2;
  StdI::list_6spin_star[3][6] = 1; // flag

  fprintf(fp, "# StdI::list_6spin_star\n");
  for (ipivot = 0; ipivot < StdI::num_pivot; ipivot++) {
    fprintf(fp, "# pivot %d\n", ipivot);
    for (isite = 0; isite < 7; isite++) {
      fprintf(fp, "%d ", StdI::list_6spin_star[ipivot][isite]);
    }
    fprintf(fp, "\n");
  }

  StdI::list_6spin_pair = (int ***)malloc(sizeof(int**) * StdI::num_pivot);
  for (ipivot = 0; ipivot < StdI::num_pivot; ipivot++) {
    StdI::list_6spin_pair[ipivot] = (int **)malloc(sizeof(int*) * 7);
    for (isite = 0; isite < 7; isite++) {
      StdI::list_6spin_pair[ipivot][isite] = (int *)malloc(sizeof(int) * StdI::list_6spin_star[ipivot][0]);
    }
  }

  StdI::list_6spin_pair[0][0][0] = 0; //(1,1,1+2*j)=0 
  StdI::list_6spin_pair[0][1][0] = 4; //(2,1,1+2*j)=1
  StdI::list_6spin_pair[0][2][0] = 1; //(3,1,1+2*j)=2
  StdI::list_6spin_pair[0][3][0] = 2; //(4,1,1+2*j)=3
  StdI::list_6spin_pair[0][4][0] = 3; //(5,1,1+2*j)=4
  StdI::list_6spin_pair[0][5][0] = 5; //(6,1,1+2*j)=5
  StdI::list_6spin_pair[0][6][0] = 3; //(7,1,1+2*j)=3 ! type of J

  StdI::list_6spin_pair[1][0][0] = 0;
  StdI::list_6spin_pair[1][1][0] = 1;
  StdI::list_6spin_pair[1][2][0] = 2;
  StdI::list_6spin_pair[1][3][0] = 3;
  StdI::list_6spin_pair[1][4][0] = 4;
  StdI::list_6spin_pair[1][5][0] = 5;
  StdI::list_6spin_pair[1][6][0] = 3; // type of J
  StdI::list_6spin_pair[1][0][1] = 1;
  StdI::list_6spin_pair[1][1][1] = 2;
  StdI::list_6spin_pair[1][2][1] = 0;
  StdI::list_6spin_pair[1][3][1] = 3;
  StdI::list_6spin_pair[1][4][1] = 4;
  StdI::list_6spin_pair[1][5][1] = 5;
  StdI::list_6spin_pair[1][6][1] = 1; // type of J
  StdI::list_6spin_pair[1][0][2] = 0;
  StdI::list_6spin_pair[1][1][2] = 2;
  StdI::list_6spin_pair[1][2][2] = 1;
  StdI::list_6spin_pair[1][3][2] = 3;
  StdI::list_6spin_pair[1][4][2] = 4;
  StdI::list_6spin_pair[1][5][2] = 5;
  StdI::list_6spin_pair[1][6][2] = 2; // type of J
  StdI::list_6spin_pair[1][0][3] = 1;
  StdI::list_6spin_pair[1][1][3] = 3;
  StdI::list_6spin_pair[1][2][3] = 0;
  StdI::list_6spin_pair[1][3][3] = 2;
  StdI::list_6spin_pair[1][4][3] = 4;
  StdI::list_6spin_pair[1][5][3] = 5;
  StdI::list_6spin_pair[1][6][3] = 3; // type of J
  StdI::list_6spin_pair[1][0][4] = 2;
  StdI::list_6spin_pair[1][1][4] = 4;
  StdI::list_6spin_pair[1][2][4] = 0;
  StdI::list_6spin_pair[1][3][4] = 1;
  StdI::list_6spin_pair[1][4][4] = 3;
  StdI::list_6spin_pair[1][5][4] = 5;
  StdI::list_6spin_pair[1][6][4] = 2; // type of J
  StdI::list_6spin_pair[1][0][5] = 2;
  StdI::list_6spin_pair[1][1][5] = 5;
  StdI::list_6spin_pair[1][2][5] = 0;
  StdI::list_6spin_pair[1][3][5] = 1;
  StdI::list_6spin_pair[1][4][5] = 3;
  StdI::list_6spin_pair[1][5][5] = 4;
  StdI::list_6spin_pair[1][6][5] = 1; // type of J

  StdI::list_6spin_pair[2][0][0] = 0;
  StdI::list_6spin_pair[2][1][0] = 1;
  StdI::list_6spin_pair[2][2][0] = 2;
  StdI::list_6spin_pair[2][3][0] = 3;
  StdI::list_6spin_pair[2][4][0] = 4;
  StdI::list_6spin_pair[2][5][0] = 5;
  StdI::list_6spin_pair[2][6][0] = 3; // type of J
  StdI::list_6spin_pair[2][0][1] = 1;
  StdI::list_6spin_pair[2][1][1] = 2;
  StdI::list_6spin_pair[2][2][1] = 0;
  StdI::list_6spin_pair[2][3][1] = 3;
  StdI::list_6spin_pair[2][4][1] = 4;
  StdI::list_6spin_pair[2][5][1] = 5;
  StdI::list_6spin_pair[2][6][1] = 1; // type of J
  StdI::list_6spin_pair[2][0][2] = 0;
  StdI::list_6spin_pair[2][1][2] = 2;
  StdI::list_6spin_pair[2][2][2] = 1;
  StdI::list_6spin_pair[2][3][2] = 3;
  StdI::list_6spin_pair[2][4][2] = 4;
  StdI::list_6spin_pair[2][5][2] = 5;
  StdI::list_6spin_pair[2][6][2] = 2; // type of J
  StdI::list_6spin_pair[2][0][3] = 1;
  StdI::list_6spin_pair[2][1][3] = 3;
  StdI::list_6spin_pair[2][2][3] = 0;
  StdI::list_6spin_pair[2][3][3] = 2;
  StdI::list_6spin_pair[2][4][3] = 4;
  StdI::list_6spin_pair[2][5][3] = 5;
  StdI::list_6spin_pair[2][6][3] = 3; // type of J
  StdI::list_6spin_pair[2][0][4] = 2;
  StdI::list_6spin_pair[2][1][4] = 5;
  StdI::list_6spin_pair[2][2][4] = 0;
  StdI::list_6spin_pair[2][3][4] = 1;
  StdI::list_6spin_pair[2][4][4] = 3;
  StdI::list_6spin_pair[2][5][4] = 4;
  StdI::list_6spin_pair[2][6][4] = 2; // type of J
  StdI::list_6spin_pair[2][0][5] = 2;
  StdI::list_6spin_pair[2][1][5] = 4;
  StdI::list_6spin_pair[2][2][5] = 0;
  StdI::list_6spin_pair[2][3][5] = 1;
  StdI::list_6spin_pair[2][4][5] = 3;
  StdI::list_6spin_pair[2][5][5] = 5;
  StdI::list_6spin_pair[2][6][5] = 1; // type of J

  StdI::list_6spin_pair[3][0][0] = 0;
  StdI::list_6spin_pair[3][1][0] = 1;
  StdI::list_6spin_pair[3][2][0] = 2;
  StdI::list_6spin_pair[3][3][0] = 3;
  StdI::list_6spin_pair[3][4][0] = 4;
  StdI::list_6spin_pair[3][5][0] = 5;
  StdI::list_6spin_pair[3][6][0] = 3; // type of J
  StdI::list_6spin_pair[3][0][1] = 1;
  StdI::list_6spin_pair[3][1][1] = 2;
  StdI::list_6spin_pair[3][2][1] = 0;
  StdI::list_6spin_pair[3][3][1] = 3;
  StdI::list_6spin_pair[3][4][1] = 4;
  StdI::list_6spin_pair[3][5][1] = 5;
  StdI::list_6spin_pair[3][6][1] = 1; // type of J
  StdI::list_6spin_pair[3][0][2] = 0;
  StdI::list_6spin_pair[3][1][2] = 2;
  StdI::list_6spin_pair[3][2][2] = 1;
  StdI::list_6spin_pair[3][3][2] = 3;
  StdI::list_6spin_pair[3][4][2] = 4;
  StdI::list_6spin_pair[3][5][2] = 5;
  StdI::list_6spin_pair[3][6][2] = 2; // type of J
  StdI::list_6spin_pair[3][0][3] = 2;
  StdI::list_6spin_pair[3][1][3] = 5;
  StdI::list_6spin_pair[3][2][3] = 0;
  StdI::list_6spin_pair[3][3][3] = 1;
  StdI::list_6spin_pair[3][4][3] = 3;
  StdI::list_6spin_pair[3][5][3] = 4;
  StdI::list_6spin_pair[3][6][3] = 2; // type of J
  StdI::list_6spin_pair[3][0][4] = 2;
  StdI::list_6spin_pair[3][1][4] = 4;
  StdI::list_6spin_pair[3][2][4] = 0;
  StdI::list_6spin_pair[3][3][4] = 1;
  StdI::list_6spin_pair[3][4][4] = 3;
  StdI::list_6spin_pair[3][5][4] = 5;
  StdI::list_6spin_pair[3][6][4] = 1; // type of J

  fprintf(fp, "# StdI::list_6spin_pair\n");
  for (ipivot = 0; ipivot < StdI::num_pivot; ipivot++) {
    fprintf(fp, "# pivot %d\n", ipivot);
    for (kintr = 0; kintr < StdI::list_6spin_star[ipivot][0]; kintr++) {
      for (isite = 0; isite < 7; isite++) {
        fprintf(fp, "%d ", StdI::list_6spin_pair[ipivot][isite][kintr]);
      }
      fprintf(fp, "\n");
    }
  }
  fclose(fp);

  for (ipivot = 0; ipivot < StdI::num_pivot; ipivot++) {
    free(StdI::list_6spin_star[ipivot]);
  }
  free(StdI::list_6spin_star);

  for (ipivot = 0; ipivot < StdI::num_pivot; ipivot++) {
    for (isite = 0; isite < 7; isite++) {
      free(StdI::list_6spin_pair[ipivot][isite]);
    }
    free(StdI::list_6spin_pair[ipivot]);
  }
  free(StdI::list_6spin_pair);

}
#endif
