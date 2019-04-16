#!/bin/sh -e

mkdir -p lobcg_genspingc_ladder/
cd lobcg_genspingc_ladder

cat > stan.in <<EOF
L = 2
W = 2
model = "SpinGC"
method = "CG"
lattice = "ladder"
J0 = 1.0
J1 = 1.0
2S = 3
h=0.01
exct = 3
EOF

${MPIRUN} ../../src/HPhi++ -s stan.in

# Check value

cat > reference.dat <<EOF
 0
  -18.3623620055432717
  0.0000000000000000
  -0.0000000000000000

 1
  -16.8265118261059037
  0.0000000000000000
  0.9999999999999948

 2
  -16.8165118261057955
  0.0000000000000000
  -0.0000000000000047
EOF
paste output/zvo_energy.dat reference.dat > paste1.dat
diff=`awk '
BEGIN{diff=0.0}
{diff+=sqrt(($2-$3)*($2-$3))}
END{printf "%8.6f", diff}
' paste1.dat`
echo "Diff output/zvo_energy.dat : " ${diff}
test "${diff}" = "0.000000"

# Check one-body G

cat > reference.dat <<EOF
   0.2500000000 0.0000000000
   0.2500000000 0.0000000000
   0.2500000000 0.0000000000
   0.2500000000 0.0000000000
   0.2500000000 0.0000000000
   0.2500000000 0.0000000000
   0.2500000000 0.0000000000
   0.2500000000 0.0000000000
EOF
paste output/zvo_cisajs_eigen0.dat reference.dat > paste2.dat
diff=`awk '
BEGIN{diff=0.0} 
{diff+=sqrt(($5-$7)*($5-$7)+($6-$8)*($6-$8))}
END{printf "%8.6f", diff/NR}
' paste2.dat`
echo "Diff output/zvo_cisajs_eigen0.dat : " ${diff}
test "${diff}" = "0.000000"

cat > reference.dat <<EOF
   0.1027203289 0.0000000000
   0.2972796694 0.0000000000
   0.3472796705 0.0000000000
   0.2527203312 0.0000000000
   0.1027203300 0.0000000000
   0.2972796715 0.0000000000
   0.3472796702 0.0000000000
   0.2527203283 0.0000000000
EOF
paste output/zvo_cisajs_eigen1.dat reference.dat > paste3.dat
diff=`awk '
BEGIN{diff=0.0} 
{diff+=sqrt(($5-$7)*($5-$7)+($6-$8)*($6-$8))}
END{printf "%8.6f", diff/NR}
' paste3.dat`
echo "Diff output/zvo_cisajs_eigen1.dat : " ${diff}
test "${diff}" = "0.000000"

cat > reference.dat <<EOF
   0.3945593568 0.0000000000
   0.1054406687 0.0000000000
   0.1054406784 0.0000000000
   0.3945592962 0.0000000000
   0.3945593257 0.0000000000
   0.1054406506 0.0000000000
   0.1054406484 0.0000000000
   0.3945593753 0.0000000000
EOF
paste output/zvo_cisajs_eigen2.dat reference.dat > paste4.dat
diff=`awk '
BEGIN{diff=0.0} 
{diff+=sqrt(($5-$7)*($5-$7)+($6-$8)*($6-$8))}
END{printf "%8.6f", diff/NR}
' paste4.dat`
echo "Diff output/zvo_cisajs_eigen2.dat : " ${diff}
test "${diff}" = "0.000000"

# Check two-body G

