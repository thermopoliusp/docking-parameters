#! /bin/bash

# This file extracts snapshots from the trajectory file obtained through
# molecular dynamics simulations of the protein in complex with PDB ID
# 2YKI, and performs several dockings in each snapshot.

function split_out () {
	awk 'BEGIN{
		RS="ENDMDL"
	}{
		number++;
		print $0 > filename"_"number".pdbqt"
	}' filename=$1 $1
}

top=$(git rev-parse --show-toplevel)
gromdir=$top/GROMACS/2yki

cd $gromdir
rm -rf snapshots/
mkdir snapshots/
cp md_2_0.xtc snapshots/
cp md_2_0.tpr snapshots/
cp 2YKI_original.pdb snapshots/
cp ../gro_correction_and_charges/2yki/grid.conf snapshots/
cp ../gro_correction_and_charges/2yki/2yki_ligand.pdbqt snapshots/ligand.pdbqt
cd snapshots
for i in {000..200..2}; do
	echo 1 | \
		gmx trjconv -f \
			md_2_0.xtc \
			-s md_2_0.tpr \
			-dump ${i}0 \
			-o ${i}0_unaligned.pdb
	$top/bin/align_pdb.py ${i}0_unaligned.pdb \
		2YKI_original.pdb \
		${i}0_aligned.pdb >> RMSDs.txt
	obabel ${i}0_aligned.pdb -h --partialcharge none \
		-xrh -O ${i}0_receptor.pdbqt
	for j in {0..9}; do
		cp ligand.pdbqt ligand_${j}.pdbqt
		$top/bin/vina_wrapper.sh ${i}0_receptor ligand_${j}
		split_out out_${i}0_receptor_ligand_${j}.pdbqt
		rm ligand_${j}.pdbqt
	done
done


