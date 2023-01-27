#! /bin/bash

# This script is a wrapper for the docking program. It docks several pairs
# automatically, splitting the resulting conformations. Applies to files
# obtained through CHARMM-GUI.

# This function splits the conformations found in Vina's output .pdbqt.
function split_out () {
	awk 'BEGIN{
		RS="ENDMDL"
	}{
		number++;
		print $0 > filename"_"number".pdbqt"
	}' filename=$1 $1
}

bin_dir="$(git rev-parse --show-toplevel)/bin/"
charge_dir="$(git rev-parse --show-toplevel)/files_from_rcsb/files_for_charge_comparison/"

for system_dir in $charge_dir/*; do

	cd $system_dir
	echo $system_dir

	for charge in {none,qeq,eem,gasteiger};
	do
		$bin_dir/vina_wrapper.sh receptor_${charge}_default ligand_${charge}
		split_out out_receptor_${charge}_default_ligand_${charge}.pdbqt
		if [ -f "receptor_gasteiger_disulfide.pdbqt" ];
		then
			$bin_dir/vina_wrapper.sh receptor_${charge}_disulfide ligand_${charge}
			split_out out_receptor_${charge}_disulfide_ligand_${charge}.pdbqt
		fi
		if [ -f "receptor_gasteiger_nocorrection.pdbqt" ];
		then
			$bin_dir/vina_wrapper.sh receptor_${charge}_nocorrection ligand_${charge}
			split_out out_receptor_${charge}_nocorrection_ligand_${charge}.pdbqt
		fi
	done
done

