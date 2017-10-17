#!/bin/sh -e

mkdir -p fulldiag_spin_tri/
cd fulldiag_spin_tri

cat > stan.in <<EOF
a0w = 3
a0l = 0
a1w = -1
a1l = 2
model = "Spin"
method = "FullDiag"
lattice = "triangular"
J = 1.0
2Sz = 0
EOF

${MPIRUNFC} ../../src/HPhi -s stan.in

# Check value

cat > reference.dat <<EOF
  <H>         <N>        <Sz>       <S2>       <D>
  -4.500000   0.000000   0.000000  -0.000000   0.000000
  -4.500000   0.000000   0.000000   0.000000   0.000000
  -3.500000   0.000000   0.000000   2.000000   0.000000
  -3.137459   0.000000   0.000000   2.000000   0.000000
  -3.137459   0.000000   0.000000   2.000000   0.000000
  -2.500000   0.000000   0.000000  -0.000000   0.000000
  -2.500000   0.000000   0.000000   0.000000   0.000000
  -2.000000   0.000000   0.000000   2.000000   0.000000
  -2.000000   0.000000   0.000000   2.000000   0.000000
  -0.500000   0.000000   0.000000   2.000000   0.000000
  -0.500000   0.000000   0.000000   2.000000   0.000000
   0.000000   0.000000   0.000000   6.000000   0.000000
  -0.000000   0.000000   0.000000   6.000000   0.000000
   0.500000   0.000000   0.000000   4.998052   0.000000
   0.500000   0.000000   0.000000   1.001948   0.000000
   0.637459   0.000000   0.000000   2.000000   0.000000
   0.637459   0.000000   0.000000   2.000000   0.000000
   2.000000   0.000000   0.000000   6.000000   0.000000
   2.000000   0.000000   0.000000   6.000000   0.000000
   4.500000   0.000000   0.000000  12.000000   0.000000
EOF
paste output/zvo_phys_Nup3_Ndown3.dat reference.dat > paste.dat
diff=`awk 'BEGIN{diff=0.0} NR>1{diff+=sqrt(($1-$6)**2)} END{printf "%8.6f", diff}' paste.dat`
test "${diff}" = "0.000000"

exit $?
