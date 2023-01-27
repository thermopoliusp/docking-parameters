#! /usr/bin/bash

# This script calculates the RMSD for all values obtained
# in directory ``box size'', storing them in a CSV file;
# here, all torsions are active.

root_dir="$(git rev-parse --show-toplevel)"

for dir in $(ls files_for_docking/)
do
	cd $root_dir/box_size/$dir
	echo "size,exhaustiveness,conformation,RMSD" > RMSDs.csv
	for file in $(ls out*.pdbqt_*)
	do
		if [[ $(wc -c $file | cut -d ' ' -f 1) -ge 10 ]]
		then
			RMSD=$($root_dir/bin/get_rmsd.py $file ligand.pdbqt)
			echo -n "$file" \
				| tr -cd '[0-9]_' \
				| sed 's/^_//g;s/$/_/g' \
				| tr '_' ',' >> RMSDs.csv
			echo $RMSD >> RMSDs.csv
		fi
	done
done

