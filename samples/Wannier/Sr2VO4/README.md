# Sr2VO4 : Downfolding into 2D three-band Hubbard model

Compute the Wannier function and effective interaction (U and J) with RESPACK.
Convert that result into HPhi-input.
Compute it as a 2D electron system (4 site * 3 band, 4 electrons).

First, we compute the charge density with DFT.

``` bash
$ pw.x -in scf.in
```
The pseudopotential (UPF file) are downloaded from
[Standard Solid State Pseudopotentials (SSSP)](http://materialscloud.org/sssp/)
http://materialscloud.org/sssp/pseudos/SSSP_eff_PBE.tar.gz

Then perform non-scf calculation and convert the result into RESPACK format.
``` bash
$ pw.x -in nscf.in
$ qe2respack.sh sr2cuo3.save
```

Wannierization
``` bash
$ calc_wannier < respack.in
```
Dielectric matrix
``` bash
$ calc_chiqw < respack.in
```
Coulomb potential U and Hund coupling J
``` bash
$ calc_w3d < respack.in
$ calc_j3d < respack.in
```

Convert the result into wannier90 format
``` bash
$ respack2wan90.py zvo
```

Run HPhi
``` bash
$ HPhi -s stan.in
```
