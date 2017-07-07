#!/bin/bash

#SBATCH -p shas 
#SBATCH -N nodes --tasks-per-node=4
#SBATCH --qos normal
#SBATCH -t 00:30:00

module load gromacs

mpirun -np processes gmx_mpi mdrun -v -deffnm wiggle
