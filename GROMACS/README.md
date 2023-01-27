Receptors chosen for Molecular Dynamics simulations
===================================================

Among the 90 receptor-ligand complexes analyzed, fifteen have been chosen,
giving preference to the ones with smallest number of atoms in the receptor.
They are:

1. HIV-1 Protease complexed with a tripeptide inhibitor,
   code 1A30 in the _Protein Data Bank_. Force field cited in previous work:
   CHARMM36; water model: TIP3P [[1]](#1).

2. Grb2 SH2 domain complexed with phospho peptide,
   code 1JYQ. Force field cited in previous work: CHARMM27;
   water model: TIP3P [[2]](#2).

3. Bovine Pancreatic Ribonuclease A in complex with 3'-phosphotimidine
   (3'-5')-pirophosphate adenosine 3'-phosphato, code 1U1B. Force field:
   CHARMM27; water model: TIP3P [[3]](#3).

4. Ribonuclease A in complex with nonnatural 3'-nucleotides, code 1W4O. Force
   field: CHARMM27; water model: TIP3P [[3]](#3).

5. Human Hsp90-α complexed with dihydroxyphenylpyrazoles, code  1YC1. Force
   field: GROMOS96 53A6; water model: SPC [[6]](#6).

6. Hsp90 complexed with radicicol analogue, code 2IWX. Force
   field: GROMOS96 53A6; water model: SPC [[6]](#6).

7. Yeast Hsp90 complexed with the inhibitor 7-O-carbamoylpremacbecin,
   code 2VW5. Force field: GROMOS96 53A6; water model: SPC [[6]](#6).

8. Hsp90, E88G-N92L mutant, complexed with geldanamycin,
   code 2YGE. Force field: GROMOS96 53A6; water model: SPC [[6]](#6).

9. Tricyclic series of Hsp90 inhibitors,
   code 2YKI. Force field: GROMOS96 53A6; water model: SPC [[6]](#6).

10. HIV-1 Protease, I50V mutant, complexed with inhibitor saquinavira.
   code 3CYX. Force field: CHARMM36; water model: TIP3P [[1]](#1)

11. Ribonuclease A in complex with uridine 5'-phosphate, code 3DXG.
   Force field: CHARMM27; water model: TIP3P [[3]](#3).

12. Bovine β-lactoglobuline in complex with capric acid, code 3NQ3.
   Force field: AMBER99SB; water model: TIP3P [[7](#7),[4](#4),[5](#5)].

13. Grb2 SH2 domain in complex with tripeptide, code 3OV1. Force
   field: CHARMM27; water model: TIP3P [[2]](#2).

14. Grb2 SH2 domain in complex with tripeptide, code 3S8O. Force
   field: CHARMM27; water model: TIP3P [[2]](#2).

15. HIV-1 Protease in complex with MKP97, code 4DJR. Force field:
   CHARMM36; water model: TIP3P [[1]](#1).

These receptors where simulated in GROMACS 2021.4, according to the
commands listed in the scripts `<complex>_gromacs.sh`, stored in each
subdirectory of this directory.

We utilized as a template some `.mdp` files written by J. Lemkul [[8]](#8),
with a few modifications, _e.g._ for the use of the force field CHARMM36,
as described in the documentation of the program [[9]](#9).

Finally, there is a force field (`gromos53a6_hsd.ff`) in this directory.
It was created from the force field GROMOS96 53A6, distributed with
GROMACS itself, with a small modification: instead of neutral histidine,
protonated in D1, being symbolized by the abbreviation "HISA", it is by "HSD",
to assure compatibility with the files sourced from CHARMM-GUI [[10]](#10).


References
----------

<a id="1">[1]</a>
Perilla, J. R., & Schulten, K. (2017). Physical properties of the
HIV-1 capsid from all-atom molecular dynamics simulations.
_Nature communications_, 8(1), 1-10.

<a id="2">[2]</a>
Sanches, K., Dias, R. V. R., da Silva, P. H., Fossey, M. A., Caruso, Í. P.,
de Souza, F. P., ... & de Melo, F. A. (2019). Grb2 dimer interacts with
Coumarin through SH2 domains: A combined experimental and molecular
modeling study. _Heliyon_, 5(11), e02869.

<a id="3">[3]</a>
Formoso, E., Matxain, J. M., Lopez, X., & York, D. M. (2010). Molecular
Dynamics Simulation of Bovine Pancreatic Ribonuclease A− CpA and Transition
State-like Complexes. _The Journal of Physical Chemistry B_, 114(21), 7371-7382.

<a id="4">[4]</a>
J. A. Maier; C. Martinez; K. Kasavajhala; L. Wickstrom; K. E. Hauser; C.
Simmerling. ff14SB: Improving the Accuracy of Protein Side Chain and Backbone
Parameters from ff99SB. _J. Chem. Theory Comput._, 2015, 11, 3696–3713.

<a id="5">[5]</a>
V. Hornak; R. Abel; A. Okur; B. Strockbine; A. Roitberg; C. Simmerling.
Comparison of multiple Amber force fields and development of improved
protein backbone parameters. _Proteins_, 2006, 65, 712–725.

<a id="6">[6]</a>
Vettoretti, G., Moroni, E., Sattin, S., Tao, J., Agard, D. A., Bernardi, A., &
Colombo, G. (2016). Molecular dynamics simulations reveal the mechanisms of
allosteric activation of Hsp90 by designed ligands. _Scientific reports_,
6(1), 1-13.

<a id="7">[7]</a>
Zhan, F., Ding, S., Xie, W., Zhu, X., Hu, J., Gao, J., ... & Chen, Y. (2020).
Towards understanding the interaction of β-lactoglobulin with capsaicin:
Multi-spectroscopic, thermodynamic, molecular docking and molecular dynamics
simulation approaches. _Food Hydrocolloids_, 105, 105767.

<a id="8">[8]</a>
J.A. Lemkul (2018). From Proteins to Perturbed Hamiltonians: A Suite of
Tutorials for the GROMACS-2018 Molecular Simulation Package, v1.0. _Living
J. Comp. Mol. Sci._ 1 (1): 5068.

<a id="9">[9]</a>
Berendsen, H. J., van der Spoel, D., & van Drunen, R. (1995). GROMACS: A
message-passing parallel molecular dynamics implementation. _Computer physics
communications_, 91(1-3), 43-56.

<a id="10">[10]</a>
Oostenbrink, C., Villa, A., Mark, A. E., & Van Gunsteren, W. F. (2004).
A biomolecular force field based on the free enthalpy of hydration and
solvation: the GROMOS force‐field parameter sets 53A5 and 53A6. _Journal
of computational chemistry_, 25(13), 1656-1676.

