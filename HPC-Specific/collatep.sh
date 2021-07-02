#!/bin/sh

listfile=valuesll.list
slhaname=$1
collider=sleptons_13TeV
prefix=${slhaname}_${collider}_Process

for process in $(cat ${listfile})
do
#   echo $process
   filename=${prefix}${process}/prospino.dat
   head -1 ${filename}
done

exit
