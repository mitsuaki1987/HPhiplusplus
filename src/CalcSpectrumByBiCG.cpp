/* HPhi  -  Quantum Lattice Model Simulator */
/* Copyright (C) 2015 Takahiro Misawa, Kazuyoshi Yoshimi, Mitsuaki Kawamura, Youhei Yamaji, Synge Todo, Naoki Kawashima */

/* This program is free software: you can redistribute it and/or modify */
/* it under the terms of the GNU General Public License as published by */
/* the Free Software Foundation, either version 3 of the License, or */
/* (at your option) any later version. */

/* This program is distributed in the hope that it will be useful, */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
/* GNU General Public License for more details. */

/* You should have received a copy of the GNU General Public License */
/* along with this program.  If not, see <http://www.gnu.org/licenses/>. */
/**@file
@author Mitsuaki Kawamura (The University of Tokyo)
@brief  File for givinvg functions of calculating spectrum by Lanczos
*/
#include "FileIO.hpp"
#include "wrapperMPI.hpp"
#include "common/setmemory.hpp"
#include "mltply.hpp"
#include "CalcSpectrum.hpp"
#include "mltplyCommon.hpp"
#include "global.hpp"
#include "DefCommon.hpp"
#include "log.hpp"
#include "CalcSpectrumByBiCG.hpp"
#ifdef __MPI
#include <mpi.h>
#endif
#include <iostream>
/*
*@brief Solve Shifted equation
*/
void ShiftedEq(
  int iter,
  int Nomega,
  int NdcSpectrum,
  int *lz_conv,
  std::complex<double> *alpha,
  std::complex<double> *beta,
  std::complex<double> *dcomega,
  std::complex<double> z_seed,
  std::complex<double> **pBiCG,
  std::complex<double> **res_proj,
  std::complex<double> **pi,
  std::complex<double> **dcSpectrum
) {
  int iomega, idcSpectrum;
  std::complex<double> pi_2;

  for (iomega = 0; iomega < Nomega; iomega++) {

    if (lz_conv[iomega] == 1) continue;

    if (iter == 1)
      pi_2 = 1.0;
    else
      pi_2 = pi[iter - 2][iomega];

    pi[iter][iomega] = (1.0 + alpha[iter] * (dcomega[iomega] - z_seed)) * pi[iter - 1][iomega]
      - alpha[iter] * beta[iter] / alpha[iter - 1] * (pi_2 - pi[iter - 1][iomega]);
    for (idcSpectrum = 0; idcSpectrum < NdcSpectrum; idcSpectrum++) {
      pBiCG[iomega][idcSpectrum] = res_proj[iter][idcSpectrum] / pi[iter - 1][iomega]
        + std::pow(pi_2 / pi[iter - 1][iomega], 2) * beta[iter] * pBiCG[iomega][idcSpectrum];
      dcSpectrum[iomega][idcSpectrum] += 
        pi[iter-1][iomega] / pi[iter][iomega] * alpha[iter] * pBiCG[iomega][idcSpectrum];
    }
  }/*for (iomega = 0; iomega < Nomega; iomega++)*/
}
/**
@brief Perform Seed Switch
*/
void SeedSwitch(
  int istate,
  int iter,
  int Nomega,
  int NdcSpectrum,
  int *lz_conv,
  int *iz_seed,
  std::complex<double> *z_seed,
  std::complex<double> *rho,
  std::complex<double> *dcomega,
  long int ndim,
  std::complex<double> **v2,
  std::complex<double> **v3,
  std::complex<double> **v4,
  std::complex<double> **v5,
  std::complex<double> **pi,
  std::complex<double> *alpha,
  std::complex<double> *beta,
  std::complex<double> **res_proj
) {
  double pi_min;
  std::complex<double> pi_seed;
  int iz_seed0, iomega, jter, idcSpectrum;
  long int idim;

  pi_min = std::abs(pi[iter][0]);
  iz_seed0 = 0;
  for (iomega = 0; iomega < Nomega; iomega++) {
    if (lz_conv[iomega] == 0)
      if (std::abs(pi[iter][iomega]) < pi_min) {
        iz_seed0 = iomega;
        pi_min = std::abs(pi[iter][iomega]);
      }
  }/*for (iomega = 0; iomega < Nomega; iomega++)*/

  if (std::abs(pi[iter][iz_seed0]) < 1.0e-50) {
    printf("Error : pi at seed is 0.");
    wrapperMPI::Exit(-1);
  }

  if (iz_seed0 != *iz_seed) {

    *iz_seed = iz_seed0;
    *z_seed = dcomega[iz_seed0];

    *rho /= std::pow(pi[iter-1][iz_seed0], 2);

    for (idim = 0; idim < ndim; idim++) {
      v2[idim][istate] /= pi[iter][iz_seed0];
      v4[idim][istate] /= std::conj(pi[iter][iz_seed0]);
      v3[idim][istate] /= pi[iter-1][iz_seed0];
      v5[idim][istate] /= std::conj(pi[iter-1][iz_seed0]);
    }
    /*
    For restarting
    */
    for (jter = 1; jter <= iter; jter++) {
      alpha[jter] *= pi[jter - 1][iz_seed0] / pi[jter][iz_seed0];
      if(jter != 1)
        beta[jter] *= std::pow(pi[jter - 2][iz_seed0] / pi[jter - 1][iz_seed0], 2);
      for (idcSpectrum = 0; idcSpectrum < NdcSpectrum; idcSpectrum++) {
        res_proj[jter][idcSpectrum] /= pi[jter - 1][iz_seed0];
      }
    }

    for (jter = 1; jter <= iter; jter++) {
      pi_seed = pi[jter][iz_seed0];
      for (iomega = 0; iomega < Nomega; iomega++)
        pi[jter][iomega] /= pi_seed;
    }
  }

}/*void SeedSwitch*/
/** 
 * @brief A main function to calculate spectrum by BiCG method
 * In this function, the @f$K\omega@f$ library is used.
 * The detailed procedure is written in the document of @f$K\omega@f$.
 * https://issp-center-dev.github.io/Komega/library/en/_build/html/komega_workflow_en.html#the-schematic-workflow-of-shifted-bicg-library
 * 
 * @retval 0 normally finished
 * @retval -1 error
 *
 * @author Mitsuaki Kawamura (The University of Tokyo)
 */
