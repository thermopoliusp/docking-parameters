#! /bin/bash

# This script generates several images, of the original receptor-ligand
# conformation and of the difference between the closest and farthest
# calculated conformation and the original one.

testing_root_dir="$(git rev-parse --show-toplevel)/files_for_charge_comparison/"
testing_dirs=$(ls $testing_root_dir)
bin_dir="$(git rev-parse --show-toplevel)/bin/"
images_dir="$(git rev-parse --show-toplevel)/images/"

rm -rf $images_dir/*

for system in $testing_dirs;
do
	cd "$testing_root_dir/$system"
	echo "Generating images for system $system..."
	best=$(cat *.results | \
		grep -v convergence | \
		grep $(cat *.results | \
			grep -v convergence | \
			grep _1 | \
			cut -d ' ' -f 2 | \
			sort -n | \
			head -n 1) | \
		cut -d ' ' -f 1)
	worst=$(cat *.results | \
		grep -v convergence | \
		grep $(cat *.results | \
			grep -v convergence | \
			grep _1 | \
			cut -d ' ' -f 2 | \
			sort -n | \
			tail -n 1) | \
		cut -d ' ' -f 1)
	mkdir $images_dir/$system
	echo "Best fit: $best" > $images_dir/$system/log
	echo "Worst fit: $worst" >> $images_dir/$system/log
	$bin_dir/get_image.py $best \
		ligand_gasteiger.pdbqt \
		$images_dir/$system/best.png 0
	$bin_dir/get_image.py $worst \
		ligand_gasteiger.pdbqt \
		$images_dir/$system/worst.png  0
	$bin_dir/get_image.py receptor_gasteiger_hydrogen.pdbqt \
		ligand_gasteiger.pdbqt \
		$images_dir/$system/original.png
done

