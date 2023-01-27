#! /bin/bash

# This script calls vina with the box arguments found in file grid.conf

RECEPTOR="$1" # receptor file to be used
LIGAND="$2" # ligand file to be used

# using grid.conf to find box center and size
X_center=$(grep X <grid.conf | cut -d ':' -f 2)
Y_center=$(grep Y <grid.conf | cut -d ':' -f 2)
Z_center=$(grep Z <grid.conf | cut -d ':' -f 2)
half_grid=$(grep gridSize <grid.conf | cut -d ':' -f 2)
grid_size=$(echo "scale = 10; 2 * $half_grid" | bc -l)

vina --cpu 16 \
	--center_x $X_center \
	--center_y $Y_center \
	--center_z $Z_center \
	--size_x $grid_size \
	--size_y $grid_size \
	--size_z $grid_size \
	--exhaustiveness 20 \
	--ligand "$LIGAND".pdbqt \
	--out out_"$RECEPTOR"_"$LIGAND".pdbqt \
	--receptor "$RECEPTOR".pdbqt >> log_"$RECEPTOR"_"$LIGAND".log


