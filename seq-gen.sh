for i in ./refe_tree/*.tree
do
seq-gen -m HKY -l 10000 -op < $i > $i.phy
done

mkdir sec_phy
mv ./refe_tree/*.phy ./sec_phy

