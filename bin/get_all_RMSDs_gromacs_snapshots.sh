#! /bin/bash

# This file calculates the RMSD for all conformations found for the 4DJR system
# and logs them.

testing_root_dir="$(git rev-parse --show-toplevel)/GROMACS/4djr/snapshots/"
bin_dir="$(git rev-parse --show-toplevel)/bin/"

cd $testing_root_dir

echo "time [s],simulation,position,RMSD [Å]" > results.csv

for TIMESTAMP in {0000..2000..20};
do
	for EXPERIMENT in {0..9};
	do
		for POSITION in {1..10};
		do
			file=out_${TIMESTAMP}_receptor_ligand_${EXPERIMENT}.pdbqt_${POSITION}.pdbqt
			if [ -f $file ];
			then
				size=$(cat $file | wc -c)
				if [ $size -ge 10 ];
				then
					(echo $file
					$bin_dir/get_rmsd.py ligand.pdbqt $file) \
						| tr '\n' ' ' && echo
				fi | \
					sed -e "s/\./_/;s/\./_/;s/\ /_/" | \
					cut -d '_' -f 2,5,7,9 | \
					tr '_' ',' >> results.csv
			fi
		done
	done
done

