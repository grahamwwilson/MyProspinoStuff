#!/bin/bash
#SBATCH --job-name=prosp-array-job    # Job name
#SBATCH --partition=sixhour           # Partition Name (Required)
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=gwwilson@ku.edu   # Where to send mail	
#SBATCH --nodes=1 --ntasks=1          # Run on a single CPU
#SBATCH --mem=1g                      # Job memory request
#SBATCH --time=0-00:50:00             # Time limit days-hrs:min:sec
#SBATCH --array=1-51                  # Job array (51 in length)  1-21=sleptons, 22-51=neutralinos
#SBATCH --output=prosp-array_%A_%a.log  # Standard output and error log
#SBATCH --error=prosp-array_%A_%a.err   # Standard output and error log

pwd
CWD=$(pwd)
hostname
date
echo $HOME
echo $WORK
echo "SLURM_ARRAY_TASK_ID: "${SLURM_ARRAY_TASK_ID}

# Directory where the executable resides
EXEDIR=/home/gwwilson/Prospino

# Directory to run batch job from
BRDIR=$WORK/ProspinoOut/TestSLHA/Job-${SLURM_ARRAY_TASK_ID}

mkdir ${BRDIR}
cd ${BRDIR}

echo 'Now in BRDIR'
pwd

SLHAFILE=prospino.in.les_houches
PDSFILE=ctq66.00.pds
TBLFILE=cteq6l1.tbl
ARGSFILE=/home/gwwilson/Prepare_for_Launch/sleptons_commands.txt

if [ ! -e ${SLHAFILE} ]
then
   ln -s ${EXEDIR}/${SLHAFILE} ${SLHAFILE}
fi

if [ ! -e ${PDSFILE} ]
then
   ln -s ${EXEDIR}/${PDSFILE} ${PDSFILE}
fi

if [ ! -e ${TBLFILE} ]
then
   ln -s ${EXEDIR}/${TBLFILE} ${TBLFILE}
fi

#ln -s ${EXEDIR}/prospino.in.les_houches prospino.in.les_houches
#ln -s ${EXEDIR}/ctq66.00.pds ctq66.00.pds
#ln -s ${EXEDIR}/cteq6l1.tbl cteq6l1.tbl

echo "SLURM_ARRAY_TASK_ID: "${SLURM_ARRAY_TASK_ID}
#LINE=$(sed -n "$SLURM_ARRAY_TASK_ID"p sleptons_commands.txt)
LINE=$(sed -n "$SLURM_ARRAY_TASK_ID"p ${ARGSFILE})
echo "Found Prospino arguments : "
echo $LINE

${EXEDIR}/prospino_2.run ${LINE}

# Clean up - remove the symbolic links
rm $SLHAFILE
rm $PDSFILE
rm $TBLFILE

cd ${CWD}

date
echo 'Job completed'

exit
