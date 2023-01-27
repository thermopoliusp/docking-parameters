#! /bin/bash

#This script executes all simulations for all comparisons.
# Not tested; estimated time  to completion: one to two weeks.

bin_dir="$(git rev-parse --show-toplevel)/bin/"

$bin_dir/add_charges_and_hydrogen.sh
$bin_dir/add_charges_ligand_no_hydrogens.sh

$bin_dir/create_dir_for_charge_comparison.sh

$bin_dir/dock_in_bulk.sh
$bin_dir/dock_in_bulk_nohydrogen.sh

$bin_dir/get_all_affinities.sh
$bin_dir/get_all_RMSDs.sh

$bin_dir/add_charges_and_hydrogen_for_rcsb_default.sh
$bin_dir/add_charges_and_hydrogen_for_rcsb_disulfide.sh
$bin_dir/add_charges_and_hydrogen_for_rcsb_nocorrection.sh

$bin_dir/create_dir_for_rcsb_files_charge_comparison.sh

$bin_dir/dock_in_bulk_rcsb.sh

$bin_dir/get_all_affinities_charmm.sh
$bin_dir/get_all_RMSDs_charmm.sh

for dir in $(ls $(git rev-parse --show-toplevel)/GROMACS | \
		grep -v README | \
		grep -v gromos);
do
	cd $(git rev-parse --show-toplevel)/GROMACS/$dir
	./${dir}_gromacs.sh
done

$bin_dir/convert_and_charge_GROMACS_files.sh

