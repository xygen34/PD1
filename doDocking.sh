#!/bin/bash

dir=/scratch1/collinhansen/pd1/new_docking
cd $dir

echo "What directory are you docking"
read sets

for set in ${sets[@]}
do
  ligs=($(ls $dir/$set))
  for lig in ${ligs[@]}
  do
    if [ -d "$dir/$set/$lig" ]
    then
      cd $dir/$set/$lig
      
      ./qsub dockPalmetto.sh
   fi
  done
done
