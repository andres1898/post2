#script for run raxml for all matrix
for i in sec_phy/*.phy
do
raxml-ng --msa $i --model HKY
done

mkdir ML_HKY
mkdir ML_HKY/log
mkdir ML_HKY/otros

mv sec_phy/*bestTree ML_HKY
mv sec_phy/*log ML_HKY/log
mv sec_phy/*bestModel ML_HKY/otros
mv sec_phy/*mlTrees ML_HKY/otros
mv sec_phy/*rba ML_HKY/otros
mv sec_phy/*startTree ML_HKY/otros

