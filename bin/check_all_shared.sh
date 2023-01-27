#! /bin/bash

# This script executes docking simulations for receptors and ligands from
# possibly different complexes.

root_dir="$(git rev-parse --show-toplevel)"

cd $root_dir

cd shared_receptors

for dir in $(ls | grep -v "groups.txt" | grep -v "README"); do
	cd $dir;
	list=$(ls | grep -v out_ | grep -v log_ | cut -d '_' -f 1 | sort | uniq)
	for receptor in $list; do
		for ligand in $list; do
			${root_dir}/bin/vina_wrapper_shared.sh $receptor $ligand
		done
	done
	for receptor in $list; do
		for ligand  in $list; do
			echo -n "$receptor $ligand "
			cat log_${receptor}_${ligand}.log | \
				grep "mode" -A 3 | \
				tail -n 1 | \
				tr ' ' 'G' | \
				sed -e 's/G\+/G/g' | \
				cut -d 'G' -f 3
		done
	done > results.txt
	cd ..
done

