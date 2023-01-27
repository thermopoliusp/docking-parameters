#! /bin/bash

# This script creates a directory and fills it with all receptor-ligand
# pairs to which charges and hydrogens atoms were successfully added/removed.

max_sims_ok=4 # 4 different charge models considered; EQEq and others discarded
testing_root_dir="$(git rev-parse --show-toplevel)/files_from_rcsb/original_files_and_defaults/"
ligand_dir="$(git rev-parse --show-toplevel)/files_for_charge_comparison/"
charge_root_dir="$(git rev-parse --show-toplevel)/files_from_rcsb/files_for_charge_comparison/"

if [ ! -d $charge_root_dir ];
then
	mkdir -p $charge_root_dir
else
	rm -rf $charge_root_dir && mkdir -p $charge_root_dir
fi

for dir in $testing_root_dir/*;
do
	sims_ok=$(du $dir/*.pdbqt | grep -v ^0 | wc -l)
	if [ "$sims_ok" -ge "$max_sims_ok" ];
	then
		mkdir $charge_root_dir$(basename $dir)
		for file in $dir/*.pdbqt;
		do
			cp $file $charge_root_dir$(basename $dir)
		done
		cp $ligand_dir$(basename $dir)/grid.conf $charge_root_dir$(basename $dir)
		for ligand in $ligand_dir$(basename $dir)/ligand_*;
		do
			cp $ligand $charge_root_dir$(basename $dir)/$(basename $ligand)
		done
		rm -rf $charge_root_dir$(basename $dir)/*_eqeq*
		rm -rf $charge_root_dir$(basename $dir)/*_qtpie*
		rm -rf $charge_root_dir$(basename $dir)/*_eem2015ha*
		rm -rf $charge_root_dir$(basename $dir)/*_mmff94*
		rm -rf $charge_root_dir$(basename $dir)/*nohydrogen*
	fi
done

