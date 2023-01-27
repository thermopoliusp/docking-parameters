#! /bin/bash

# This is a wrapper for OpenBabel. It adds charges and deal with hydrogens
# in bulk.

# we need this to avoid spawning thousands (literally!)
# of computationally intensive jobs, which would either
# freeze the system or trigger the OOM-killer.
function if_enough_threads_available () {
	while [ $(jobs -p | wc -w) -ge 17 ] || \
		[ $(cat /proc/meminfo | \
			grep MemFree | \
			cut -d ':' -f 2 | \
			tr -d ' kB' ) -le 5000000 ];
	do
		sleep 1;
	done
}

testing_root_dir="$(git rev-parse --show-toplevel)/files_for_docking/"
testing_dirs=$(ls $testing_root_dir)

for system in $testing_dirs;
do
	cd "$testing_root_dir/$system"
	echo "Now adding charges to system $system"
	for charge in {none,qeq,eqeq,qtpie,eem,eem2015ha,mmff94,gasteiger};
	do
		if_enough_threads_available
		obabel ${system}_protein_prep.pdb -h --partialcharge $charge -xrh -O  ${system}_receptor_${charge}_hydrogen.pdbqt &
		if_enough_threads_available
		obabel ${system}_protein_prep.pdb -d --partialcharge $charge -xr -O  ${system}_receptor_${charge}_nohydrogen.pdbqt &
		if_enough_threads_available
		obabel ${system}_ligand.sdf --partialcharge $charge -xh -O  ${system}_ligand_${charge}.pdbqt &
	done
done