cat > reference.dat <<EOF
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0029816022 0.0000000000
   0.0210353538 0.0000000000
   0.0680537517 0.0000000000
   0.1579292923 0.0000000000
   0.0000232977 0.0000000000
   0.0023743004 0.0000000000
   0.0390878229 0.0000000000
   0.2085145789 0.0000000000
   0.1368706408 0.0000000000
   0.0724290908 0.0000000000
   0.0315543133 0.0000000000
   0.0091459551 0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   -0.0180537517 0.0000000000
   -0.0542921693 0.0000000000
   -0.0898755407 0.0000000000
   -0.0023510027 0.0000000000
   -0.0423931242 0.0000000000
   -0.1694267560 0.0000000000
   0.0644415500 0.0000000000
   0.0471981276 0.0000000000
   0.0224083582 0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   0.0289646462 -0.0000000000
   0.0428571429 -0.0000000000
   0.0343625199 -0.0000000000
   0.1327132335 -0.0000000000
   0.0235667725 0.0000000000
   0.0184664193 0.0000000000
   0.2500000000 0.0000000000
   -0.0138924967 0.0000000000
   -0.0983507136 0.0000000000
   0.0051003531 0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   -0.0180537517 -0.0000000000
   -0.0542921693 -0.0000000000
   -0.0898755407 -0.0000000000
   -0.0023510027 -0.0000000000
   -0.0423931242 -0.0000000000
   -0.1694267560 -0.0000000000
   0.0644415500 -0.0000000000
   0.0471981276 -0.0000000000
   0.0224083582 -0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0210353538 0.0000000000
   0.0656727993 0.0000000000
   0.0952380952 0.0000000000
   0.0680537517 0.0000000000
   0.0023743004 0.0000000000
   0.0489746611 0.0000000000
   0.1595632155 0.0000000000
   0.0390878229 0.0000000000
   0.0724290908 0.0000000000
   0.0823709374 0.0000000000
   0.0636456585 0.0000000000
   0.0315543133 0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   -0.0542921693 0.0000000000
   -0.0765836938 0.0000000000
   -0.0542921693 0.0000000000
   -0.0423931242 0.0000000000
   -0.1473020770 0.0000000000
   -0.0423931242 0.0000000000
   0.0471981276 0.0000000000
   0.0596000565 0.0000000000
   0.0471981276 0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   0.0428571429 -0.0000000000
   0.0289646462 -0.0000000000
   0.1327132335 -0.0000000000
   0.0343625199 -0.0000000000
   0.0184664193 0.0000000000
   0.0235667725 0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   0.0289646462 0.0000000000
   0.0428571429 0.0000000000
   0.0343625199 0.0000000000
   0.1327132335 0.0000000000
   0.0235667725 -0.0000000000
   0.0184664193 -0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   -0.0542921693 -0.0000000000
   -0.0765836938 -0.0000000000
   -0.0542921693 -0.0000000000
   -0.0423931242 -0.0000000000
   -0.1473020770 -0.0000000000
   -0.0423931242 -0.0000000000
   0.0471981276 -0.0000000000
   0.0596000565 -0.0000000000
   0.0471981276 -0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   0.0680537517 0.0000000000
   0.0952380952 0.0000000000
   0.0656727993 0.0000000000
   0.0210353538 0.0000000000
   0.0390878229 0.0000000000
   0.1595632155 0.0000000000
   0.0489746611 0.0000000000
   0.0023743004 0.0000000000
   0.0315543133 0.0000000000
   0.0636456585 0.0000000000
   0.0823709374 0.0000000000
   0.0724290908 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   -0.0898755407 0.0000000000
   -0.0542921693 0.0000000000
   -0.0180537517 0.0000000000
   -0.1694267560 0.0000000000
   -0.0423931242 0.0000000000
   -0.0023510027 0.0000000000
   0.0224083582 0.0000000000
   0.0471981276 0.0000000000
   0.0644415500 0.0000000000
   0.2500000000 0.0000000000
   -0.0138924967 -0.0000000000
   -0.0983507136 -0.0000000000
   0.0051003531 -0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   0.0428571429 0.0000000000
   0.0289646462 0.0000000000
   0.1327132335 0.0000000000
   0.0343625199 0.0000000000
   0.0184664193 -0.0000000000
   0.0235667725 -0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   -0.0898755407 -0.0000000000
   -0.0542921693 -0.0000000000
   -0.0180537517 -0.0000000000
   -0.1694267560 -0.0000000000
   -0.0423931242 -0.0000000000
   -0.0023510027 -0.0000000000
   0.0224083582 -0.0000000000
   0.0471981276 -0.0000000000
   0.0644415500 -0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   0.1579292923 0.0000000000
   0.0680537517 0.0000000000
   0.0210353538 0.0000000000
   0.0029816022 0.0000000000
   0.2085145789 0.0000000000
   0.0390878229 0.0000000000
   0.0023743004 0.0000000000
   0.0000232977 0.0000000000
   0.0091459551 0.0000000000
   0.0315543133 0.0000000000
   0.0724290908 0.0000000000
   0.1368706408 0.0000000000
   0.0029816022 0.0000000000
   0.0210353538 0.0000000000
   0.0680537517 0.0000000000
   0.1579292923 0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.1368706408 0.0000000000
   0.0724290908 0.0000000000
   0.0315543133 0.0000000000
   0.0091459551 0.0000000000
   0.0000232977 0.0000000000
   0.0023743004 0.0000000000
   0.0390878229 0.0000000000
   0.2085145789 0.0000000000
   -0.0180537517 -0.0000000000
   -0.0542921693 -0.0000000000
   -0.0898755407 -0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0644415500 -0.0000000000
   0.0471981276 0.0000000000
   0.0224083582 0.0000000000
   -0.0023510027 -0.0000000000
   -0.0423931242 -0.0000000000
   -0.1694267560 -0.0000000000
   0.0289646462 0.0000000000
   0.0428571429 0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   0.0235667725 -0.0000000000
   0.0184664193 0.0000000000
   0.0343625199 0.0000000000
   0.1327132335 0.0000000000
   -0.0138924967 -0.0000000000
   0.2500000000 0.0000000000
   0.0051003531 0.0000000000
   -0.0983507136 -0.0000000000
   -0.0180537517 0.0000000000
   -0.0542921693 0.0000000000
   -0.0898755407 0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0644415500 0.0000000000
   0.0471981276 -0.0000000000
   0.0224083582 -0.0000000000
   -0.0023510027 0.0000000000
   -0.0423931242 0.0000000000
   -0.1694267560 0.0000000000
   0.0210353538 0.0000000000
   0.0656727993 0.0000000000
   0.0952380952 0.0000000000
   0.0680537517 0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0724290908 0.0000000000
   0.0823709374 0.0000000000
   0.0636456585 0.0000000000
   0.0315543133 0.0000000000
   0.0023743004 0.0000000000
   0.0489746611 0.0000000000
   0.1595632155 0.0000000000
   0.0390878229 0.0000000000
   -0.0542921693 -0.0000000000
   -0.0765836938 -0.0000000000
   -0.0542921693 -0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   0.0471981276 -0.0000000000
   0.0596000565 -0.0000000000
   0.0471981276 -0.0000000000
   -0.0423931242 -0.0000000000
   -0.1473020770 -0.0000000000
   -0.0423931242 -0.0000000000
   0.0428571429 0.0000000000
   0.0289646462 0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   0.0184664193 0.0000000000
   0.0235667725 -0.0000000000
   0.1327132335 0.0000000000
   0.0343625199 0.0000000000
   0.0289646462 -0.0000000000
   0.0428571429 -0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   0.0235667725 0.0000000000
   0.0184664193 -0.0000000000
   0.0343625199 -0.0000000000
   0.1327132335 -0.0000000000
   -0.0542921693 0.0000000000
   -0.0765836938 0.0000000000
   -0.0542921693 0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   0.0471981276 0.0000000000
   0.0596000565 0.0000000000
   0.0471981276 0.0000000000
   -0.0423931242 0.0000000000
   -0.1473020770 0.0000000000
   -0.0423931242 0.0000000000
   0.0680537517 0.0000000000
   0.0952380952 0.0000000000
   0.0656727993 0.0000000000
   0.0210353538 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   0.0000000000 0.0000000000
   0.0315543133 0.0000000000
   0.0636456585 0.0000000000
   0.0823709374 0.0000000000
   0.0724290908 0.0000000000
   0.0390878229 0.0000000000
   0.1595632155 0.0000000000
   0.0489746611 0.0000000000
   0.0023743004 0.0000000000
   -0.0898755407 -0.0000000000
   -0.0542921693 -0.0000000000
   -0.0180537517 -0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   0.0224083582 -0.0000000000
   0.0471981276 -0.0000000000
   0.0644415500 -0.0000000000
   -0.1694267560 -0.0000000000
   -0.0423931242 -0.0000000000
   -0.0023510027 -0.0000000000
   -0.0138924967 0.0000000000
   0.2500000000 0.0000000000
   0.0051003531 -0.0000000000
   -0.0983507136 0.0000000000
   0.0428571429 -0.0000000000
   0.0289646462 -0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   0.0184664193 -0.0000000000
   0.0235667725 0.0000000000
   0.1327132335 -0.0000000000
   0.0343625199 -0.0000000000
   -0.0898755407 0.0000000000
   -0.0542921693 0.0000000000
   -0.0180537517 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   0.0224083582 0.0000000000
   0.0471981276 0.0000000000
   0.0644415500 0.0000000000
   -0.1694267560 0.0000000000
   -0.0423931242 0.0000000000
   -0.0023510027 0.0000000000
   0.1579292923 0.0000000000
   0.0680537517 0.0000000000
   0.0210353538 0.0000000000
   0.0029816022 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.2500000000 0.0000000000
   0.0091459551 0.0000000000
   0.0315543133 0.0000000000
   0.0724290908 0.0000000000
   0.1368706408 0.0000000000
   0.2085145789 0.0000000000
   0.0390878229 0.0000000000
   0.0023743004 0.0000000000
   0.0000232977 0.0000000000
