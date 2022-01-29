#!/usr/bin bash
#SBATCH --chdir=/home/grahman/projects/matchlock-analyses
#SBATCH --output=/home/grahman/projects/matchlock-analyses/slurm_out/%x.%j.out
#SBATCH --partition=long
#SBATCH --mem=16G
#SBATCH --time=12:00:00

date; pwd; hostname

source ~/miniconda3/bin/activate matchlock

CTX="Deblur_2021.09-Illumina-16S-V4-150nt-ac8c0b"
SAMPLE_FILE="data/samples.txt"
TABLE="data/table.biom"
MD="data/metadata.tsv"

redbiom search metadata "where qiita_study_id == 10317" | \
    redbiom select samples-from-metadata --context $CTX "where sample_type in ('Stool', 'stool')" | \
    redbiom select samples-from-metadata --context $CTX "where age_years < 30" > $SAMPLE_FILE

redbiom fetch samples --from $SAMPLE_FILE --context $CTX --output $TABLE
redbiom fetch sample-metadata --from $SAMPLE_FILE --context $CTX --output $MD
