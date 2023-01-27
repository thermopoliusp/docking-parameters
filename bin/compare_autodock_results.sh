#! /usr/bin/bash

root_dir="$(git rev-parse --show-toplevel)"

cd $root_dir

for dir in autodock/*
do
	for charge in {qeq,qtpie,eem,eem2015ha,mmff94,gasteiger}
	do
		dirname=$(basename $dir)
		echo -n "$charge,"
		$root_dir/bin/get_rmsd.py \
			autodock/$dirname/ligand_${charge}_best.pdbqt \
			files_for_charge_comparison/$dirname/ligand_${charge}.pdbqt
	done | grep -v Matrix > $dir/RMSDs.csv
done

