#! /bin/bash

# This script is a wrapper for the docking program. It docks several pairs
# automatically, splitting the resulting conformations. (Now we use ligands
# with hydrogen atoms removed).

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
charge_dir="$(git rev-parse --show-toplevel)/files_for_charge_comparison/"

for system_dir in $charge_dir/*; do

	cd $system_dir
	echo $system_dir
	rm *eqeq*

	for charge in {none,qeq,qtpie,eem,eem2015ha,mmff94,gasteiger};
	do
		$bin_dir/vina_wrapper.sh receptor_${charge}_hydrogen ligand_nohydrogen_${charge}
		split_out out_receptor_${charge}_hydrogen_ligand_nohydrogen_${charge}.pdbqt
		$bin_dir/vina_wrapper.sh receptor_${charge}_nohydrogen ligand_nohydrogen_${charge}
		split_out out_receptor_${charge}_nohydrogen_ligand_nohydrogen_${charge}.pdbqt
	done
done

