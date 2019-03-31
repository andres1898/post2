#disigned by Andres ordoñes, writted in Bash lenguaje, script for run tnt by default parameters
# for run this, you have to install tnt 

for i in ./sec_tnt/*.tnt
do
tnt macro= \; log $i.log \; proc $i \; mult \; taxname= \; nel* \; export -$i.tree \; zz 
done

mkdir pars_defa
mkdir pars_defa/log

mv ./sec_tnt/*tree pars_defa
mv ./sec_tnt/*log pars_defa/log

