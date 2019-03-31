#script for run raxml for all matrix
for i in ./sec_phy/*.phy
do
raxml-ng --msa $i --model GTR+G4
done

mkdir ML_def
mkdir ML_def/log
mkdir ML_def/otros

mv ./sec_phy/*bestTree ML_def
mv ./sec_phy/*log ML_def/log
mv ./sec_phy/*bestModel ML_def/otros
mv ./sec_phy/*mlTrees ML_def/otros
mv ./sec_phy/*rba ML_def/otros
mv ./sec_phy/*startTree ML_def/otros

