#!/bin/bash

#this is where your sets are
dir=/scratch1/collinhansen/pd1/new_docking


echo "Docking set to sort?"
read sets

for set in ${sets[@]}
do
  sub_sets=($(ls $dir/$set))

  for sub_set in ${sub_sets[@]}
  do

    if [ -d "$dir/$set/$sub_set" ]
    then
      ligs=($(ls $dir/$set/$sub_set))

      for lig in ${ligs[@]}
      do
        if [ -d "$dir/$set/$sub_set/$lig" ]
        then
          output_file=${dir}/${set}/${sub_set}/${lig}/out.pdbqt

          docking_score=$(head -3 $output_file | grep 'REMARK VINA RESULT'\
            | awk '{print $4}')

          zinc_id=$(head -3 $output_file | grep 'REMARK  Name'\
            | awk '{print $4}')

          echo ${docking_score},${zinc_id},${set},${sub_set},${lig} >>\
            $dir/$set/RAW_docking.csv
        fi
      done
    fi
  done

  echo dock, zinc datbase id, set, sub_set, lig >\
    $dir/$set/docking.csv

  #sorts by docking score
  sort -n ${dir}/${set}/RAW_docking.csv >> ${dir}/${set}/docking.csv

  rm ${dir}/${set}/RAW_docking.csv
done