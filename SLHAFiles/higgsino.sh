#!/bin/sh

MN2=${1:-250.0}
MC1=${2:-235.0}
MN1=${3:-220.0}
MYFILE=Higgsinos_${MN2}-${MC1}-${MN1}.slha

NMN2=${MN2}E+00
NMC1=${MC1}E+00
NMN1=${MN1}E+00
echo 'New masses = '${NMN2},${NMC1},${NMN1}

cp higgsino_slha_C1C1_V2.in ${MYFILE}

sed -i -e "s/{MN2}/${NMN2}/g" -e "s/{MC1}/${NMC1}/g" -e "s/{MN1}/${NMN1}/g" ${MYFILE}

exit
