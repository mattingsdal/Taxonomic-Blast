#!/bin/sh
#SBATCH --account=cees
#SBATCH --time=30:00:00
#SBATCH --mem-per-cpu=2G
#SBATCH --nodes=1
#SBATCH --tasks-per-node=8

source /cluster/bin/jobsetup

DATASET=results.fasta
OUTFILE=results.fasta.out

BDB=/work/databases/bio/ncbi-pre/nt

cp $SUBMITDIR/$DATASET $SCRATCH
chkfile $OUTFILE

cd $SCRATCH
module purge
module load blast+/2.2.29
blastn -query $DATASET -db /work/databases/bio/ncbi-pre/nt  -max_target_seqs 1  -out $OUTFILE -num_threads=8 -outfmt "6 std staxids sscinames sskingdoms"
