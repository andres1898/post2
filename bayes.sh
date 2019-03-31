#script for run raxml for all matrix
for i in ./sec_nex/*.nex
do
mb $i
done

mkdir Bayes
mkdir Bayes/otros
mkdir Bayes/trees

mv ./sec_nex/*ckp~ Bayes/otros
mv ./sec_nex/*ckp Bayes/otros
mv ./sec_nex/*mcmc Bayes/otros
mv ./sec_nex/*parts Bayes/otros
mv ./sec_nex/*.p Bayes/otros
mv ./sec_nex/*.t Bayes/otros
mv ./sec_nex/*.tstat Bayes/otros
mv ./sec_nex/*.vstat Bayes/otros
mv ./sec_nex/*.con.tre Bayes/trees