EOF
paste output/zvo_cisajscktalt_eigen0.dat reference.dat > paste5.dat
diff=`awk '
BEGIN{diff=0.0} 
{diff+=sqrt(($9-$11)*($9-$11)+($10-$12)*($10-$12))}
END{printf "%8.6f", diff/NR}
' paste5.dat`
echo "Diff output/zvo_cisajscktalt_eigen0.dat : " ${diff}
test "${diff}" = "0.000000"

cat > reference.dat <<EOF
   0.1027203289 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0080796905 0.0000000000
   0.0346071297 0.0000000000
   0.0600335087 0.0000000000
   0.0000000000 0.0000000000
   0.0003219640 0.0000000000
   0.0128031963 0.0000000000
   0.0895951686 0.0000000000
   0.0000000000 0.0000000000
   0.0516661580 0.0000000000
   0.0378947068 0.0000000000
   0.0131594641 0.0000000000
   0.1027203289 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   -0.0080796905 0.0000000000
   -0.0409844179 0.0000000001
   -0.0748970883 0.0000000001
   -0.0003219640 -0.0000000000
   -0.0154850514 0.0000000000
   -0.1082788476 -0.0000000001
   0.0516661581 -0.0000000001
   0.0596589406 -0.0000000001
   0.0335082189 -0.0000000001
   0.1027203289 0.0000000000
   0.0000000000 0.0000000000
   0.0238342091 0.0000000000
   0.0477409984 -0.0000000000
   0.0123739110 0.0000000000
   0.1003407824 0.0000000002
   0.0309935040 -0.0000000001
   0.0283323168 -0.0000000000
   0.1027203289 0.0000000000
   -0.0162025049 -0.0000000000
   -0.0707123388 -0.0000000003
   0.0079835620 -0.0000000000
   0.2972796694 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   -0.0080796905 -0.0000000000
   -0.0409844179 -0.0000000001
   -0.0748970883 -0.0000000001
   -0.0003219640 0.0000000000
   -0.0154850514 -0.0000000000
   -0.1082788476 0.0000000001
   0.0516661581 0.0000000001
   0.0596589406 0.0000000001
   0.0335082189 0.0000000001
   0.0000000000 0.0000000000
   0.2972796694 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0080796905 0.0000000000
   0.0574840532 0.0000000000
   0.1185376434 0.0000000000
   0.1131782823 0.0000000000
   0.0003219640 0.0000000000
   0.0190480039 0.0000000000
   0.1377556680 0.0000000000
   0.1401540336 0.0000000000
   0.0516661582 0.0000000000
   0.1033323164 0.0000000000
   0.0956135118 0.0000000000
   0.0466676831 0.0000000000
   0.0000000000 0.0000000000
   0.2972796694 0.0000000000
   0.0000000000 0.0000000000
   -0.0409844180 -0.0000000001
   -0.1017127216 -0.0000000001
   -0.0998007294 -0.0000000000
   -0.0154850515 -0.0000000000
   -0.1344186219 -0.0000000002
   -0.1498324041 -0.0000000003
   0.0596589407 -0.0000000000
   0.0904376097 -0.0000000000
   0.0714073001 -0.0000000000
   0.0000000000 0.0000000000
   0.2972796694 0.0000000000
   0.0477409987 0.0000000001
   0.0525223565 0.0000000000
   0.1003407830 0.0000000003
   0.1179341572 0.0000000002
   0.0283323168 -0.0000000001
   0.0363158789 -0.0000000001
   0.3472796705 0.0000000000
   0.0000000000 0.0000000000
   0.0238342091 -0.0000000000
   0.0477409984 0.0000000000
   0.0123739110 -0.0000000000
   0.1003407824 -0.0000000002
   0.0309935040 0.0000000001
   0.0283323168 0.0000000000
   0.0000000000 0.0000000000
   0.3472796705 0.0000000000
   0.0000000000 0.0000000000
   -0.0409844180 0.0000000001
   -0.1017127216 0.0000000001
   -0.0998007294 0.0000000000
   -0.0154850515 0.0000000000
   -0.1344186219 0.0000000002
   -0.1498324041 0.0000000003
   0.0596589407 0.0000000000
   0.0904376097 0.0000000000
   0.0714073001 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.3472796705 0.0000000000
   0.0000000000 0.0000000000
   0.0346071299 0.0000000000
   0.1185376440 0.0000000000
   0.1307857403 0.0000000000
   0.0633491563 0.0000000000
   0.0128031964 0.0000000000
   0.1377556687 0.0000000000
   0.1743936073 0.0000000000
   0.0223271981 0.0000000000
   0.0378947069 0.0000000000
   0.0956135118 0.0000000000
   0.1242105860 0.0000000000
   0.0895608659 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.3472796705 0.0000000000
   -0.0748970891 -0.0000000001
   -0.0998007300 0.0000000000
   -0.0525762358 0.0000000001
   -0.1082788487 -0.0000000001
   -0.1498324048 -0.0000000000
   -0.0218979128 0.0000000000
   0.0335082189 -0.0000000001
   0.0714073002 -0.0000000001
   0.0826596631 -0.0000000001
   0.2527203312 0.0000000000
   -0.0162025049 0.0000000000
   -0.0707123388 0.0000000003
   0.0079835620 0.0000000000
   0.0000000000 0.0000000000
   0.2527203312 0.0000000000
   0.0477409987 -0.0000000001
   0.0525223565 -0.0000000000
   0.1003407830 -0.0000000003
   0.1179341572 -0.0000000002
   0.0283323168 0.0000000001
   0.0363158789 0.0000000001
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.2527203312 0.0000000000
   -0.0748970891 0.0000000001
   -0.0998007300 -0.0000000000
   -0.0525762358 -0.0000000001
   -0.1082788487 0.0000000001
   -0.1498324048 0.0000000000
   -0.0218979128 -0.0000000000
   0.0335082189 0.0000000001
   0.0714073002 0.0000000001
   0.0826596631 0.0000000001
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.2527203312 0.0000000000
   0.0600335096 0.0000000000
   0.1131782837 0.0000000000
   0.0633491568 0.0000000000
   0.0161593811 0.0000000000
   0.0895951699 0.0000000000
   0.1401540349 0.0000000000
   0.0223271983 0.0000000000
   0.0006439280 0.0000000000
   0.0131594641 0.0000000000
   0.0466676833 0.0000000000
   0.0895608660 0.0000000000
   0.1033323178 0.0000000000
   0.0000000000 0.0000000000
   0.0080796905 0.0000000000
   0.0346071299 0.0000000000
   0.0600335096 0.0000000000
   0.1027203300 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0516661589 0.0000000000
   0.0378947071 0.0000000000
   0.0131594641 0.0000000000
   0.0000000000 0.0000000000
   0.0003219640 0.0000000000
   0.0128031963 0.0000000000
   0.0895951697 0.0000000000
   -0.0080796905 -0.0000000000
   -0.0409844180 0.0000000001
   -0.0748970891 0.0000000001
   0.1027203300 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0516661589 0.0000000000
   0.0596589412 -0.0000000000
   0.0335082189 -0.0000000000
   -0.0003219640 0.0000000000
   -0.0154850514 0.0000000000
   -0.1082788486 0.0000000002
   0.0238342091 -0.0000000000
   0.0477409987 -0.0000000001
   0.1027203300 0.0000000000
   0.0000000000 0.0000000000
   0.0309935043 0.0000000000
   0.0283323168 0.0000000000
   0.0123739109 -0.0000000000
   0.1003407830 -0.0000000003
   -0.0162025049 0.0000000000
   0.1027203300 0.0000000000
   0.0079835620 0.0000000000
   -0.0707123388 0.0000000003
   -0.0080796905 0.0000000000
   -0.0409844180 -0.0000000001
   -0.0748970891 -0.0000000001
   0.2972796715 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0516661589 -0.0000000000
   0.0596589412 0.0000000000
   0.0335082189 0.0000000000
   -0.0003219640 -0.0000000000
   -0.0154850514 -0.0000000000
   -0.1082788486 -0.0000000002
   0.0080796905 0.0000000000
   0.0574840532 0.0000000000
   0.1185376440 0.0000000000
   0.1131782837 0.0000000000
   0.0000000000 0.0000000000
   0.2972796715 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0516661589 0.0000000000
   0.1033323175 0.0000000000
   0.0956135120 0.0000000000
   0.0466676830 0.0000000000
   0.0003219640 0.0000000000
   0.0190480039 0.0000000000
   0.1377556688 0.0000000000
   0.1401540348 0.0000000000
   -0.0409844179 -0.0000000001
   -0.1017127216 0.0000000001
   -0.0998007300 -0.0000000000
   0.0000000000 0.0000000000
   0.2972796715 0.0000000000
   0.0000000000 0.0000000000
   0.0596589413 0.0000000001
   0.0904376100 0.0000000001
   0.0714072999 0.0000000001
   -0.0154850514 0.0000000000
   -0.1344186221 0.0000000002
   -0.1498324048 0.0000000001
   0.0477409984 0.0000000000
   0.0525223565 -0.0000000000
   0.0000000000 0.0000000000
   0.2972796715 0.0000000000
   0.0283323170 0.0000000001
   0.0363158788 0.0000000001
   0.1003407826 -0.0000000002
   0.1179341571 -0.0000000001
   0.0238342091 0.0000000000
   0.0477409987 0.0000000001
   0.3472796702 0.0000000000
   0.0000000000 0.0000000000
   0.0309935043 -0.0000000000
   0.0283323168 -0.0000000000
   0.0123739109 0.0000000000
   0.1003407830 0.0000000003
   -0.0409844179 0.0000000001
   -0.1017127216 -0.0000000001
   -0.0998007300 0.0000000000
   0.0000000000 0.0000000000
   0.3472796702 0.0000000000
   0.0000000000 0.0000000000
   0.0596589413 -0.0000000001
   0.0904376100 -0.0000000001
   0.0714072999 -0.0000000001
   -0.0154850514 -0.0000000000
   -0.1344186221 -0.0000000002
   -0.1498324048 -0.0000000001
   0.0346071297 0.0000000000
   0.1185376434 0.0000000000
   0.1307857403 0.0000000000
   0.0633491568 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.3472796702 0.0000000000
   0.0000000000 0.0000000000
   0.0378947072 0.0000000000
   0.0956135122 0.0000000000
   0.1242105857 0.0000000000
   0.0895608650 0.0000000000
   0.0128031963 0.0000000000
   0.1377556683 0.0000000000
   0.1743936072 0.0000000000
   0.0223271983 0.0000000000
   -0.0748970883 -0.0000000001
   -0.0998007294 0.0000000000
   -0.0525762358 -0.0000000001
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.3472796702 0.0000000000
   0.0335082191 0.0000000001
   0.0714072999 0.0000000001
   0.0826596622 0.0000000001
   -0.1082788479 0.0000000001
   -0.1498324039 0.0000000000
   -0.0218979129 -0.0000000000
   -0.0162025049 -0.0000000000
   0.2527203283 0.0000000000
   0.0079835620 -0.0000000000
   -0.0707123388 -0.0000000003
   0.0477409984 -0.0000000000
   0.0525223565 0.0000000000
   0.0000000000 0.0000000000
   0.2527203283 0.0000000000
   0.0283323170 -0.0000000001
   0.0363158788 -0.0000000001
   0.1003407826 0.0000000002
   0.1179341571 0.0000000001
   -0.0748970883 0.0000000001
   -0.0998007294 -0.0000000000
   -0.0525762358 0.0000000001
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.2527203283 0.0000000000
   0.0335082191 -0.0000000001
   0.0714072999 -0.0000000001
   0.0826596622 -0.0000000001
   -0.1082788479 -0.0000000001
   -0.1498324039 -0.0000000000
   -0.0218979129 0.0000000000
   0.0600335087 0.0000000000
   0.1131782823 0.0000000000
   0.0633491563 0.0000000000
   0.0161593811 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.2527203283 0.0000000000
   0.0131594642 0.0000000000
   0.0466676830 0.0000000000
   0.0895608650 0.0000000000
   0.1033323162 0.0000000000
   0.0895951689 0.0000000000
   0.1401540332 0.0000000000
   0.0223271982 0.0000000000
   0.0006439280 0.0000000000
