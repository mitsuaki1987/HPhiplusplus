#!/bin/sh -e

mkdir -p te_hubbard_chain_interall/
cd te_hubbard_chain_interall
python "$1/test/testTECalc.py" -p "../../src/HPhi" -mpi "${MPIRUN}"

# Check value: flct
cat > reference.dat <<EOF
0.0000000000000000 4.0000000000000009 16.0000000000000036 0.2873253726900541 0.3082093228771928 0.0000000000000000 0.0000000000000000 0
0.0100000000000000 4.0000000000000000 16.0000000000000000 0.2873312949210214 0.3082218825603527 0.0000000000000000 0.0000000000000000 1
0.0200000000000000 4.0000000000000000 16.0000000000000000 0.2878650968831657 0.3088045061301283 0.0000000000000000 0.0000000000000000 2
0.0300000000000000 3.9999999999999978 15.9999999999999911 0.2889265791853685 0.3099571092783017 0.0000000000000000 0.0000000000000000 3
0.0400000000000000 4.0000000000000009 16.0000000000000036 0.2905129699886809 0.3116775830039832 0.0000000000000000 0.0000000000000000 4
0.0500000000000000 4.0000000000000027 16.0000000000000107 0.2926189298491023 0.3139617978318748 0.0000000000000000 0.0000000000000000 5
0.0600000000000000 4.0000000000000009 16.0000000000000036 0.2952365715305052 0.3168036144553739 0.0000000000000000 0.0000000000000000 6
0.0700000000000000 4.0000000000000000 16.0000000000000000 0.2983554947132342 0.3201949007514086 0.0000000000000000 0.0000000000000000 7
0.0800000000000000 3.9999999999999996 15.9999999999999982 0.3019628354130581 0.3241255550997977 0.0000000000000000 0.0000000000000000 8
0.0900000000000000 3.9999999999999982 15.9999999999999929 0.3060433298154317 0.3285835359263936 0.0000000000000000 0.0000000000000000 9
0.1000000000000000 4.0000000000000000 16.0000000000000000 0.3105793921224521 0.3335548973762826 0.0000000000000000 0.0000000000000000 10
0.1100000000000000 3.9999999999999991 15.9999999999999964 0.3155512059054574 0.3390238310108190 0.0000000000000000 0.0000000000000000 11
0.1200000000000000 4.0000000000000009 16.0000000000000036 0.3209368283559273 0.3449727134102514 0.0000000000000000 0.0000000000000000 12
0.1300000000000000 4.0000000000000009 16.0000000000000036 0.3267123067320903 0.3513821595520513 0.0000000000000000 0.0000000000000000 13
0.1400000000000000 4.0000000000000009 16.0000000000000036 0.3328518062093627 0.3582310818237963 0.0000000000000000 0.0000000000000000 14
0.1500000000000000 4.0000000000000009 16.0000000000000036 0.3393277482602223 0.3654967545184792 0.0000000000000000 0.0000000000000000 15
0.1600000000000000 4.0000000000000009 16.0000000000000036 0.3461109586141317 0.3731548836493774 0.0000000000000000 0.0000000000000000 16
0.1700000000000000 3.9999999999999987 15.9999999999999947 0.3531708237813603 0.3811796819110754 0.0000000000000000 0.0000000000000000 17
0.1800000000000000 4.0000000000000018 16.0000000000000071 0.3604754550665934 0.3895439486028317 0.0000000000000000 0.0000000000000000 18
0.1900000000000000 4.0000000000000009 16.0000000000000036 0.3679918589495590 0.3982191543201336 0.0000000000000000 0.0000000000000000 19
0.2000000000000000 4.0000000000000000 16.0000000000000000 0.3756861126709977 0.4071755302100146 0.0000000000000000 0.0000000000000000 20
0.2100000000000000 3.9999999999999987 15.9999999999999947 0.3835235438333827 0.4163821615753805 0.0000000000000000 0.0000000000000000 21
0.2200000000000000 4.0000000000000000 16.0000000000000000 0.3914689128071569 0.4258070856032545 0.0000000000000000 0.0000000000000000 22
0.2300000000000000 3.9999999999999982 15.9999999999999929 0.3994865967249117 0.4354173929814121 0.0000000000000000 0.0000000000000000 23
0.2400000000000000 4.0000000000000000 16.0000000000000000 0.4075407738479275 0.4451793331573359 0.0000000000000000 0.0000000000000000 24
0.2500000000000000 3.9999999999999987 15.9999999999999947 0.4155956071016930 0.4550584229827550 0.0000000000000000 0.0000000000000000 25
0.2600000000000000 4.0000000000000000 16.0000000000000000 0.4236154255992099 0.4650195584762525 0.0000000000000000 0.0000000000000000 26
0.2700000000000000 4.0000000000000009 16.0000000000000036 0.4315649030027385 0.4750271294254808 0.0000000000000000 0.0000000000000000 27
0.2800000000000000 4.0000000000000018 16.0000000000000071 0.4394092316157541 0.4850451365395010 0.0000000000000000 0.0000000000000000 28
0.2900000000000000 4.0000000000000009 16.0000000000000036 0.4471142911467278 0.4950373108506061 0.0000000000000000 0.0000000000000000 29
0.3000000000000000 3.9999999999999996 15.9999999999999982 0.4546468111443556 0.5049672350537898 0.0000000000000000 0.0000000000000000 30
0.3100000000000000 3.9999999999999991 15.9999999999999964 0.4619745261693403 0.5147984664607829 0.0000000000000000 0.0000000000000000 31
0.3200000000000000 4.0000000000000000 16.0000000000000000 0.4690663228400719 0.5244946612343867 0.0000000000000000 0.0000000000000000 32
0.3300000000000000 3.9999999999999987 15.9999999999999947 0.4758923779677187 0.5340196995577081 0.0000000000000000 0.0000000000000000 33
0.3400000000000000 4.0000000000000009 16.0000000000000036 0.4824242870795319 0.5433378113819740 0.0000000000000000 0.0000000000000000 34
0.3500000000000000 3.9999999999999987 15.9999999999999947 0.4886351827166419 0.5524137023858892 0.0000000000000000 0.0000000000000000 35
0.3600000000000000 3.9999999999999991 15.9999999999999964 0.4944998419834178 0.5612126797691779 0.0000000000000000 0.0000000000000000 36
0.3700000000000000 4.0000000000000000 16.0000000000000000 0.4999947829185790 0.5697007774930131 0.0000000000000000 0.0000000000000000 37
0.3800000000000000 3.9999999999999978 15.9999999999999911 0.5050983493528219 0.5778448805707221 0.0000000000000000 0.0000000000000000 38
0.3900000000000000 4.0000000000000000 16.0000000000000000 0.5097907840127228 0.5856128480034585 0.0000000000000000 0.0000000000000000 39
0.4000000000000000 3.9999999999999991 15.9999999999999964 0.5140542897252494 0.5929736339476549 0.0000000000000000 0.0000000000000000 40
0.4100000000000000 4.0000000000000000 16.0000000000000000 0.5178730786704325 0.5998974066941372 0.0000000000000000 0.0000000000000000 41
0.4200000000000000 4.0000000000000009 16.0000000000000036 0.5212334097207145 0.6063556650328470 0.0000000000000000 0.0000000000000000 42
0.4300000000000000 4.0000000000000009 16.0000000000000036 0.5241236139934279 0.6123213515724457 0.0000000000000000 0.0000000000000000 43
0.4400000000000000 3.9999999999999991 15.9999999999999964 0.5265341088269710 0.6177689625806692 0.0000000000000000 0.0000000000000000 44
0.4500000000000000 4.0000000000000009 16.0000000000000036 0.5284574004708121 0.6226746539093934 0.0000000000000000 0.0000000000000000 45
0.4600000000000000 4.0000000000000000 16.0000000000000000 0.5298880758538397 0.6270163425680275 0.0000000000000000 0.0000000000000000 46
0.4700000000000000 4.0000000000000000 16.0000000000000000 0.5308227838642323 0.6307738035102679 0.0000000000000000 0.0000000000000000 47
0.4800000000000000 3.9999999999999978 15.9999999999999911 0.5312602066363888 0.6339287612024556 0.0000000000000000 0.0000000000000000 48
0.4900000000000000 4.0000000000000009 16.0000000000000036 0.5312010213962154 0.6364649755470074 0.0000000000000000 0.0000000000000000 49
0.5000000000000000 4.0000000000000009 16.0000000000000036 0.5306478534647836 0.6383683217416394 0.0000000000000000 0.0000000000000000 50
0.5100000000000000 3.9999999999999996 15.9999999999999982 0.5296052210619306 0.6396268636645674 0.0000000000000000 0.0000000000000000 51
0.5200000000000000 3.9999999999999991 15.9999999999999964 0.5280794725854705 0.6402309203875384 0.0000000000000000 0.0000000000000000 52
0.5300000000000000 3.9999999999999982 15.9999999999999929 0.5260787170684165 0.6401731254325975 0.0000000000000000 0.0000000000000000 53
0.5400000000000000 3.9999999999999978 15.9999999999999911 0.5236127485358530 0.6394484784048998 0.0000000000000000 0.0000000000000000 54
0.5500000000000000 3.9999999999999996 15.9999999999999982 0.5206929649950457 0.6380543886527272 0.0000000000000000 0.0000000000000000 55
0.5600000000000001 4.0000000000000000 16.0000000000000000 0.5173322827971618 0.6359907106271825 0.0000000000000000 0.0000000000000000 56
0.5700000000000000 4.0000000000000009 16.0000000000000036 0.5135450471068536 0.6332597706378099 0.0000000000000000 0.0000000000000000 57
0.5800000000000000 4.0000000000000000 16.0000000000000000 0.5093469392072816 0.6298663847266233 0.0000000000000000 0.0000000000000000 58
0.5900000000000000 3.9999999999999987 15.9999999999999947 0.5047548813532494 0.6258178674116947 0.0000000000000000 0.0000000000000000 59
0.6000000000000000 4.0000000000000000 16.0000000000000000 0.4997869398644900 0.6211240310824824 0.0000000000000000 0.0000000000000000 60
0.6100000000000000 4.0000000000000018 16.0000000000000071 0.4944622271252188 0.6157971758624410 0.0000000000000000 0.0000000000000000 61
0.6200000000000000 4.0000000000000009 16.0000000000000036 0.4888008031253913 0.6098520697899957 0.0000000000000000 0.0000000000000000 62
0.6300000000000000 4.0000000000000000 16.0000000000000000 0.4828235771442463 0.6033059192066302 0.0000000000000000 0.0000000000000000 63
0.6400000000000000 3.9999999999999996 15.9999999999999982 0.4765522101382239 0.5961783292804471 0.0000000000000000 0.0000000000000000 64
0.6500000000000000 3.9999999999999982 15.9999999999999929 0.4700090183538481 0.5884912546349879 0.0000000000000000 0.0000000000000000 65
0.6600000000000000 3.9999999999999991 15.9999999999999964 0.4632168786422358 0.5802689400961432 0.0000000000000000 0.0000000000000000 66
0.6700000000000000 4.0000000000000018 16.0000000000000071 0.4561991359061435 0.5715378516144715 0.0000000000000000 0.0000000000000000 67
0.6800000000000000 4.0000000000000009 16.0000000000000036 0.4489795130634771 0.5623265974659331 0.0000000000000000 0.0000000000000000 68
0.6899999999999999 4.0000000000000009 16.0000000000000036 0.4415820238635533 0.5526658398807271 0.0000000000000000 0.0000000000000000 69
0.7000000000000000 3.9999999999999987 15.9999999999999947 0.4340308888446348 0.5425881972973234 0.0000000000000000 0.0000000000000000 70
0.7100000000000000 3.9999999999999978 15.9999999999999911 0.4263504546739272 0.5321281374866484 0.0000000000000000 0.0000000000000000 71
0.7200000000000000 3.9999999999999991 15.9999999999999964 0.4185651170647606 0.5213218618394413 0.0000000000000000 0.0000000000000000 72
0.7300000000000000 4.0000000000000000 16.0000000000000000 0.4106992474205721 0.5102071811577484 0.0000000000000000 0.0000000000000000 73
0.7400000000000000 4.0000000000000000 16.0000000000000000 0.4027771233119257 0.4988233833390585 0.0000000000000000 0.0000000000000000 74
0.7500000000000000 4.0000000000000000 16.0000000000000000 0.3948228628515178 0.4872110933884133 0.0000000000000000 0.0000000000000000 75
0.7600000000000000 3.9999999999999991 15.9999999999999964 0.3868603629932343 0.4754121262396271 0.0000000000000000 0.0000000000000000 76
0.7700000000000000 4.0000000000000018 16.0000000000000071 0.3789132417450816 0.4634693329111990 0.0000000000000000 0.0000000000000000 77
0.7800000000000000 3.9999999999999982 15.9999999999999929 0.3710047842524256 0.4514264405652964 0.0000000000000000 0.0000000000000000 78
0.7900000000000000 4.0000000000000000 16.0000000000000000 0.3631578926775998 0.4393278870790038 0.0000000000000000 0.0000000000000000 79
0.8000000000000000 4.0000000000000009 16.0000000000000036 0.3553950397746464 0.4272186507755488 0.0000000000000000 0.0000000000000000 80
0.8100000000000001 4.0000000000000009 16.0000000000000036 0.3477382260338536 0.4151440759991701 0.0000000000000000 0.0000000000000000 81
0.8200000000000000 4.0000000000000000 16.0000000000000000 0.3402089402497859 0.4031496952503214 0.0000000000000000 0.0000000000000000 82
0.8300000000000000 3.9999999999999978 15.9999999999999911 0.3328281233486904 0.3912810486278072 0.0000000000000000 0.0000000000000000 83
0.8400000000000000 4.0000000000000000 16.0000000000000000 0.3256161352964121 0.3795835013508861 0.0000000000000000 0.0000000000000000 84
0.8500000000000000 3.9999999999999987 15.9999999999999947 0.3185927248961411 0.3681020601571473 0.0000000000000000 0.0000000000000000 85
0.8600000000000000 4.0000000000000009 16.0000000000000036 0.3117770022763609 0.3568811893908245 0.0000000000000000 0.0000000000000000 86
0.8700000000000000 4.0000000000000018 16.0000000000000071 0.3051874138630462 0.3459646276109362 0.0000000000000000 0.0000000000000000 87
0.8800000000000000 3.9999999999999982 15.9999999999999929 0.2988417196263579 0.3353952055590805 0.0000000000000000 0.0000000000000000 88
0.8900000000000000 4.0000000000000009 16.0000000000000036 0.2927569723905696 0.3252146663326708 0.0000000000000000 0.0000000000000000 89
0.9000000000000000 3.9999999999999987 15.9999999999999947 0.2869494989965456 0.3154634886107708 0.0000000000000000 0.0000000000000000 90
0.9100000000000000 4.0000000000000009 16.0000000000000036 0.2814348831086091 0.3061807137763740 0.0000000000000000 0.0000000000000000 91
0.9200000000000000 3.9999999999999996 15.9999999999999982 0.2762279494618123 0.2974037777708704 0.0000000000000000 0.0000000000000000 92
0.9300000000000000 4.0000000000000000 16.0000000000000000 0.2713427493513635 0.2891683485035741 0.0000000000000000 0.0000000000000000 93
0.9399999999999999 3.9999999999999991 15.9999999999999964 0.2667925471729855 0.2815081696214676 0.0000000000000000 0.0000000000000000 94
0.9500000000000000 3.9999999999999991 15.9999999999999964 0.2625898078311961 0.2744549114218570 0.0000000000000000 0.0000000000000000 95
0.9600000000000000 4.0000000000000027 16.0000000000000107 0.2587461848417107 0.2680380296634267 0.0000000000000000 0.0000000000000000 96
0.9700000000000000 3.9999999999999982 15.9999999999999929 0.2552725089642509 0.2622846329993688 0.0000000000000000 0.0000000000000000 97
0.9800000000000000 3.9999999999999991 15.9999999999999964 0.2521787772129051 0.2572193597199530 0.0000000000000000 0.0000000000000000 98
0.9900000000000000 3.9999999999999987 15.9999999999999947 0.2494741421027048 0.2528642644512554 0.0000000000000000 0.0000000000000000 99
EOF
sed -e "1d" output/Flct.dat > flct.dat
paste flct.dat reference.dat > paste1.dat
diff=`awk 'BEGIN{diff=0.0} {diff+=sqrt(($2-$10)*($2-$10))} END{printf "%8.6f", diff}' paste1.dat`
diff=`awk 'BEGIN{diff='${diff}'} {diff+=sqrt(($3-$11)*($3-$11))} END{printf "%8.6f", diff}' paste1.dat`
diff=`awk 'BEGIN{diff='${diff}'} {diff+=sqrt(($4-$12)*($4-$12))} END{printf "%8.6f", diff}' paste1.dat`
diff=`awk 'BEGIN{diff='${diff}'} {diff+=sqrt(($5-$13)*($5-$13))} END{printf "%8.6f", diff}' paste1.dat`
diff=`awk 'BEGIN{diff='${diff}'} {diff+=sqrt(($6-$14)*($6-$14))} END{printf "%8.6f", diff}' paste1.dat`
diff=`awk 'BEGIN{diff='${diff}'} {diff+=sqrt(($7-$15)*($7-$15))} END{printf "%8.6f", diff}' paste1.dat`

test "${diff}" = "0.000000"
exit $?
