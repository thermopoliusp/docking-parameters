#! /bin/bash

# This file shows the commands used to run a molecular dynamics simulation
# of beta-lactoglobulin using GROMACS.

# converting .pdb to .gro format, applying force fields, etc.
gmx pdb2gmx -f 3NQ3_original.pdb \
		-o 3NQ3_forcefield.gro \
		-water tip3p \
		-ff amber99sb \
		-ignh

# creating a cubic periodic box, with our protein at its center, with at
# least 2x1.0 = 2.0nm gap between protein images.
gmx editconf -f 3NQ3_forcefield.gro -o 3NQ3_box.gro -c -d 1.0 -bt cubic

# Solvating box created previously.
gmx solvate -cp 3NQ3_box.gro -cs spc216.gro -o 3NQ3_solvated.gro -p topol.top

# Including ions to obtain a neutral charge
gmx grompp -f ions.mdp -c 3NQ3_solvated.gro -p topol.top -o ions.tpr
# Substitute only solvent molecules.
echo "SOL" | \
	gmx genion -s ions.tpr -o 3NQ3_ions.gro \
		-p topol.top -pname NA -nname CL -neutral

# And we start the energy minimization.
gmx grompp -f minim.mdp -c 3NQ3_ions.gro -p topol.top -o em.tpr
gmx mdrun -v -deffnm em

# And canonical equilibration.
gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
gmx mdrun -v -deffnm nvt

# We end the equilibration step with isothermal–isobaric equilibration.
gmx grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
gmx mdrun -v -deffnm npt

# And finally we proceed to the production simulation.
gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_2_0.tpr
gmx mdrun -v -deffnm md_2_0

