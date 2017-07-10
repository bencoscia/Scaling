#!/bin/bash

directories="66K 100K 265K"  # names of directories containing scaling results
length="30" # length of simulation (minutes)

while getopts "d:l:" opt; do
	case $opt in
	d) directories=$OPTARG;;
	l) length=$OPTARG;;
	esac
done

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Scaling Results" > scaling.txt
echo "Tests run for ${length} min" >> scaling.txt
echo ${directories}

for dir in ${directories}; do
	cd $dir; 
	echo "${dir} atoms" >> ${DIR}/scaling.txt
	echo "Nodes    Nsteps" >> ${DIR}/scaling.txt
	for nodes in *; do 
		cd ${nodes};
		line=$(grep -n 'imb F' *.out | tail -n1) # last line containing step count
		nsteps=$(echo "${line#*step}" | cut -d , -f1)  # extract the number of steps from that line
		echo "${nodes} ${nsteps}" >> ${DIR}/scaling.txt # record the result
		cd ..;
	done
	cd ..;
done

