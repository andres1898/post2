#disigned by Andres ordoñes, writted in Bash lenguaje, script for run tnt under weight characters
# for run this, you have to install tnt 
for i in ./sec_tnt/*.tnt
do
tnt macro= \; log $i.log \; piwe = \; proc $i \; piwe [ \; mult 100 =tbr \; taxname= \; nel* \; export -$i.wei.tree \; zz 
done

mkdir pars_wei
mkdir pars_wei/log

mv ./sec_tnt/*tree pars_wei
mv ./sec_tnt/*log pars_wei/log
