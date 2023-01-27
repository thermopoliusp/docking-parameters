#! /usr/bin/bash

# This script docks selected files using autodock GPU.

root_dir="$(git rev-parse --show-toplevel)"

cd $root_dir

if [ ! -d autodock ]
then
	mkdir autodock
else
	exit 1
fi

for dir in files_for_charge_comparison/*
do
	export NUMTORS=$(grep TORSDOF < $dir/ligand_none.pdbqt | \
			cut -d ' ' -f 2)
	if [ $NUMTORS -le 25 ]
	then
		cp -r $dir autodock/
		autodock_new_dir=$(basename $dir)
		echo $autodock_new_dir
		cd autodock/$autodock_new_dir
		for charge in {qeq,qtpie,eem,eem2015ha,mmff94,gasteiger}
		do
			recfile="receptor_${charge}_hydrogen.pdbqt"
			ligfile="ligand_${charge}.pdbqt"
			$root_dir/bin/autodock4_complex.sh $recfile $ligfile
		done
		rm $(ls | grep -v "best" | grep -v "glg" | grep -v "dlg")
		cd $root_dir
	fi
done

