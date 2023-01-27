#! /bin/bash

# This script complements the other wrapper for OpenBabel; it
# removes hydrogens from the ligands.

testing_root_dir="$(git rev-parse --show-toplevel)/files_for_charge_comparison/"
testing_dirs=$(ls $testing_root_dir)
pdb_dir="$(git rev-parse --show-toplevel)/original_files/"

for system in $testing_dirs;
do
	for charge in {none,qeq,eqeq,qtpie,eem,eem2015ha,mmff94,gasteiger};
	do
		orig_sdf=$(ls ${pdb_dir}${system}/*ligand.sdf)
		obabel ${orig_sdf} -d --partialcharge $charge -O ${testing_root_dir}${system}/ligand_nohydrogen_${charge}.pdbqt
	done
done

