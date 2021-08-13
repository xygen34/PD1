#!/bin/bash

dir=/scratch/chansen/pd1/new_docking
cd $dir

echo "What directory are you 'obabel'-ing"
read sets

for set in ${sets[@]}
do
  ligs=($(ls $dir/$set))
  for lig in ${ligs[@]}
  do
    if [ -d "$dir/$set/$lig" ]
    then
      cd $dir/$set/$lig
      obabel -isdf $dir/$set/$lig/$set$lig.xaa.sdf -opdbqt -O${lig}_.pdbqt -m
      echo $set $lig complete 
   fi
  done
done
~                                                                                                                                             
~                                                                                                                                             
~                                                      