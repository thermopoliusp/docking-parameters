#! /bin/bash

# This file outputs simples descriptive statistics of groups of
# dockings with charge model, hydrogen presence in receptor and/or
# hydrogen presence in the ligand in common.

function usage () {
	printf "Usage: $1 [-c <MODEL>] [-n [0-9]] [-r] [-R] [-l] [-L] [-A]\n"
	printf "Options\n"
	printf "\t-c\tCharge model to be analyzed, can be one of:\n"
	printf "\t\teem2015ha\tElectronegativity Equilization Method (EEM)\n"
	printf "\t\t\t\tatomic partial charges. Cheminf HF/6-311G/AIM)\n"
	printf "\t\teem\t\tElectronegativity Equilization Method (EEM)\n"
	printf "\t\t\t\tatomic partial charges. Bultinck B3LYP/6-31G*/MPA)\n"
	printf "\t\tgasteiger\tGasteiger-Marsili sigma partial charges\n"
	printf "\t\tmmff94\t\tMMFF94 partial charges\n"
	printf "\t\tnone\t\tPartial charges allequal zero\n"
	printf "\t\tqeq\t\tQEq (charge equilibration) partial charges\n"
	printf "\t\tqtpie\t\tQTPIE (charge transfer, polarization and\n"
	printf "\t\t\t\tequilibration) partial charges\n\n"
	printf "\t-r\tEvaluate only results using receptor without hydrogens\n\n"
	printf "\t-R\tEvaluate only results using receptor with hydrogens\n\n"
	printf "\t-l\tEvaluate only results using ligand without hydrogens\n"
	printf "\t-L\tEvaluate only results using ligand with hydrogens\n"
	printf "\t-n\tNumber of conformations considered, from best to worst\n"
	printf "\t-A\tCheck affinities instead of RMSDs\n"
	exit 127
}

lflag="all"
rflag="all"
nflag=9

chamo="*"
dataset="results"

while getopts :AlrLRn:c: name
do
	case $name in
		A)
			dataset="affinities";;
		L)
			lflag="only hydrogens";;
		R)
			rflag="only hydrogens";;
		l)
			lflag="no hydrogens";;
		r)
			rflag="no hydrogens";;
		n)
			nflag="$OPTARG";;
		c)
			chamo="$OPTARG";;
		*)
			usage $0;;
	esac
done

testing_root_dir="$(git rev-parse --show-toplevel)/files_for_charge_comparison/"
testing_dirs=$(ls $testing_root_dir)

all_results=""

for system in $testing_dirs;
do
	cd "$testing_root_dir/$system"

	results=$(cat *.$dataset | grep -v convergence | grep -E "_[1-$nflag]")
	if [ "$lflag" == "only hydrogens" ];
	then
		results=$(echo "$results" | grep -v ligand_nohydrogen)
	elif [ "$lflag" == "no hydrogens" ];
	then
		results=$(echo "$results" | grep ligand_nohydrogen)
	fi
	if [ "$rflag" == "only hydrogens" ];
	then
		results=$(echo "$results" | grep -v nohydrogen_ligand)
	elif [ "$rflag" == "no hydrogens" ];
	then
		results=$(echo "$results" | grep nohydrogen_ligand)
	fi
	results=$(echo "$results" | grep _"$chamo"_ )
	all_results="${all_results}
${results}"
done

echo "$all_results" | grep -v '^$' | cut -d ' ' -f 2 | \
	datamash count 1 mean 1 sstdev 1 min 1 max 1 -t ' ' --format="%.6f"


