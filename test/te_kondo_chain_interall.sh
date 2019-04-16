#!/bin/sh -e

mkdir -p te_kondo_chain_interall/
cd te_kondo_chain_interall
python "$1/test/testTECalc.py" -p "../../src/HPhi++" -mpi "${MPIRUN}" -m "Kondo"

# Check value: flct
cat > reference.dat <<EOF
0.0000000000000000 6.0000000000000000 36.0000000000000000 0.0464229786532451 0.0464229786532451 0.0000000000000000 0.0000000000000000 0
0.0100000000000000 6.0000000000000018 36.0000000000000142 0.0464224636169061 0.0464224636169061 0.0000000000000000 0.0000000000000000 1
0.0200000000000000 6.0000000000000044 36.0000000000000071 0.0464219479682781 0.0464219479682781 0.0000000000000000 0.0000000000000000 2
0.0300000000000000 5.9999999999999947 35.9999999999999929 0.0464214317076435 0.0464214317076435 0.0000000000000000 0.0000000000000000 3
0.0400000000000000 5.9999999999999973 35.9999999999999929 0.0464209154596987 0.0464209154596987 0.0000000000000000 0.0000000000000000 4
0.0500000000000000 5.9999999999999982 36.0000000000000071 0.0464204004545958 0.0464204004545958 0.0000000000000000 0.0000000000000000 5
0.0600000000000000 5.9999999999999964 35.9999999999999858 0.0464198884971452 0.0464198884971452 0.0000000000000000 0.0000000000000000 6
0.0700000000000000 6.0000000000000044 36.0000000000000497 0.0464193819245484 0.0464193819245484 0.0000000000000000 0.0000000000000000 7
0.0800000000000000 6.0000000000000018 36.0000000000000000 0.0464188835531690 0.0464188835531690 0.0000000000000000 0.0000000000000000 8
0.0900000000000000 6.0000000000000009 36.0000000000000071 0.0464183966149880 0.0464183966149880 0.0000000000000000 0.0000000000000000 9
0.1000000000000000 6.0000000000000009 36.0000000000000000 0.0464179246845099 0.0464179246845099 0.0000000000000000 0.0000000000000000 10
0.1100000000000000 5.9999999999999991 36.0000000000000000 0.0464174715970148 0.0464174715970148 0.0000000000000000 0.0000000000000000 11
0.1200000000000000 6.0000000000000036 36.0000000000000355 0.0464170413591537 0.0464170413591537 0.0000000000000000 0.0000000000000000 12
0.1300000000000000 6.0000000000000027 36.0000000000000142 0.0464166380529906 0.0464166380529906 0.0000000000000000 0.0000000000000000 13
0.1400000000000000 6.0000000000000071 36.0000000000000142 0.0464162657346812 0.0464162657346812 0.0000000000000000 0.0000000000000000 14
0.1500000000000000 6.0000000000000009 36.0000000000000071 0.0464159283290521 0.0464159283290521 0.0000000000000000 0.0000000000000000 15
0.1600000000000000 5.9999999999999991 36.0000000000000000 0.0464156295214121 0.0464156295214121 0.0000000000000000 0.0000000000000000 16
0.1700000000000000 6.0000000000000027 35.9999999999999858 0.0464153726479724 0.0464153726479724 0.0000000000000000 0.0000000000000000 17
0.1800000000000000 5.9999999999999991 35.9999999999999787 0.0464151605862873 0.0464151605862873 0.0000000000000000 0.0000000000000000 18
0.1900000000000000 6.0000000000000009 35.9999999999999929 0.0464149956471485 0.0464149956471485 0.0000000000000000 0.0000000000000000 19
0.2000000000000000 5.9999999999999991 35.9999999999999929 0.0464148794693673 0.0464148794693673 0.0000000000000000 0.0000000000000000 20
0.2100000000000000 6.0000000000000036 36.0000000000000071 0.0464148129188696 0.0464148129188696 0.0000000000000000 0.0000000000000000 21
0.2200000000000000 5.9999999999999964 35.9999999999999858 0.0464147959935008 0.0464147959935008 0.0000000000000000 0.0000000000000000 22
0.2300000000000000 5.9999999999999973 35.9999999999999858 0.0464148277348962 0.0464148277348962 0.0000000000000000 0.0000000000000000 23
0.2400000000000000 6.0000000000000000 36.0000000000000000 0.0464149061487148 0.0464149061487148 0.0000000000000000 0.0000000000000000 24
0.2500000000000000 6.0000000000000000 36.0000000000000142 0.0464150281344635 0.0464150281344635 0.0000000000000000 0.0000000000000000 25
0.2600000000000000 6.0000000000000009 36.0000000000000071 0.0464151894260536 0.0464151894260536 0.0000000000000000 0.0000000000000000 26
0.2700000000000000 6.0000000000000018 36.0000000000000213 0.0464153845441313 0.0464153845441313 0.0000000000000000 0.0000000000000000 27
0.2800000000000000 5.9999999999999982 36.0000000000000071 0.0464156067611171 0.0464156067611171 0.0000000000000000 0.0000000000000000 28
0.2900000000000000 6.0000000000000053 36.0000000000000071 0.0464158480797631 0.0464158480797631 0.0000000000000000 0.0000000000000000 29
0.3000000000000000 6.0000000000000027 36.0000000000000000 0.0464160992259077 0.0464160992259077 0.0000000000000000 0.0000000000000000 30
0.3100000000000000 5.9999999999999947 35.9999999999999787 0.0464163496559670 0.0464163496559670 0.0000000000000000 0.0000000000000000 31
0.3200000000000000 6.0000000000000009 35.9999999999999716 0.0464165875795533 0.0464165875795533 0.0000000000000000 0.0000000000000000 32
0.3300000000000000 6.0000000000000027 36.0000000000000000 0.0464167999974564 0.0464167999974564 0.0000000000000000 0.0000000000000000 33
0.3400000000000000 6.0000000000000000 35.9999999999999929 0.0464169727550677 0.0464169727550677 0.0000000000000000 0.0000000000000000 34
0.3500000000000000 6.0000000000000000 35.9999999999999929 0.0464170906111615 0.0464170906111615 0.0000000000000000 0.0000000000000000 35
0.3600000000000000 5.9999999999999991 36.0000000000000142 0.0464171373217896 0.0464171373217896 0.0000000000000000 0.0000000000000000 36
0.3700000000000000 6.0000000000000000 36.0000000000000071 0.0464170957388771 0.0464170957388771 0.0000000000000000 0.0000000000000000 37
0.3800000000000000 6.0000000000000018 36.0000000000000000 0.0464169479229518 0.0464169479229518 0.0000000000000000 0.0000000000000000 38
0.3900000000000000 6.0000000000000000 35.9999999999999858 0.0464166752692776 0.0464166752692776 0.0000000000000000 0.0000000000000000 39
0.4000000000000000 6.0000000000000000 35.9999999999999716 0.0464162586465127 0.0464162586465127 0.0000000000000000 0.0000000000000000 40
0.4100000000000000 5.9999999999999991 35.9999999999999929 0.0464156785468642 0.0464156785468642 0.0000000000000000 0.0000000000000000 41
0.4200000000000000 5.9999999999999964 36.0000000000000071 0.0464149152465766 0.0464149152465766 0.0000000000000000 0.0000000000000000 42
0.4300000000000000 6.0000000000000000 35.9999999999999858 0.0464139489754586 0.0464139489754586 0.0000000000000000 0.0000000000000000 43
0.4400000000000000 5.9999999999999982 35.9999999999999858 0.0464127600940380 0.0464127600940380 0.0000000000000000 0.0000000000000000 44
0.4500000000000000 6.0000000000000000 36.0000000000000071 0.0464113292768276 0.0464113292768276 0.0000000000000000 0.0000000000000000 45
0.4600000000000000 5.9999999999999973 36.0000000000000000 0.0464096377000905 0.0464096377000905 0.0000000000000000 0.0000000000000000 46
0.4700000000000000 6.0000000000000009 36.0000000000000071 0.0464076672324188 0.0464076672324188 0.0000000000000000 0.0000000000000000 47
0.4800000000000000 5.9999999999999973 36.0000000000000213 0.0464054006263717 0.0464054006263717 0.0000000000000000 0.0000000000000000 48
0.4900000000000000 5.9999999999999982 36.0000000000000071 0.0464028217093746 0.0464028217093746 0.0000000000000000 0.0000000000000000 49
0.5000000000000000 6.0000000000000053 36.0000000000000284 0.0463999155720485 0.0463999155720485 0.0000000000000000 0.0000000000000000 50
0.5100000000000000 6.0000000000000027 36.0000000000000071 0.0463966687521250 0.0463966687521250 0.0000000000000000 0.0000000000000000 51
0.5200000000000000 6.0000000000000009 36.0000000000000000 0.0463930694121057 0.0463930694121057 0.0000000000000000 0.0000000000000000 52
0.5300000000000000 6.0000000000000018 35.9999999999999929 0.0463891075088443 0.0463891075088443 0.0000000000000000 0.0000000000000000 53
0.5400000000000000 5.9999999999999964 35.9999999999999787 0.0463847749532690 0.0463847749532690 0.0000000000000000 0.0000000000000000 54
0.5500000000000000 6.0000000000000018 35.9999999999999929 0.0463800657585163 0.0463800657585163 0.0000000000000000 0.0000000000000000 55
0.5600000000000001 6.0000000000000009 35.9999999999999929 0.0463749761748210 0.0463749761748210 0.0000000000000000 0.0000000000000000 56
0.5700000000000000 6.0000000000000018 36.0000000000000213 0.0463695048095926 0.0463695048095926 0.0000000000000000 0.0000000000000000 57
0.5800000000000000 5.9999999999999973 35.9999999999999716 0.0463636527312155 0.0463636527312155 0.0000000000000000 0.0000000000000000 58
0.5900000000000000 6.0000000000000044 35.9999999999999929 0.0463574235552265 0.0463574235552265 0.0000000000000000 0.0000000000000000 59
0.6000000000000000 6.0000000000000027 36.0000000000000497 0.0463508235116563 0.0463508235116563 0.0000000000000000 0.0000000000000000 60
0.6100000000000000 5.9999999999999991 35.9999999999999858 0.0463438614924688 0.0463438614924688 0.0000000000000000 0.0000000000000000 61
0.6200000000000000 6.0000000000000036 36.0000000000000142 0.0463365490781852 0.0463365490781852 0.0000000000000000 0.0000000000000000 62
0.6300000000000000 6.0000000000000000 35.9999999999999858 0.0463289005429516 0.0463289005429516 0.0000000000000000 0.0000000000000000 63
0.6400000000000000 6.0000000000000027 36.0000000000000213 0.0463209328374804 0.0463209328374804 0.0000000000000000 0.0000000000000000 64
0.6500000000000000 6.0000000000000053 36.0000000000000355 0.0463126655494829 0.0463126655494829 0.0000000000000000 0.0000000000000000 65
0.6600000000000000 5.9999999999999973 36.0000000000000142 0.0463041208413959 0.0463041208413959 0.0000000000000000 0.0000000000000000 66
0.6700000000000000 6.0000000000000018 35.9999999999999929 0.0462953233654009 0.0462953233654009 0.0000000000000000 0.0000000000000000 67
0.6800000000000000 6.0000000000000027 36.0000000000000000 0.0462863001559265 0.0462863001559265 0.0000000000000000 0.0000000000000000 68
0.6899999999999999 6.0000000000000000 36.0000000000000213 0.0462770805000242 0.0462770805000242 0.0000000000000000 0.0000000000000000 69
0.7000000000000000 6.0000000000000044 36.0000000000000355 0.0462676957861978 0.0462676957861978 0.0000000000000000 0.0000000000000000 70
0.7100000000000000 5.9999999999999991 36.0000000000000000 0.0462581793324613 0.0462581793324613 0.0000000000000000 0.0000000000000000 71
0.7200000000000000 6.0000000000000000 36.0000000000000000 0.0462485661945854 0.0462485661945854 0.0000000000000000 0.0000000000000000 72
0.7300000000000000 6.0000000000000036 36.0000000000000142 0.0462388929556728 0.0462388929556728 0.0000000000000000 0.0000000000000000 73
0.7400000000000000 5.9999999999999982 35.9999999999999787 0.0462291974983745 0.0462291974983745 0.0000000000000000 0.0000000000000000 74
0.7500000000000000 6.0000000000000053 35.9999999999999929 0.0462195187612238 0.0462195187612238 0.0000000000000000 0.0000000000000000 75
0.7600000000000000 6.0000000000000009 36.0000000000000000 0.0462098964807106 0.0462098964807106 0.0000000000000000 0.0000000000000000 76
0.7700000000000000 6.0000000000000027 36.0000000000000142 0.0462003709208645 0.0462003709208645 0.0000000000000000 0.0000000000000000 77
0.7800000000000000 5.9999999999999982 36.0000000000000000 0.0461909825922325 0.0461909825922325 0.0000000000000000 0.0000000000000000 78
0.7900000000000000 6.0000000000000018 35.9999999999999787 0.0461817719622509 0.0461817719622509 0.0000000000000000 0.0000000000000000 79
0.8000000000000000 6.0000000000000018 36.0000000000000071 0.0461727791591037 0.0461727791591037 0.0000000000000000 0.0000000000000000 80
0.8100000000000001 6.0000000000000044 36.0000000000000071 0.0461640436712340 0.0461640436712340 0.0000000000000000 0.0000000000000000 81
0.8200000000000000 5.9999999999999964 35.9999999999999787 0.0461556040447352 0.0461556040447352 0.0000000000000000 0.0000000000000000 82
0.8300000000000000 6.0000000000000009 36.0000000000000142 0.0461474975808871 0.0461474975808871 0.0000000000000000 0.0000000000000000 83
0.8400000000000000 6.0000000000000018 36.0000000000000071 0.0461397600361233 0.0461397600361233 0.0000000000000000 0.0000000000000000 84
0.8500000000000000 6.0000000000000027 36.0000000000000284 0.0461324253267196 0.0461324253267196 0.0000000000000000 0.0000000000000000 85
0.8600000000000000 5.9999999999999964 35.9999999999999716 0.0461255252404709 0.0461255252404709 0.0000000000000000 0.0000000000000000 86
0.8700000000000000 6.0000000000000000 36.0000000000000142 0.0461190891575932 0.0461190891575932 0.0000000000000000 0.0000000000000000 87
0.8800000000000000 5.9999999999999991 35.9999999999999929 0.0461131437830263 0.0461131437830263 0.0000000000000000 0.0000000000000000 88
0.8900000000000000 6.0000000000000027 36.0000000000000000 0.0461077128922413 0.0461077128922413 0.0000000000000000 0.0000000000000000 89
0.9000000000000000 6.0000000000000009 36.0000000000000000 0.0461028170925646 0.0461028170925646 0.0000000000000000 0.0000000000000000 90
0.9100000000000000 6.0000000000000018 35.9999999999999929 0.0460984736019171 0.0460984736019171 0.0000000000000000 0.0000000000000000 91
0.9200000000000000 5.9999999999999991 35.9999999999999858 0.0460946960467473 0.0460946960467473 0.0000000000000000 0.0000000000000000 92
0.9300000000000000 5.9999999999999982 36.0000000000000000 0.0460914942807900 0.0460914942807900 0.0000000000000000 0.0000000000000000 93
0.9399999999999999 6.0000000000000000 36.0000000000000000 0.0460888742261307 0.0460888742261307 0.0000000000000000 0.0000000000000000 94
0.9500000000000000 5.9999999999999982 35.9999999999999929 0.0460868377378859 0.0460868377378859 0.0000000000000000 0.0000000000000000 95
0.9600000000000000 5.9999999999999964 35.9999999999999858 0.0460853824936314 0.0460853824936314 0.0000000000000000 0.0000000000000000 96
0.9700000000000000 5.9999999999999973 35.9999999999999716 0.0460845019085213 0.0460845019085213 0.0000000000000000 0.0000000000000000 97
0.9800000000000000 5.9999999999999973 35.9999999999999858 0.0460841850768418 0.0460841850768418 0.0000000000000000 0.0000000000000000 98
0.9900000000000000 6.0000000000000027 36.0000000000000000 0.0460844167405427 0.0460844167405427 0.0000000000000000 0.0000000000000000 99
EOF
sed -e "1d" output/Flct.dat > flct.dat
paste flct.dat reference.dat > paste1.dat
diff=`awk 'BEGIN{diff=0.0} {diff+=sqrt(($2-$10)*($2-$10))} END{printf "%8.6f", diff/NR}' paste1.dat`
echo "Diff N : " ${diff}
test "${diff}" = "0.000000"
diff=`awk 'BEGIN{diff=0.0} {diff+=sqrt(($3-$11)*($3-$11))} END{printf "%8.6f", diff/NR}' paste1.dat`
echo "Diff N^2 : " ${diff}
test "${diff}" = "0.000000"
diff=`awk 'BEGIN{diff=0.0} {diff+=sqrt(($4-$12)*($4-$12))} END{printf "%8.6f", diff/NR}' paste1.dat`
echo "Diff D : " ${diff}
test "${diff}" = "0.000000"
diff=`awk 'BEGIN{diff=0.0} {diff+=sqrt(($5-$13)*($5-$13))} END{printf "%8.6f", diff/NR}' paste1.dat`
echo "Diff D^2 : " ${diff}
test "${diff}" = "0.000000"
diff=`awk 'BEGIN{diff=0.0} {diff+=sqrt(($6-$14)*($6-$14))} END{printf "%8.6f", diff/NR}' paste1.dat`
echo "Diff Sz : " ${diff}
test "${diff}" = "0.000000"
diff=`awk 'BEGIN{diff=0.0} {diff+=sqrt(($7-$15)*($7-$15))} END{printf "%8.6f", diff/NR}' paste1.dat`
echo "Diff Sz^2 : " ${diff}
test "${diff}" = "0.000000"

exit $?
