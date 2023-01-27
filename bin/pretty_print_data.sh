#! /bin/bash

# This script prints some important results obtained from the data as
# tab-separated table.

bin_dir="$(git rev-parse --show-toplevel)/bin/"

printf "Analysing RMSDs:\n"

printf "Charge\t\t# of systems\tAverage RMSD\tStandard deviation\n"

for opts in {"-l -r","-l -R","-L -r","-L -R"};
do
	if [ "$opts" == "-l -r" ];
	then
		printf "No hydrogens in ligand or receptor\n"
	elif [ "$opts" == "-L -r" ];
	then
		printf "No hydrogens in receptor only\n"
	elif [ "$opts" == "-l -R" ];
	then
		printf "No hydrogens in ligand only\n"
	else
		printf "Hydrogens in both molecules\n"
	fi
	for charge in {none,qeq,qtpie,eem,mmff94,eem2015ha,gasteiger};
	do
		printf "$charge\t"
		if [ ${#charge} -le 7 ];
		then
			printf "\t"
		fi
		$bin_dir/get_data_from_group.sh $opts -n 1 -c $charge | \
			cut -d ' ' -f -3 | tr ' ' '\t' | sed 's/\.000000/\t/g'
	done
	printf "All charges\t"
	$bin_dir/get_data_from_group.sh $opts -n 1 | \
		cut -d ' ' -f -3 | \
		tr ' ' '\t' | \
		sed 's/\.000000/\t/g'
done

