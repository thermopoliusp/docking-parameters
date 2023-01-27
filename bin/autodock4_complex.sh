#! /usr/bin/bash

# This script reads information from pdbqt files and uses it to dock those files
# using autodockGPU.

############
##   PART I: File names
############

recfile=$1
ligfile=$2
recfilename=$(echo $recfile | cut -d '.' -f 1)
ligfilename=$(echo $ligfile | cut -d '.' -f 1)
resgridname="${recfilename}_grid.gpf"
loggridname="${recfilename}_grid.glg"

############
##  PART II: Reading PDBQT info
############

export npts=$(echo "scale=0;
	2*$(cat grid.conf | \
		grep "\(gridSize\|rstep\)" | \
		cut -d ' ' -f 2 | \
		tr '\n' '/' | \
		sed 's/\/$/\n/g') + 1" | \
	bc -l)

export spacing=$(cat grid.conf | \
	grep rstep | \
	cut -d ' ' -f 2)

function types () {
	cat $1 | \
		grep ^ATOM | \
		sed 's/\ \+/,/g' | \
		rev | sed 's/^,//g' | \
		cut -d ',' -f 1 | rev | \
		sort | uniq | \
		tr '\n' ' ' | sed 's/\ $//g'
}

export receptor_types=$(types $recfile)
export ligand_types=$(types $ligfile)

export gridcenter=$(cat grid.conf | \
	grep "[XYZ]" | \
	cut -d ' ' -f 2 | \
	tr '\n' ' ' | sed 's/\ $//g')

echo "npts $npts $npts $npts" > $resgridname
echo "gridfld ${recfilename}.maps.fld" >> $resgridname
echo "spacing $spacing" >> $resgridname
echo "receptor_types $receptor_types" >> $resgridname
echo "ligand_types $ligand_types" >> $resgridname
echo "receptor $recfile" >> $resgridname
echo "gridcenter $gridcenter" >> $resgridname

for elem in $ligand_types
do
	echo "map ${recfilename}.${elem}.map" >> $resgridname
done

echo "elecmap ${recfilename}.e.map" >> $resgridname
echo "dsolvmap ${recfilename}.d.map" >> $resgridname

############
## PART III: Executing AutoGrid4
############

autogrid4 -p $resgridname -l $loggridname

############
##  PART IV: Executing AutoDockGPU
############

autodock_gpu_64wi --lfile $ligfile \
	--ffile ${recfilename}.maps.fld \
	--nrun 50

############
##   PART V: Reading resulting file
############

export bestconformation=$(cat $ligfilename.dlg | \
		grep "RMSD TABLE" -A 9 | \
		tail -n 1 | \
		sed 's/\ \+/,/g' | \
		cut -d ',' -f 4)

function split_out () {
	awk 'BEGIN{
		RS="ENDMDL"
	}{
		number++;
		print $0 > filename"_"number".pdbqt"
	}' filename=$1 $1
}

cat $ligfilename.dlg | \
	grep ^DOCKED | \
	sed -e 's/^DOCKED:\ //g' > $ligfilename

split_out $ligfilename

mv "${ligfilename}_${bestconformation}.pdbqt" \
	"${ligfilename}_best.pdbqt"

