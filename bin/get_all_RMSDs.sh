#! /bin/bash

# This file calculates the RMSD for all conformations found for all systems,
# and logs them.

testing_root_dir="$(git rev-parse --show-toplevel)/files_for_charge_comparison/"
testing_dirs=$(ls $testing_root_dir)
bin_dir="$(git rev-parse --show-toplevel)/bin/"

for system in $testing_dirs;
do
	cd "$testing_root_dir/$system"
	echo "Calculating RMSDs for $system"
	echo -n > $system.results
	rm $system.results
	for file in out_*.pdbqt*.pdbqt;
	do
		size=$(cat $file | wc -c)
		if [ $size -ge 10 ];
		then
			echo $file
			$bin_dir/get_rmsd.py ligand_gasteiger.pdbqt $file
		fi | tr '\n' ' ' && echo
	done | grep -v '^$' >> $system.results
done

