#! /bin/bash

# This script reads all logs written by Vina and extracts the affinity values.

testing_root_dir="$(git rev-parse --show-toplevel)/GROMACS/gro_correction_and_charges"
testing_dirs=$(ls $testing_root_dir | grep -v RMSD)

for characteristic in {_em,_nvt,_npt};
do
	for system in $testing_dirs;
	do
		cd "${testing_root_dir}${characteristic}/$system"
		echo "Calculating affinities for $system"
		for filename_partial in $(ls | \
			grep -v pdbqt_ | \
			grep out | \
			cut -d '_' -f 2- | \
			cut -d '.' -f 1);
		do
			cat log_${filename_partial}.log | \
				grep mode -A 123 | \
				tail -n +4 | \
				sed -e 's/\ \+/\ /g;s/^\ //g' | \
				cut -d ' ' -f -2 | \
				sed -e "s/^/out_${filename_partial}.pdbqt_/g;s/\ /.pdbqt /g"
		done > $system.affinities
	done
done


