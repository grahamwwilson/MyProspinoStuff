#!/bin/bash
#
# Run an array of 51 jobs for one particular input SLHA file. 
# Each job is one of the 51 production channels (21 for sleptons/sfermions + 30 for electroweakinos)
#
# Please change E-mail to your own E-mail or turn that feature off!
#
#SBATCH --job-name=prosp-array-job    # Job name
#SBATCH --partition=sixhour           # Partition Name (Required)
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=gwwilson@ku.edu   # Where to send mail	
#SBATCH --nodes=1 --ntasks=1          # Run on a single CPU
#SBATCH --mem=1g                      # Job memory request
#SBATCH --time=0-00:50:00             # Time limit days-hrs:min:sec
#SBATCH --array=1-51                  # Job array (51 in length)  1-21=sleptons, 22-51=electroweakinos
#SBATCH --output=prosp-array_%A_%a.log  # Standard output and error log
#SBATCH --error=prosp-array_%A_%a.err   # Standard output and error log

# Center-of-mass energy (now a command line argument to each job)
# default value if not specified is 13600 GeV
ECM=${1:-13600}

pwd
CWD=$(pwd)
hostname
date
echo $HOME
echo $WORK
echo "SLURM_ARRAY_TASK_ID: "${SLURM_ARRAY_TASK_ID}

# Main directory for the git based code etc.
# On HPC this should be where you cloned the git repository MyProspinoStuff 
# You may want to also use your $WORK directory (/kuhpc/work/wilson/$USER)
GITDIR=$WORK/MyProspinoStuff

# Directory where the executable resides
EXEDIR=/kuhpc/work/wilson/gwwilson/Prospino

# Here we use ${GITDIR}/SLHAFiles/${SLHA}.slha as the input SLHA file
SLHA=${2:-Higgsinos_250.0-235.0-220.0}

# Directory to run batch job from
BRDIR=$WORK/ProspinoOut/${SLHA}-${ECM}-Job-${SLURM_ARRAY_TASK_ID}

mkdir ${BRDIR}
cd ${BRDIR}

echo 'Now in BRDIR'
pwd

SLHAFILE=prospino.in.les_houches
PDSFILE=ctq66.00.pds
TBLFILE=cteq6l1.tbl
ARGSFILE=${GITDIR}/HPC-Specific/sleptons-electroweakinos_commands.txt

if [ ! -e ${SLHAFILE} ]
then
   ln -s ${GITDIR}/SLHAFiles/${SLHA}.slha ${SLHAFILE}
fi

if [ ! -e ${PDSFILE} ]
then
   ln -s ${EXEDIR}/${PDSFILE} ${PDSFILE}
fi

if [ ! -e ${TBLFILE} ]
then
   ln -s ${EXEDIR}/${TBLFILE} ${TBLFILE}
fi

echo "SLURM_ARRAY_TASK_ID: "${SLURM_ARRAY_TASK_ID}
LINE=$(sed -n "$SLURM_ARRAY_TASK_ID"p ${ARGSFILE})
echo "Found Prospino arguments : "
echo $LINE

${EXEDIR}/prospino_2.run ${ECM} ${LINE}

# Clean up - remove the symbolic links
rm $SLHAFILE
rm $PDSFILE
rm $TBLFILE

cd ${CWD}

date
echo 'Job completed'

exit
