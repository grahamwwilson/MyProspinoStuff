#!/bin/sh
#
# Specify left slepton mass, right slepton mass, and sneutrino mass.
#

ML=${1:-300.0}
MR=${2:-300.0}
MN=${3:-289.0}
MYFILE=Sleptons_MLRN-${ML}-${MR}-${MN}.slha

MLP=${ML}E+00
MRP=${MR}E+00
MNP=${MN}E+00
echo 'MLP = '${MLP}
echo 'MRP = '${MRP}
echo 'MNP = '${MNP}

cp Sleptons_generic.slha ${MYFILE}

sed -i -e "s/LLLLLLLLL/${MLP}/g" -e "s/RRRRRRRRR/${MRP}/g" -e "s/NNNNNNNNN/${MNP}/g" ${MYFILE}

exit
