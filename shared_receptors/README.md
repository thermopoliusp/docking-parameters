An Analysis of Induced-fit Effects through docking simulations of similar receptors
===================================================================================

In this directory, is stored (besides this file) the file `groups.txt`. To
proceed with the analysis, it is required to initially copy all relevant
`.pdbqt` files, from directory `../files_for_charge_comparison/`. A script
was written to automate the process:

```
$ ../bin/create_env_for_shared_receptors.sh
```

Then, all docking simulations must be executed, process that, also automated,
takes a couple of hours.

```
$ ../bin/check_all_shared.sh
```

Finally, the results can be analyzed, yielding the differences between the
affinities calculated docking a ligand to a different receptor and the
affinities calculated docking the same ligand to the corresponding receptor.
This analysis can be executed through the script below.

```
$ ../bin/get_diffs_in_score_shared.sh
```

