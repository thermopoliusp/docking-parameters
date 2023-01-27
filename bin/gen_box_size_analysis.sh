#! /usr/bin/bash

# This script verifies the influence of "exhaustiveness" and box size in
# docking simulations performed via Vina. Here, all torsions are active.

function split_out () {
	awk 'BEGIN{
		RS="ENDMDL"
	}{
		number++;
		print $0 > filename"_"number".pdbqt"
	}' filename=$1 $1
}

root_dir="$(git rev-parse --show-toplevel)"

cd $root_dir

if [ ! -d box_size ]
then
	mkdir box_size
fi

for dir in $(ls files_for_docking/)
do
	if [ ! -d box_size/$dir ]
	then
		mkdir box_size/$dir
		cp files_for_docking/$dir/*_ligand_none.pdbqt \
			box_size/$dir/ligand.pdbqt
		cp files_for_docking/$dir/*_receptor_none_hydrogen.pdbqt \
			box_size/$dir/receptor.pdbqt
		cp files_for_docking/$dir/grid.conf box_size/$dir/
		cd box_size/$dir/
		X_center=$(grep X <grid.conf | cut -d ':' -f 2)
		Y_center=$(grep Y <grid.conf | cut -d ':' -f 2)
		Z_center=$(grep Z <grid.conf | cut -d ':' -f 2)
		half_grid=$(grep gridSize <grid.conf | cut -d ':' -f 2)
		for exh in {2,4,8,16,32}
		do
			for size in {1,2,4,8,16}
			do
				box=$(echo "scale = 10; 0.5 * $size * $half_grid" | bc -l)
				vina --cpu 16 \
					--center_x $X_center \
					--center_y $Y_center \
					--center_z $Z_center \
					--size_x $box \
					--size_y $box \
					--size_z $box \
					--exhaustiveness $exh \
					--ligand ligand.pdbqt \
					--out out_"$size"_"$exh".pdbqt \
					--receptor receptor.pdbqt >> \
						log_"$size"_"$exh".log
				split_out out_"$size"_"$exh".pdbqt
			done
		done
		cd $root_dir
	fi
done

