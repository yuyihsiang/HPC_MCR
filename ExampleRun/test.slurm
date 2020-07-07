#!/bin/bash

#SBATCH --time=01:00:00       # walltime limit           
#SBATCH --job-name=BargeT75         # name of job              
######SBATCH --partition=debug
#SBATCH --nodes=1            # number of nodes          
#SBATCH --ntasks-per-node=36  # number of tasks per node 
#SBATCH --ntasks=36   # total number of tasks    
 
export TMPDIR=/homes/yyu/tmp/test/PM_OptCd_All 
scontrol show hostnames > nodelist
##starccm='/home/yyu/opt/CD-adapco/13.06.012-R8/STAR-CCM+13.06.012-R8/star/bin/starccm+'
 
echo "------ Running Starccm+ ------"
##$starccm -rsh "ssh -oStrictHostKeyChecking=no" -machinefile nodelist -np $SLURM_NTASKS -batch /home/yyu/scratch/BargeT75/BargeT75.sim >> simulation.log
./runScript >> simulation.log

##rm nodelist
echo "------ End of the job ------"