EOF
paste output/zvo_cisajscktalt_eigen1.dat reference.dat > paste6.dat
diff=`awk '
BEGIN{diff=0.0} 
{diff+=sqrt(($9-$11)*($9-$11)+($10-$12)*($10-$12))}
END{printf "%8.6f", diff/NR}
' paste6.dat`
echo "Diff output/zvo_cisajscktalt_eigen1.dat : " ${diff}
test "${diff}" = "0.000000"

cat > reference.dat <<EOF
   0.3945593568 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0053864577 0.0000000000
   0.0628705057 0.0000000000
   0.3263023933 0.0000000000
   0.0000000000 0.0000000000
   0.0002146425 0.0000000000
   0.0192626425 0.0000000000
   0.3750820718 0.0000000000
   0.3099969793 0.0000000000
   0.0757894063 0.0000000000
   0.0087729712 0.0000000000
   0.0000000000 0.0000000000
   0.3945593568 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   -0.0000000005 0.0000000020
   -0.0137606838 0.0000000070
   -0.0859192847 0.0000000092
   -0.0000000001 0.0000000000
   -0.0071440798 -0.0000000011
   -0.1654948253 -0.0000000063
   0.0619870078 -0.0000000021
   0.0117483544 -0.0000000000
   0.0000000000 0.0000000000
   0.3945593568 0.0000000000
   0.0000000000 0.0000000000
   -0.0031718713 -0.0000000053
   0.0063908426 -0.0000000055
   -0.0031718697 0.0000000020
   0.0320148921 0.0000000079
   0.0053223735 -0.0000000002
   0.0000000000 0.0000000000
   0.3945593568 0.0000000000
   0.0037168646 0.0000000016
   0.0358644012 -0.0000000008
   0.0000000000 0.0000000000
   0.1054406687 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   -0.0000000005 -0.0000000020
   -0.0137606838 -0.0000000070
   -0.0859192847 -0.0000000092
   -0.0000000001 -0.0000000000
   -0.0071440798 0.0000000011
   -0.1654948253 0.0000000063
   0.0619870078 0.0000000021
   0.0117483544 0.0000000000
   0.0000000000 -0.0000000000
   0.0000000000 0.0000000000
   0.1054406687 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0053864642 0.0000000000
   0.0063437474 0.0000000000
   0.0308399377 0.0000000000
   0.0628705194 0.0000000000
   0.0002146429 0.0000000000
   0.0063437477 0.0000000000
   0.0796196311 0.0000000000
   0.0192626470 0.0000000000
   0.0757894215 0.0000000000
   0.0208782651 0.0000000000
   0.0000000000 0.0000000000
   0.0087729821 0.0000000000
   0.0000000000 0.0000000000
   0.1054406687 0.0000000000
   0.0000000000 0.0000000000
   -0.0137606938 0.0000000026
   -0.0037168653 0.0000000015
   -0.0137606902 0.0000000013
   -0.0071440849 -0.0000000001
   -0.0358644472 0.0000000015
   -0.0071440827 0.0000000016
   0.0117483599 -0.0000000006
   0.0000000000 -0.0000000000
   0.0117483644 -0.0000000002
   0.0000000000 0.0000000000
   0.1054406687 0.0000000000
   0.0063908472 0.0000000004
   -0.0031718706 0.0000000011
   0.0320149017 -0.0000000133
   -0.0031718697 -0.0000000033
   0.0000000000 0.0000000000
   0.0053223758 0.0000000001
   0.1054406784 0.0000000000
   0.0000000000 0.0000000000
   -0.0031718713 0.0000000053
   0.0063908426 0.0000000055
   -0.0031718697 -0.0000000020
   0.0320148921 -0.0000000079
   0.0053223735 0.0000000002
   0.0000000000 -0.0000000000
   0.0000000000 0.0000000000
   0.1054406784 0.0000000000
   0.0000000000 0.0000000000
   -0.0137606938 -0.0000000026
   -0.0037168653 -0.0000000015
   -0.0137606902 -0.0000000013
   -0.0071440849 0.0000000001
   -0.0358644472 -0.0000000015
   -0.0071440827 -0.0000000016
   0.0117483599 0.0000000006
   0.0000000000 0.0000000000
   0.0117483644 0.0000000002
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.1054406784 0.0000000000
   0.0000000000 0.0000000000
   0.0628705229 0.0000000000
   0.0308399453 0.0000000000
   0.0063437475 0.0000000000
   0.0053864626 0.0000000000
   0.0192626498 0.0000000000
   0.0796196382 0.0000000000
   0.0063437477 0.0000000000
   0.0002146426 0.0000000000
   0.0087729792 0.0000000000
   0.0000000000 0.0000000000
   0.0208782737 0.0000000000
   0.0757894255 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.1054406784 0.0000000000
   -0.0859192859 -0.0000000027
   -0.0137606867 -0.0000000038
   -0.0000000005 -0.0000000019
   -0.1654948219 0.0000000154
   -0.0071440821 0.0000000025
   -0.0000000001 0.0000000002
   0.0000000000 0.0000000000
   0.0117483582 0.0000000004
   0.0619870096 0.0000000005
   0.3945592962 0.0000000000
   0.0037168646 -0.0000000016
   0.0358644012 0.0000000008
   0.0000000000 -0.0000000000
   0.0000000000 0.0000000000
   0.3945592962 0.0000000000
   0.0063908472 -0.0000000004
   -0.0031718706 -0.0000000011
   0.0320149017 0.0000000133
   -0.0031718697 0.0000000033
   0.0000000000 -0.0000000000
   0.0053223758 -0.0000000001
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.3945592962 0.0000000000
   -0.0859192859 0.0000000027
   -0.0137606867 0.0000000038
   -0.0000000005 0.0000000019
   -0.1654948219 -0.0000000154
   -0.0071440821 -0.0000000025
   -0.0000000001 -0.0000000002
   0.0000000000 -0.0000000000
   0.0117483582 -0.0000000004
   0.0619870096 -0.0000000005
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.3945592962 0.0000000000
   0.3263023386 0.0000000000
   0.0628705002 0.0000000000
   0.0053864574 0.0000000000
   0.0000000000 0.0000000000
   0.3750820084 0.0000000000
   0.0192626450 0.0000000000
   0.0002146427 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0087729722 0.0000000000
   0.0757894011 0.0000000000
   0.3099969229 0.0000000000
   0.0000000000 0.0000000000
   0.0053864642 0.0000000000
   0.0628705229 0.0000000000
   0.3263023386 0.0000000000
   0.3945593257 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.3099969229 0.0000000000
   0.0757894222 0.0000000000
   0.0087729807 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0002146427 0.0000000000
   0.0192626467 0.0000000000
   0.3750820363 0.0000000000
   -0.0000000005 -0.0000000020
   -0.0137606938 -0.0000000026
   -0.0859192859 0.0000000027
   0.3945593257 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0619870096 -0.0000000090
   0.0117483634 -0.0000000030
   0.0000000000 0.0000000000
   0.0000000001 -0.0000000002
   -0.0071440790 -0.0000000015
   -0.1654948028 0.0000000035
   -0.0031718713 0.0000000053
   0.0063908472 -0.0000000004
   0.3945593257 0.0000000000
   0.0000000000 0.0000000000
   0.0053223759 -0.0000000035
   0.0000000000 0.0000000000
   -0.0031718764 0.0000000031
   0.0320148556 -0.0000000053
   0.0037168646 -0.0000000016
   0.3945593257 0.0000000000
   0.0000000000 0.0000000000
   0.0358644619 -0.0000000018
   -0.0000000005 0.0000000020
   -0.0137606938 0.0000000026
   -0.0859192859 -0.0000000027
   0.1054406506 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0619870096 0.0000000090
   0.0117483634 0.0000000030
   0.0000000000 -0.0000000000
   0.0000000001 0.0000000002
   -0.0071440790 0.0000000015
   -0.1654948028 -0.0000000035
   0.0053864577 0.0000000000
   0.0063437474 0.0000000000
   0.0308399453 0.0000000000
   0.0628705002 0.0000000000
   0.0000000000 0.0000000000
   0.1054406506 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0757894044 0.0000000000
   0.0208782735 0.0000000000
   0.0000000000 0.0000000000
   0.0087729727 0.0000000000
   0.0002146426 0.0000000000
   0.0063437444 0.0000000000
   0.0796196123 0.0000000000
   0.0192626514 0.0000000000
   -0.0137606838 -0.0000000070
   -0.0037168653 -0.0000000015
   -0.0137606867 0.0000000038
   0.0000000000 0.0000000000
   0.1054406506 0.0000000000
   0.0000000000 0.0000000000
   0.0117483593 -0.0000000040
   0.0000000000 0.0000000000
   0.0117483553 0.0000000033
   -0.0071440797 -0.0000000029
   -0.0358644160 -0.0000000006
   -0.0071440821 0.0000000015
   0.0063908426 0.0000000055
   -0.0031718706 -0.0000000011
   0.0000000000 0.0000000000
   0.1054406506 0.0000000000
   0.0000000000 0.0000000000
   0.0053223735 0.0000000035
   0.0320148546 0.0000000076
   -0.0031718764 -0.0000000019
   -0.0031718713 -0.0000000053
   0.0063908472 0.0000000004
   0.1054406484 0.0000000000
   0.0000000000 0.0000000000
   0.0053223759 0.0000000035
   0.0000000000 -0.0000000000
   -0.0031718764 -0.0000000031
   0.0320148556 0.0000000053
   -0.0137606838 0.0000000070
   -0.0037168653 0.0000000015
   -0.0137606867 -0.0000000038
   0.0000000000 0.0000000000
   0.1054406484 0.0000000000
   0.0000000000 0.0000000000
   0.0117483593 0.0000000040
   0.0000000000 -0.0000000000
   0.0117483553 -0.0000000033
   -0.0071440797 0.0000000029
   -0.0358644160 0.0000000006
   -0.0071440821 -0.0000000015
   0.0628705057 0.0000000000
   0.0308399377 0.0000000000
   0.0063437475 0.0000000000
   0.0053864574 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.1054406484 0.0000000000
   0.0000000000 0.0000000000
   0.0087729738 0.0000000000
   0.0000000000 0.0000000000
   0.0208782651 0.0000000000
   0.0757894095 0.0000000000
   0.0192626487 0.0000000000
   0.0796196123 0.0000000000
   0.0063437445 0.0000000000
   0.0002146429 0.0000000000
   -0.0859192847 -0.0000000092
   -0.0137606902 -0.0000000013
   -0.0000000005 0.0000000019
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.1054406484 0.0000000000
   0.0000000000 0.0000000000
   0.0117483589 0.0000000034
   0.0619870078 0.0000000077
   -0.1654948143 -0.0000000050
   -0.0071440768 -0.0000000001
   0.0000000001 -0.0000000000
   0.0037168646 0.0000000016
   0.3945593753 0.0000000000
   0.0000000000 -0.0000000000
   0.0358644619 0.0000000018
   0.0063908426 -0.0000000055
   -0.0031718706 0.0000000011
   0.0000000000 0.0000000000
   0.3945593753 0.0000000000
   0.0000000000 -0.0000000000
   0.0053223735 -0.0000000035
   0.0320148546 -0.0000000076
   -0.0031718764 0.0000000019
   -0.0859192847 0.0000000092
   -0.0137606902 0.0000000013
   -0.0000000005 -0.0000000019
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.3945593753 0.0000000000
   0.0000000000 -0.0000000000
   0.0117483589 -0.0000000034
   0.0619870078 -0.0000000077
   -0.1654948143 0.0000000050
   -0.0071440768 0.0000000001
   0.0000000001 0.0000000000
   0.3263023933 0.0000000000
   0.0628705194 0.0000000000
   0.0053864626 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.0000000000 0.0000000000
   0.3945593753 0.0000000000
   0.0000000000 0.0000000000
   0.0087729777 0.0000000000
   0.0757894183 0.0000000000
   0.3099969793 0.0000000000
   0.3750820887 0.0000000000
   0.0192626441 0.0000000000
   0.0002146425 0.0000000000
   0.0000000000 0.0000000000
EOF
paste output/zvo_cisajscktalt_eigen2.dat reference.dat > paste7.dat
diff=`awk '
BEGIN{diff=0.0} 
{diff+=sqrt(($9-$11)*($9-$11)+($10-$12)*($10-$12))}
END{printf "%8.6f", diff/NR}
' paste7.dat`
echo "Diff output/zvo_cisajscktalt_eigen2.dat : " ${diff}
test "${diff}" = "0.000000"

exit $?
