#! /bin/bash

# This script can be executed to group receptor-ligand complexes
# according to their receptors, copying to the same directory receptor,
# ligand and grid files of complexes with same receptor.

root_dir="$(git rev-parse --show-toplevel)"

cd ${root_dir}/shared_receptors

for line in $(cat groups.txt | grep ',' | tr ' ' '_'); do
	newdir="$(echo "$line" | cut -d ':' -f 1 | tr ' ' '_')"
	mkdir $newdir
	for dir in $(cat groups.txt | \
			grep ',' | \
			tr ' ' '_' | \
			grep $newdir | \
			cut -d ':' -f 2 | \
			tr -d '_' | \
			tr ',' '\n'); do
		cp ../files_for_charge_comparison/$dir/receptor_none_hydrogen.pdbqt \
			$newdir/${dir}_receptor.pdbqt
		cp ../files_for_charge_comparison/$dir/ligand_none.pdbqt \
			$newdir/${dir}_ligand.pdbqt
		cp ../files_for_charge_comparison/$dir/grid.conf \
			$newdir/${dir}_grid.conf
	done
done

