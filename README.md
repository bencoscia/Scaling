# Scaling
Each directory name corresponds to the number of atoms in each system.  
  
66K : 20 layer, 6 monomer per layer dry system  
100K : 20 layer, 6 monomer per layer solvated system  
265K : 80 layer, 6 monomer per layer dry system  
  
The .tpr in each subdirectory of 66K, 100K and 265K is identical. The only thing
that will need to be changed is the node configuration

submit_batches.sh will go into existing directories and copy batch submission 
scripts from the Slurm_Scripts directory into each configuration and submit them.

compile_results.sh will create a text document with the number of steps that were
able to be taken in each node configuration.

plot_scaling.py will interpret the text document from compile_results.sh, do 
some conversion, and then plot the results. 
