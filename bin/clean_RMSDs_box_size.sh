#! /usr/bin/bash

root_dir="$(git rev-parse --show-toplevel)"

cd $root_dir
cd box_size
for dir in $(ls)
do
	cd $dir
	cat RMSDs.csv | grep -v Matrix > RMSDs.csv.clean
	mv RMSDs.csv.clean RMSDs.csv
	cd ..
done

