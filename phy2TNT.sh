#convert phy format to TNT format
for i in ./sec_phy/*.phy
do
awk 'BEGIN {print "macro=;\nnstates DNA;\nxread \047 This is test 001 \047  "};
    (NR==1) {print $2, $1};
    (NR>1) {print $0};
    END {print ";\nproc/"}' "$i" > "${i%.tree.phy}.tnt"
done

mkdir sec_tnt

mv sec_phy/*.tnt sec_tnt
