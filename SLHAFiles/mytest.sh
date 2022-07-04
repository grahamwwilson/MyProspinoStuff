#!/bin/sh

MYFILE=Sleptons_M200.slha

cp Sleptons_generic.slha ${MYFILE}

sed -i -e 's/LLLLLLLL/2.00E+02/g' -e 's/RRRRRRRR/2.00E+02/g' -e 's/NNNNNNNN/2.00E+02/g' ${MYFILE}

exit
