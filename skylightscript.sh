#!/bin/bash
#
#PBS -N jtest-1
#PBS -o jtest-1.o%j
#PBS -l select=1:ncpus=4:mem=12gb:ngpus=1:gpu_model=rtx6000
#PBS -l walltime=48:00:00
#PBS -q skygpu
#PBS -j oe

cd $PBS_O_WORKDIR

module load amber/20 cuda/10.2.89-gcc/8.3.1 openblas/0.3.10-gcc/7.1.0

$AMBERHOME/bin/pmemd.cuda -O -i min1.mdin -p NS2_zinc_solv.prmtop -c NS2_zinc_solv.inpcrd -ref NS2_zinc_solv.inpcrd -o NS2_zinc_solv_min1.mdout -r NS2_zinc_solv_min1.rst7 -x NS2_zinc_solv_min1.nc

$AMBERHOME/bin/pmemd.cuda -O -i min2.mdin -p NS2_zinc_solv.prmtop -c NS2_zinc_solv_min1.rst7 -ref NS2_zinc_solv_min1.rst7 -o NS2_zinc_solv_min2.mdout -r NS2_zinc_solv_min2.rst7 -x NS2_zinc_solv_min2.nc

$AMBERHOME/bin/pmemd.cuda -O -i min3.mdin -p NS2_zinc_solv.prmtop -c NS2_zinc_solv_min2.rst7 -ref NS2_zinc_solv_min2.rst7 -o NS2_zinc_solv_min3.mdout -r NS2_zinc_solv_min3.rst7 -x NS2_zinc_solv_min3.nc

$AMBERHOME/bin/pmemd.cuda -O -i min4.mdin -p NS2_zinc_solv.prmtop -c NS2_zinc_solv_min3.rst7 -ref NS2_zinc_solv_min3.rst7 -o NS2_zinc_solv_min4.mdout -r NS2_zinc_solv_min4.rst7 -x NS2_zinc_solv_min4.nc

$AMBERHOME/bin/pmemd.cuda -O -i min5.mdin -p NS2_zinc_solv.prmtop -c NS2_zinc_solv_min4.rst7 -ref NS2_zinc_solv_min4.rst7 -o NS2_zinc_solv_min5.mdout -r NS2_zinc_solv_min5.rst7 -x NS2_zinc_solv_min5.nc

$AMBERHOME/bin/pmemd.cuda -O -i min6.mdin -p NS2_zinc_solv.prmtop -c NS2_zinc_solv_min5.rst7 -ref NS2_zinc_solv_min5.rst7 -o NS2_zinc_solv_min6.mdout -r NS2_zinc_solv_min6.rst7 -x NS2_zinc_solv_min6.nc

$AMBERHOME/bin/pmemd.cuda -O -i min7.mdin -p NS2_zinc_solv.prmtop -c NS2_zinc_solv_min6.rst7 -ref NS2_zinc_solv_min6.rst7 -o NS2_zinc_solv_min7.mdout -r NS2_zinc_solv_min7.rst7 -x NS2_zinc_solv_min7.nc

#Heating

$AMBERHOME/bin/pmemd.cuda -O -i heat.mdin -p NS2_zinc_solv.prmtop -c NS2_zinc_solv_min7.rst7 -ref NS2_zinc_solv_min7.rst7 -o NS2_zinc_solv_heat.mdout -r NS2_zinc_solv_heat.rst7 -x NS2_zinc_solv_heat.nc

#Equilibration

$AMBERHOME/bin/pmemd.cuda -O -i eq1.mdin -p NS2_zinc_solv.prmtop -c NS2_zinc_solv_heat.rst7 -ref NS2_zinc_solv_heat.rst7 -o NS2_zinc_solv_eq1.mdout -r NS2_zinc_solv_eq1.rst7 -x NS2_zinc_solv_eq1.nc

$AMBERHOME/bin/pmemd.cuda -O -i eq2.mdin -p NS2_zinc_solv.prmtop -c NS2_zinc_solv_eq1.rst7 -ref NS2_zinc_solv_eq1.rst7 -o NS2_zinc_solv_eq2.mdout -r NS2_zinc_solv_eq2.rst7 -x NS2_zinc_solv_eq2.nc

$AMBERHOME/bin/pmemd.cuda -O -i eq3.mdin -p NS2_zinc_solv.prmtop -c NS2_zinc_solv_eq2.rst7 -ref NS2_zinc_solv_eq2.rst7 -o NS2_zinc_solv_eq3.mdout -r NS2_zinc_solv_eq3.rst7 -x NS2_zinc_solv_eq3.nc

$AMBERHOME/bin/pmemd.cuda -O -i eq4.mdin -p NS2_zinc_solv.prmtop -c NS2_zinc_solv_eq3.rst7 -ref NS2_zinc_solv_eq3.rst7 -o NS2_zinc_solv_eq4.mdout -r NS2_zinc_solv_eq4.rst7 -x NS2_zinc_solv_eq4.nc

$AMBERHOME/bin/pmemd.cuda -O -i eq5.mdin -p NS2_zinc_solv.prmtop -c NS2_zinc_solv_eq4.rst7 -ref NS2_zinc_solv_eq4.rst7 -o NS2_zinc_solv_eq5.mdout -r NS2_zinc_solv_eq5.rst7 -x NS2_zinc_solv_eq5.nc

$AMBERHOME/bin/pmemd.cuda -O -i eq6.mdin -p NS2_zinc_solv.prmtop -c NS2_zinc_solv_eq5.rst7 -ref NS2_zinc_solv_eq5.rst7 -o NS2_zinc_solv_eq6.mdout -r NS2_zinc_solv_eq6.rst7 -x NS2_zinc_solv_eq6.nc

$AMBERHOME/bin/pmemd.cuda -O -i eq7.mdin -p NS2_zinc_solv.prmtop -c NS2_zinc_solv_eq6.rst7 -ref NS2_zinc_solv_eq6.rst7 -o NS2_zinc_solv_eq7.mdout -r NS2_zinc_solv_eq7.rst7 -x NS2_zinc_solv_eq7.nc

#unrestrained

$AMBERHOME/bin/pmemd.cuda -O -i md.mdin -p NS2_zinc_solv.prmtop -c NS2_zinc_solv_eq7.rst7 -ref NS2_zinc_solv_eq7.rst7 -o NS2_zinc_md001.mdout -r NS2_zinc_md001.rst7 -x NS2_zinc_md001.nc