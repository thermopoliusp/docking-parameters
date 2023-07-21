Programs and Files Utilized in the Article "Effects of Preprocessing and Simulation Parameters on the Performance of Molecular Docking Studies"
===============================================================================================================================================

Article Information
-------------------

This article has been published in the Journal of Molecular Modeling and it can be
accessed through [this link](https://rdcu.be/dgWlw). Full citation:

CALLIL-SOARES, P. H.; BIASI, L. C. K.; PESSOA FILHO, P. de A. Effect of
preprocessing and simulation parameters on the performance of molecular docking
studies. Journal of Molecular Modeling, v. 29, n. 8, p. 251, 2023.
[![DOI:10.1007/s00894-023-05637-x](https://img.shields.io/badge/DOI-10.1007/s00894--023--05637--x-F39001.svg)](https://doi.org/10.1007/s00894-023-05637-x)

About this repository
---------------------

In this repository are kept the files (`.pdb`, `.sdf`, among
others) [[1]](#1), [[2]](#2) that store the molecules analyzed in this work.

Besides, we have some scripts to automate the conversion of the files supplied
to a file format convenient for use with _AutoDock-GPU_ [[3]](#3) and _AutoDock
Vina_ [[4]](#4), through the software package _OpenBabel_ [[5]](#5), and also
toautomate the docking simulations of a large number of receptor-ligand
complexes.

Finally, we have files associated with the Molecular Dynamics simulations:
`.top` and `.prm` files, in the specific situations that demanded the use of a
web server, `.mdp` files with the simulation parameters and _scripts_ to
automate the molecular dynamics simulations, using _GROMACS_ [[6]](#6).

Dependencies and Executions Instructions
----------------------------------------

To execute the scripts, one will need
[PyMOL](https://pymol.org/2/),
[GROMACS](https://www.gromacs.org/),
[OpenBabel](https://openbabel.org/wiki/Main_Page),
[Autodock Vina](https://vina.scripps.edu/),
[Autodock GPU](https://github.com/ccsb-scripps/AutoDock-GPU) and
[GNU Datamash](https://www.gnu.org/software/datamash/).
Besides, the _scripts_ demand an Unix (or Unix-like) environment, since they
employ standard utilities as `sed(1)`, `awk(1p)`, `tail(1)`, and the proc
filesystem. Finally, since the scripts are written in Bash or Python, both
languages are also necessary.

One might need to modify the scripts to account for the peculiarities of each
system (as available memory, number of threads, _etc._).

To obtain all data and code necessary, one must initially clone this repository:

```
$ git clone https://github.com/pedro-callil/molecular-docking-parameter-effect
$ cd molecular-docking-parameter-effect
```

To evaluate the effects of the addition of charges and hydrogen atoms:

```
$ ./bin/add_charges_and_hydrogen.sh
$ ./bin/add_charges_ligand_no_hydrogens.sh

$ ./bin/create_dir_for_charge_comparison.sh

$ ./bin/dock_in_bulk.sh
$ ./bin/dock_in_bulk_nohydrogen.sh

$ ./bin/get_all_affinities.sh
$ ./bin/get_all_RMSDs.sh
```

The results will be available in the files `*.results` (RMSDs) and `*.affinities`
of each subdirectory of the directory `./files_for_charge_comparison/`.

One might be interested in checking the effects of the addition of missing
residues and disulfide bonds through the CHARMM-GUI web server:

```
$ ./bin/add_charges_and_hydrogen_for_rcsb_default.sh
$ ./bin/add_charges_and_hydrogen_for_rcsb_disulfide.sh
$ ./bin/add_charges_and_hydrogen_for_rcsb_nocorrection.sh

$ ./bin/create_dir_for_rcsb_files_charge_comparison.sh

$ ./bin/dock_in_bulk_rcsb.sh

$ ./bin/get_all_affinities_charmm.sh
$ ./bin/get_all_RMSDs_charmm.sh
```

The results will be available in the files `*.results` (RMSDs) and `*.affinities`
of each subdirectory of the directory `./files_from_rcsb/files_for_charge_comparison/`.

For isolated receptor molecular dynamics simulations, one shall execute inside
each subdirectory, identified with a PDB code, of the directory `./GROMACS/`, the
executable Bash script kept inside:

```
$ cd GROMACS
$ cd 1a30
$ ./1a30_gromacs.sh
```

It is important to observe that the force field
[CHARMM36](https://mackerell.umaryland.edu/charmm_ff.shtml#gromacs) is not
available in this repository, and must be obtained from the linked website.
Not all molecules demand this force field, however. More information (such as
regarding the simulation with receptor and ligand) can be found inside the
directories `./GROMACS/` and `./GROMACS_LIGAND/`.

Autorship
---------------------

Pedro Henrique Callil-Soares <pedrocallil@usp.br>

Lilian Caroline Kramer Biasi <lckbiasi@usp.br>

Pedro de Alcântara Pessoa Filho <pedropessoa@usp.br>

References
-----------

<a id="1">[1]</a>
SU, M. et al. Comparative assessment of scoring functions: the casf-2016 update. Journal
of chemical information and modeling, ACS Publications, v. 59, n. 2, p. 895–913, 2018.
[![DOI:10.1021/acs.jcim.8b00545](https://img.shields.io/badge/DOI-10.1021/acs.jcim.8b00545-3D464D.svg)](https://doi.org/10.1021/acs.jcim.8b00545)

<a id="2">[2]</a>
S. Jo, T. Kim, V.G. Iyer, and W. Im (2008). CHARMM-GUI: A Web-based Graphical User
Interface for CHARMM. J. Comput. Chem. 29:1859-1865
[![DOI:10.1002/jcc.20945](https://img.shields.io/badge/DOI-10.1002/jcc.20945-005274.svg)](https://doi.org/10.1002/jcc.20945)

<a id="3">[3]</a>
TROTT, O.; OLSON, A. J. Autodock vina: improving the speed and accuracy of docking
with a new scoring function, efficient optimization, and multithreading. Journal of
computational chemistry, Wiley Online Library, v. 31, n. 2, p. 455–461, 2010.
[![DOI:10.1002/jcc.21334](https://img.shields.io/badge/DOI-10.1002/jcc.21334-005274.svg)](https://doi.org/10.1002/jcc.21334)

<a id="4">[4]</a>
SANTOS-MARTINS, D. et al.  Accelerating AutoDock4 with GPUs and gradient-based local
search. Journal of chemical theory and computation 17(2), 1060–1073 (2021)
[![DOI:10.1021/acs.jctc.0c01006](https://img.shields.io/badge/DOI-10.1021/acs.jctc.0c01006-0F7647.svg)](https://doi.org/10.1021/acs.jctc.0c01006)

<a id="5">[5]</a>
O’BOYLE, N. M. et al. Open babel: An open chemical toolbox. Journal of cheminformatics,
BioMed Central, v. 3, n. 1, p. 1–14, 2011.
[![DOI:10.1186/1758-2946-3-33](https://img.shields.io/badge/DOI-10.1186/1758--2946--3--33-037CA2.svg)](https://doi.org/10.1186/1758-2946-3-33)

<a id="6">[6]</a>
BERENDSEN, H. J.; SPOEL, D. van der; DRUNEN, R. van. Gromacs: a message-passing
parallel molecular dynamics implementation. Computer physics communications, Elsevier,
v. 91, n. 1-3, p. 43–56, 1995.
[![DOI:10.1016/0010-4655(95)00042-E](https://img.shields.io/badge/DOI-10.1016/0010--4655(95)00042--E-227BC0.svg)](https://doi.org/10.1016/0010-4655(95)00042-E)