int Spectrum::BiCG(
  int nstate,
  int Nomega,//!<[in] Number of Frequencies
  int NdcSpectrum,//!<[in] Number of left side operator
  std::complex<double> ***dcSpectrum,//!<[out] [Nomega] Spectrum
  std::complex<double> **dcomega,//!<[in] [Nomega] Frequency
  std::complex<double> **v1Org//!<[in] Unexcited vector
)
{
  char sdt[D_FileNameMax];
  char ctmp[256];
  long int idim, i_max;
  FILE *fp;
  size_t byte_size;
  int idcSpectrum, nstate0;
  std::complex<double> *rho, *rho_old, *z_seed, alpha_denom;
  int iomega, iter_old, istate;
  int iter, *iz_seed, **lz_conv, lz_conv_all;
  double *resnorm, dtmp[4];
  std::complex<double> **vL, **v12, **v14, **v2, **v3, **v4, **v5,
    **alpha, **beta, ***res_proj, ***pi, ***pBiCG;

  z_seed = cd_1d_allocate(nstate);
  iz_seed = i_1d_allocate(nstate);
  rho = cd_1d_allocate(nstate);
  rho_old = cd_1d_allocate(nstate);
  resnorm = d_1d_allocate(nstate);
  for (istate = 0; istate < nstate; istate++) {
    iz_seed[istate] = 0;
    z_seed[istate] = dcomega[istate][iz_seed[istate]];
    rho[istate] = 1.0;
  }
  fprintf(MP::STDOUT, "#####  Spectrum calculation with BiCG  #####\n\n");
  /**
  <ul>
  <li>Malloc vector for old residual vector (@f${\bf r}_{\rm old}@f$)
  and old shadow residual vector (@f${\bf {\tilde r}}_{\rm old}@f$).</li>
  */
  v12 = cd_2d_allocate(Check::idim_maxs, nstate);
  v14 = cd_2d_allocate(Check::idim_maxs, nstate);
  v2 = cd_2d_allocate(Check::idim_maxs, nstate);
  v3 = cd_2d_allocate(Check::idim_maxs, nstate);
  v4 = cd_2d_allocate(Check::idim_maxs, nstate);
  v5 = cd_2d_allocate(Check::idim_maxs, nstate);
  vL = cd_2d_allocate(Check::idim_maxs, nstate);
  lz_conv = i_2d_allocate(nstate, Nomega);
  /**
  <li>Set initial result vector(+shadow result vector)
  Read residual vectors if restart</li>
  */
  if (Def::iFlgCalcSpec == DC::RECALC_FROM_TMComponents_VEC ||
      Def::iFlgCalcSpec == DC::RECALC_INOUT_TMComponents_VEC) {
    fprintf(MP::STDOUT, "  Start: Input vectors for recalculation.\n");
    TimeKeeper("%s_TimeKeeper.dat", "Input vectors for recalculation starts: %s", "a");

    sprintf(sdt, "%s_recalcvec_rank_%d.dat", Def::CDataFileHead, MP::myrank);
    if (childfopenALL(sdt, "rb", &fp) != 0) {
      fprintf(MP::STDOUT, "INFO: File for the restart is not found.\n");
      fprintf(MP::STDOUT, "      Start from SCRATCH.\n");
      zclear(Check::idim_maxs * nstate, &v2[0][0]);
      GetExcitedState::main(nstate, v2, v1Org, 0);
#pragma omp parallel for default(none) shared(v2,v4,v1Org,Check::idim_maxs,nstate) \
private(idim,istate)
      for (idim = 0; idim < Check::idim_maxs; idim++) 
        for (istate = 0; istate < nstate; istate++)
          v4[idim][istate] = v2[idim][istate];
    }
    else {
      byte_size = fread(&iter_old, sizeof(int), 1, fp);
      byte_size = fread(&i_max, sizeof(i_max), 1, fp);
      if (i_max != Check::idim_maxs) {
        fprintf(stderr, "Error: The size of the input vector is incorrect.\n");
        printf("%s %ld %ld %d\n", sdt, i_max, Check::idim_maxs, iter_old);
        wrapperMPI::Exit(-1);
      }
      byte_size = fread(&nstate0, sizeof(nstate0), 1, fp);
      if (nstate0 != nstate) {
        fprintf(stderr, "Error: Input nstate is incorrect.\n");
        printf("%d %d %ld %d\n", nstate, nstate0, Check::idim_maxs, iter_old);
        wrapperMPI::Exit(-1);
      }
      byte_size = fread(&v2[0][0], sizeof(std::complex<double>), Check::idim_maxs * nstate, fp);
      byte_size = fread(&v3[0][0], sizeof(std::complex<double>), Check::idim_maxs* nstate, fp);
      byte_size = fread(&v4[0][0], sizeof(std::complex<double>), Check::idim_maxs* nstate, fp);
      byte_size = fread(&v5[0][0], sizeof(std::complex<double>), Check::idim_maxs* nstate, fp);
      fclose(fp);
      fprintf(MP::STDOUT, "  End:   Input vectors for recalculation.\n");
      TimeKeeper("%s_TimeKeeper.dat", "Input vectors for recalculation finishes: %s", "a");
      if (byte_size == 0) printf("byte_size : %d\n", (int)byte_size);
    }/*if (childfopenALL(sdt, "rb", &fp) == 0)*/
  }/*if (Def::iFlgCalcSpec > RECALC_FROM_TMComponents)*/
  else {
    zclear(Check::idim_maxs*nstate, &v2[0][0]);
    GetExcitedState::main(nstate, v2, v1Org, 0);
#pragma omp parallel for default(none) shared(v2,v4,v1Org,Check::idim_maxs,nstate) \
private(idim,istate)
    for (idim = 0; idim < Check::idim_maxs; idim++)
      for (istate = 0; istate < nstate; istate++)
        v4[idim][istate] = v2[idim][istate];
  }
  /**
  <li>Input @f$\alpha, \beta[iter]@f$, projected residual, or start from scratch</li>
  */
  iter_old = 0;
  fp = NULL;
  if (Def::iFlgCalcSpec == DC::RECALC_FROM_TMComponents ||
      Def::iFlgCalcSpec == DC::RECALC_FROM_TMComponents_VEC ||
      Def::iFlgCalcSpec == DC::RECALC_INOUT_TMComponents_VEC) {
    sprintf(sdt, "%s_TMComponents.dat", Def::CDataFileHead);
    if (childfopenALL(sdt, "rb", &fp) != 0) {
      fprintf(MP::STDOUT, "INFO: File for the restart is not found.\n");
      fprintf(MP::STDOUT, "      Start from SCRATCH.\n");
    }
    else {
      wrapperMPI::Fgets(ctmp, sizeof(ctmp) / sizeof(char), fp);
      sscanf(ctmp, "%d", &iter_old);
    }
  }
  alpha = cd_2d_allocate(nstate, iter_old + Def::Lanczos_max + 1);
  beta = cd_2d_allocate(nstate, iter_old + Def::Lanczos_max + 1);
  res_proj = cd_3d_allocate(nstate, iter_old + Def::Lanczos_max + 1, NdcSpectrum);
  pi = cd_3d_allocate(nstate, iter_old + Def::Lanczos_max + 1, Nomega);
  pBiCG = cd_3d_allocate(nstate, Nomega, NdcSpectrum);
  for (istate = 0; istate < nstate; istate++) {
    alpha[istate][0] = std::complex<double>(1.0, 0.0);
    beta[istate][0] = std::complex<double>(0.0, 0.0);
    for (iomega = 0; iomega < Nomega; iomega++) {
      pi[istate][0][iomega] = 1.0;
      for (idcSpectrum = 0; idcSpectrum < NdcSpectrum; idcSpectrum++) {
        pBiCG[istate][iomega][idcSpectrum] = 0.0;
        dcSpectrum[istate][iomega][idcSpectrum] = 0.0;
      }
    }/*for (iomega = 0; iomega < Nomega; iomega++)*/
  }/*for (istate = 0; istate < nstate; istate++)*/

  if (fp != NULL) {
    if (Def::iFlgCalcSpec == DC::RECALC_FROM_TMComponents)
      Def::Lanczos_max = 0;
    fscanf(fp, "%d%d\n", &iter_old, &nstate0);
    for (istate = 0; istate < nstate; istate++) {
      fscanf(fp, "%lf%lf\n", &dtmp[0], &dtmp[1]);
      z_seed[istate] = std::complex<double>(dtmp[0], dtmp[1]);
      for (iter = 1; iter <= iter_old; iter++) {
        fscanf(fp, "%lf%lf%lf%lf\n", &dtmp[0], &dtmp[1], &dtmp[2], &dtmp[3]);
        alpha[istate][iter] = std::complex<double>(dtmp[0], dtmp[1]);
        beta[istate][iter] = std::complex<double>(dtmp[2], dtmp[3]);
        for (idcSpectrum = 0; idcSpectrum < NdcSpectrum; idcSpectrum++) {
          fscanf(fp, "%lf %lf\n", &dtmp[0], &dtmp[1]);
          res_proj[istate][iter][idcSpectrum] = std::complex<double>(dtmp[0], dtmp[1]);
        }/*for (idcSpectrum = 0; idcSpectrum < NdcSpectrum; idcSpectrum++)*/
      }/*for (iter = 0; iter < iter_old; iter++)*/
    }/*for (istate = 0; istate < nstate; istate++)*/
    fclose(fp);

    for (iter = 1; iter <= iter_old; iter++) 
      for(istate=0;istate<nstate;istate++)
        ShiftedEq(iter, Nomega, NdcSpectrum, lz_conv[istate], alpha[istate], beta[istate], dcomega[istate],
          z_seed[istate], pBiCG[istate], res_proj[istate], pi[istate], dcSpectrum[istate]);

    wrapperMPI::MultiVecProd(Check::idim_maxs, nstate, v5, v3, rho);

    for (istate = 0; istate < nstate; istate++) {
      SeedSwitch(istate, iter, Nomega, NdcSpectrum, lz_conv[istate], &iz_seed[istate],
        &z_seed[istate], &rho[istate], dcomega[istate], Check::idim_maxs, v2, v3, v4, v5,
        pi[istate], alpha[istate], beta[istate], res_proj[istate]);
    }

    wrapperMPI::Norm_dv(Check::idim_maxs, nstate, v2, resnorm);

    for (istate = 0; istate < nstate; istate++)
      for (iomega = 0; iomega < Nomega; iomega++)
        if (std::abs(resnorm[istate] / pi[istate][iter][iomega]) < Def::eps_Lanczos)
          lz_conv[istate][idcSpectrum] = 1;
  }/*if (fp != NULL)*/
  /**
  <li>@b DO BiCG loop</li>
  <ul>
  */
  fprintf(MP::STDOUT, "    Start: Calculate tridiagonal matrix components.\n");
  TimeKeeper("%s_TimeKeeper.dat", "Calculating tridiagonal matrix components starts: %s", "a");
  fprintf(MP::STDOUT, "\n  Iteration     Seed     Residual-2-Norm\n");
  childfopenMPI("residual.dat", "w", &fp);

  for (iter = iter_old + 1; iter <= iter_old + Def::Lanczos_max; iter++) {
    /**
    <li>@f${\bf v}_{2}={\hat H}{\bf v}_{12}, {\bf v}_{4}={\hat H}{\bf v}_{14}@f$,
    where @f${\bf v}_{12}, {\bf v}_{14}@f$ are old (shadow) residual vector.</li>
    */
    zclear(Check::idim_maxs*nstate, &v12[0][0]);
    zclear(Check::idim_maxs*nstate, &v14[0][0]);
    mltply::main(nstate, v12, v2, Check::idim_maxs,
                 List::b1, List::b2_1, List::b2_2, List::Diagonals);
    mltply::main(nstate, v14, v4, Check::idim_maxs,
                 List::b1, List::b2_1, List::b2_2, List::Diagonals);
    
    for (idcSpectrum = 0; idcSpectrum < NdcSpectrum; idcSpectrum++) {
      zclear(Check::idim_maxs*nstate, &vL[0][0]);
      GetExcitedState::main(nstate, vL, v1Org, idcSpectrum + 1);
      wrapperMPI::MultiVecProd(Check::idim_maxs, nstate, vL, v2, rho_old);
      for (istate = 0; istate < nstate; istate++)res_proj[istate][iter][idcSpectrum] = rho_old[istate];
    }
    /**
    <li>Update projected result vector dcSpectrum.</li>
    */
    for (istate = 0; istate < nstate; istate++)rho_old[istate] = rho[istate];
    wrapperMPI::MultiVecProd(Check::idim_maxs, nstate, v4, v2, rho);
    for (istate = 0; istate < nstate; istate++) {
      if (iter == 1)
        beta[istate][iter] = std::complex<double>(0.0, 0.0);
      else
        beta[istate][iter] = rho[istate] / rho_old[istate];

      for (idim = 0; idim < Check::idim_maxs; idim++) {
        v12[idim][istate] = z_seed[istate] * v2[idim][istate] - v12[idim][istate];
        v14[idim][istate] = std::conj(z_seed[istate]) * v4[idim][istate] - v14[idim][istate];
      }
    }/*for (istate = 0; istate < nstate; istate++)*/

    wrapperMPI::MultiVecProd(Check::idim_maxs, nstate, v4, v12, rho_old);

    for (istate = 0; istate < nstate; istate++) {
      alpha_denom = rho_old[istate] - beta[istate][iter] * rho[istate] / alpha[istate][iter - 1];

      if (std::abs(alpha_denom) < 1.0e-50) {
        printf("Error : The denominator of alpha is zero.\n");
        wrapperMPI::Exit(-1);
      }
      else if (std::abs(rho[istate]) < 1.0e-50) {
        printf("Error : rho is zero.\n");
        wrapperMPI::Exit(-1);
      }
      alpha[istate][iter] = rho[istate] / alpha_denom;
      /*
      Shifted equation
      */
      ShiftedEq(iter, Nomega, NdcSpectrum, lz_conv[istate], alpha[istate], beta[istate], dcomega[istate],
        z_seed[istate], pBiCG[istate], res_proj[istate], pi[istate], dcSpectrum[istate]);
      /*
      Update residual
      */
      for (idim = 0; idim < Check::idim_maxs; idim++) {
        v12[idim][istate] = (1.0 + alpha[istate][iter] * beta[istate][iter] / alpha[istate][iter - 1]) * v2[idim][istate]
          - alpha[istate][iter] * v12[idim][istate]
          - alpha[istate][iter] * beta[istate][iter] / alpha[istate][iter - 1] * v3[idim][istate];
        v3[idim][istate] = v2[idim][istate];
        v2[idim][istate] = v12[idim][istate];
        v14[idim][istate] = (1.0 + std::conj(alpha[istate][iter] * beta[istate][iter] / alpha[istate][iter - 1])) * v4[idim][istate]
          - std::conj(alpha[istate][iter]) * v14[idim][istate]
          - std::conj(alpha[istate][iter] * beta[istate][iter] / alpha[istate][iter - 1]) * v5[idim][istate];
        v5[idim][istate] = v4[idim][istate];
        v4[idim][istate] = v14[idim][istate];
      }/*for (idim = 0; idim < Check::idim_maxs; idim++)*/
      /*
      Seed Switching
      */
      SeedSwitch(istate, iter, Nomega, NdcSpectrum, lz_conv[istate], &iz_seed[istate],
        &z_seed[istate], &rho[istate], dcomega[istate], Check::idim_maxs, v2, v3, v4, v5,
        pi[istate], alpha[istate], beta[istate], res_proj[istate]);
    }/*for (istate = 0; istaet < nstate; istate++)*/
    /*
    Convergence check
    */
    wrapperMPI::Norm_dv(Check::idim_maxs, nstate, v2, resnorm);
    
    lz_conv_all = 1;
    fprintf(MP::STDOUT, "  %9d  ", iter);
    for (istate = 0; istate < nstate; istate++) {
      for (iomega = 0; iomega < Nomega; iomega++) {
        if (std::abs(resnorm[istate] / pi[istate][iter][iomega]) < Def::eps_Lanczos)
          lz_conv[istate][idcSpectrum] = 1;
        lz_conv_all *= lz_conv[istate][idcSpectrum];
      }

      fprintf(MP::STDOUT, "%9d %25.15e", iz_seed[istate], resnorm[istate]);
    }/*for (istate = 0; istate < nstate; istate++)*/
    fprintf(MP::STDOUT, "\n");

    if (lz_conv_all == 1) break;
  }/*for (iter = 0; iter <= Def::Lanczos_max; iter++)*/

  if (iter >= iter_old + Def::Lanczos_max) 
    fprintf(MP::STDOUT, "Remark : Not converged in iteration %d.", iter);
  iter_old = iter;
  /**
  </ul>
  <li>@b END @b DO BiCG loop</li>
  */
  fprintf(MP::STDOUT, "    End:   Calculate tridiagonal matrix components.\n\n");
  TimeKeeper("%s_TimeKeeper.dat", "Calculating tridiagonal matrix components finishes: %s", "a");
  /**
  <li>Save @f$\alpha, \beta[iter]@f$, projected residual</li>
  */
  if (Def::iFlgCalcSpec != DC::RECALC_FROM_TMComponents) {
    sprintf(sdt, "%s_TMComponents.dat", Def::CDataFileHead);
    childfopenMPI(sdt, "w", &fp);
    fprintf(fp, "%d %d\n", iter_old, nstate);
    for (istate = 0; istate < nstate; istate++) {
      fprintf(fp, "%.10lf %.10lf\n", std::real(z_seed[istate]), std::imag(z_seed[istate]));
      for (iter = 1; iter <= iter_old; iter++) {
        fprintf(fp, "%25.16le %25.16le %25.16le %25.16le\n",
          std::real(alpha[istate][iter]), std::imag(alpha[istate][iter]),
          std::real(beta[istate][iter]), std::imag(beta[istate][iter]));
        for (idcSpectrum = 0; idcSpectrum < NdcSpectrum; idcSpectrum++)
          fprintf(fp, "%25.16le %25.16le\n",
            std::real(res_proj[istate][iter][idcSpectrum]),
            std::imag(res_proj[istate][iter][idcSpectrum]));
      }/*for (iter = 0; iter < iter_old; iter++)*/
    }/*for (istate = 0; istate < nstate; istate++)*/
    fclose(fp);
  }/*if (Def::iFlgCalcSpec != DC::RECALC_FROM_TMComponents)*/
  /**
  <li>output vectors for recalculation</li>
  </ul>
  */
  if (Def::iFlgCalcSpec == DC::RECALC_OUTPUT_TMComponents_VEC ||
      Def::iFlgCalcSpec == DC::RECALC_INOUT_TMComponents_VEC) {
    fprintf(MP::STDOUT, "    Start: Output vectors for recalculation.\n");
    TimeKeeper("%s_TimeKeeper.dat", "Output vectors for recalculation starts: %s", "a");
    sprintf(sdt, "%s_recalcvec_rank_%d.dat", Def::CDataFileHead, MP::myrank);
    if (childfopenALL(sdt, "wb", &fp) != 0) {
      wrapperMPI::Exit(-1);
    }
    byte_size = fwrite(&iter, sizeof(iter), 1, fp);
    byte_size = fwrite(&Check::idim_maxs, sizeof(Check::idim_maxs), 1, fp);
    byte_size = fwrite(&nstate, sizeof(nstate), 1, fp);
    byte_size = fwrite(&v2[0][0], sizeof(std::complex<double>), Check::idim_maxs * nstate, fp);
    byte_size = fwrite(&v3[0][0], sizeof(std::complex<double>), Check::idim_maxs * nstate, fp);
    byte_size = fwrite(&v4[0][0], sizeof(std::complex<double>), Check::idim_maxs * nstate, fp);
    byte_size = fwrite(&v5[0][0], sizeof(std::complex<double>), Check::idim_maxs * nstate, fp);
    fclose(fp);

    fprintf(MP::STDOUT, "    End:   Output vectors for recalculation.\n");
    TimeKeeper("%s_TimeKeeper.dat", "Output vectors for recalculation finishes: %s", "a");
  }/*if (Def::iFlgCalcSpec > RECALC_FROM_TMComponents)*/

  free_cd_2d_allocate(alpha);
  free_cd_2d_allocate(beta);
  free_cd_3d_allocate(res_proj);  
  free_cd_3d_allocate(pi);
  free_cd_3d_allocate(pBiCG);
  free_cd_2d_allocate(v3);
  free_cd_2d_allocate(v5);
  free_cd_2d_allocate(v12);
  free_cd_2d_allocate(v14);
  free_cd_2d_allocate(vL);
  free_cd_1d_allocate(z_seed);
  free_i_1d_allocate(iz_seed);
  free_cd_1d_allocate(rho);
  free_cd_1d_allocate(rho_old);
  free_d_1d_allocate(resnorm);
  return TRUE;
}/*int CalcSpectrumByBiCG*/
