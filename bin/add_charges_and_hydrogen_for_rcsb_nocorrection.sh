#! /bin/bash

# This is a wrapper for OpenBabel. It adds charges and deal with hydrogens
# in bulk. (This version works for files from RCSB, without gap corrections,
# from CHARMM).

# we need this to avoid spawning thousands (literally!)
# of computationally intensive jobs, which would either
# freeze the system or trigger the OOM-killer.
function if_enough_threads_available () {
	while [ $(jobs -p | wc -w) -ge 2 ] || \
		[ $(cat /proc/meminfo | \
			grep MemFree | \
			cut -d ':' -f 2 | \
			tr -d ' kB' ) -le 10000000 ];
	do
		sleep 1;
	done
}

testing_root_dir="$(git rev-parse --show-toplevel)/files_from_rcsb/original_files_and_defaults/"
testing_dirs=$(ls $testing_root_dir)

for system in $testing_dirs;
do
	cd "$testing_root_dir/$system"
	if [ -f "protein_nocorrection.pdb" ];
	then
		echo "Now adding charges to system $system"
		for charge in {none,qeq,qtpie,eem,eem2015ha,mmff94,gasteiger};
		do
			if_enough_threads_available
			obabel protein_nocorrection.pdb -h --partialcharge $charge \
				-xrh -O  receptor_${charge}_nocorrection.pdbqt &
		done
	fi
done
