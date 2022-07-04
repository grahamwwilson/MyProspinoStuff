#!/bin/sh

MASS=${1:-300.0}
MYFILE=Sleptons_M${MASS}.slha

NEWMASS=${MASS}E+00
echo 'NEWMASS = '${NEWMASS}

cp Sleptons_generic.slha ${MYFILE}

sed -i -e "s/LLLLLLLLL/${NEWMASS}/g" -e "s/RRRRRRRRR/${NEWMASS}/g" -e "s/NNNNNNNNN/${NEWMASS}/g" ${MYFILE}

exit
