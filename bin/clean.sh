#! /bin/bash

# This script removes all generated files (the outputs from OpenBabel and Vina)

root_dir="$(git rev-parse --show-toplevel)"

rm -rf "${root_dir}/files_for_docking"

cp -r "${root_dir}/original_files" "${root_dir}/files_for_docking"

