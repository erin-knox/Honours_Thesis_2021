#!/bin/bash -e
#SBATCH --job-name=ArrayJob_ANI           # job name (shows up in the queue)
#SBATCH --time=06:00:00                 # Walltime (HH:MM:SS)
#SBATCH --profile=task
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=1
#SBATCH --account=nesi00458

#load modules
module load FastANI/1.1-gimkl-2018b

ANI=/nesi/nobackup/nesi00458/Erin/ANI/Gems

cd $ANI

#assigning variable to each bin, the bin list contains a list of bin names (don't need pathway as bins are in the working directory)
for i in $(cat /nesi/nobackup/nesi00458/Erin/ANI/ContamCut.txt)
do
        for x in $(cat /nesi/nobackup/nesi00458/Erin/ANI/ContamCut.txt)
        do
        fastANI -q $i -r $x -o {$i}_{$x}.out
        done
done

#concatenate output files
cat /nesi/nobackup/nesi00458/Erin/ANI/Gems/*.out >> /nesi/nobackup/nesi00458/Erin/ANI/Gems_ani_results.txt

cat /nesi/nobackup/nesi00458/Erin/ANI/Gems_ani_results.txt|tr '\t' ',' > /nesi/nobackup/nesi00458/Erin/ANI/Gems_ani_results.csv
