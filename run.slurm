#!/bin/bash
#SBATCH -J test
#SBATCH -o test.out
#SBATCH -e test.err
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 00:10:00
#SBATCH -A IRI25015
#SBATCH -p gh

cd ~/Demo

module purge
module load gcc
module load cuda
module load python3

source ~/Demo/venv/bin/activate

python3 test.py