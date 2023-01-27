#! /usr/bin/env python3

# This script reads two molecules and outputs an image comparing them.
# Should receive three arguments: the path to the first molecule, that
# shall be painted violet ("dirtyviolet", in PyMOL terminology), and is
# usually either the receptor or the original ligand position, the path
# to the second molecule, that shall be colored light blue, and the path
# to the new image. If more than three arguments are given, the first
# molecule will be painted as the second, but with a different carbon color.

import __main__
__main__.pymol_argv = [ 'pymol', '-qc']

import pymol
import sys, os

def usage (string):
    print ("Usage: " + string + "path/to_the/first_mol path/to_the/sec_mol path/to_image")

def main ():

    if ( len(sys.argv) < 4 ):
        usage (sys.argv[0])
        exit (127)

    pymol.finish_launching()

    inpath_recep = os.path.abspath(sys.argv[1])
    inpath_ligan = os.path.abspath(sys.argv[2])
    outpath = os.path.abspath(sys.argv[3])
    inname_recep = inpath_recep.split('/')[-1].split('.')[0]
    inname_ligan = inpath_ligan.split('/')[-1].split('.')[0]

    pymol.cmd.load(inpath_recep, inname_recep)
    pymol.cmd.load(inpath_ligan, inname_ligan)
    pymol.cmd.disable("all")
    pymol.cmd.enable(inname_recep)
    pymol.cmd.enable(inname_ligan)
    if ( len(sys.argv) > 4 ):
        pymol.cmd.util.cbas(inname_recep)
    else:
        pymol.cmd.color("dirtyviolet", inname_recep)
    pymol.cmd.util.cbab(inname_ligan)
    pymol.cmd.orient()
    pymol.cmd.ray(2000,2000)
    pymol.cmd.png(outpath)

    pymol.cmd.quit()


if __name__=="__main__":
    main()

