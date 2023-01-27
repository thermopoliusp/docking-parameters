#! /usr/bin/bash

root_dir="$(git rev-parse --show-toplevel)"

selector () {
	CODE=$1
	SIZE=$2
	EXHA=$3
	CONF=$4

	if [ -d $root_dir/box_size/$CODE/ ]
	then
		cat $root_dir/box_size/$CODE/RMSDs.csv | \
			grep -v "Matrix" | \
			grep "^$SIZE,$EXHA,$CONF," | \
			cut -d ',' -f 4
	else
		echo "Complex $CODE not found"
	fi
}

for dir in $(ls $root_dir/box_size/)
do
	for size in {4,16}
	do
		selector $dir $size 8 1 | tr '\n' '%'
	done | sed 's/%$/\n/g' | grep "^[01]" | grep "%[2-9]"
done | wc

