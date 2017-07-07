#!/bin/bash

slurm_script="summit_shas.sh"
tasks_per_node=4
configs="66K 100K 265K"

while getopts "s:t:d:" opt; do
    case $opt in
    s) slurm_script=$OPTARG;;
    t) tasks_per_node=$OPTARG;;
    d) configs=$OPTARG;;
    esac
done

for system in ${configs}; do
	cd ${system};
	for nodes in *; do
		cd ${nodes};
		cp ../../Slurm_Scripts/${slurm_script} .
		processes=$((tasks_per_node*nodes))
		sed -i -e "s/nodes/${nodes}/g" ${slurm_script}
		sed -i -e "s/processes/${processes}/g" ${slurm_script}
		sbatch ${slurm_script}
		cd ..;
	done
	cd ..;
done
