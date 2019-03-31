#script for became phy format to Nexus-mrbayes format
for i in sec_phy/*.phy
do
awk 'BEGIN {print "#NEXUS \n \nBEGIN DATA;"};
	(NR==1) {print "\tDIMENSIONS " " NTAX=" $1 " NCHAR="$2";"};
	(NR==2){print "\tFORMAT DATATYPE = DNA GAP = - MISSING = ?; \n \tMATRIX"}
	(NR>1) {print $0};
	END {print "; \n \nEND;"}
	END {print "begin mrbayes;"}
	END {print "lset nst=6 rates=gamma;"}
	END {print "\tmcmcp ngen= 10000 relburnin=yes burninfrac=0.25 printfreq=10  samplefreq=10 nchains=4 savebrlens=yes; \n\tmcmc;\n\tsumt;\nend;"}' "$i" > "${i%.tree.phy}.nex"
done

mkdir sec_nex

mv sec_phy/*.nex sec_nex

	


