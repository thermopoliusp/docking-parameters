#! /usr/bin/env python3

# This script reads two molecules and outputs the RMSD

import __main__
__main__.pymol_argv = [ 'pymol', '-qc']

import pymol
import sys, os

def usage (string):
    print ("Usage: " + string + "path/to_the/first_mol path/to_the/sec_mol")

def main ():

    if ( len(sys.argv) != 3 ):
        usage (sys.argv[0])
        exit (127)

    pymol.finish_launching()

    inpath_orig = os.path.abspath(sys.argv[1])
    inpath_new = os.path.abspath(sys.argv[2])
    inname_orig = inpath_orig.split('/')[-1].split('.')[0]
    inname_new = inpath_new.split('/')[-1].split('.')[0]

    pymol.cmd.load(inpath_orig, inname_orig)
    pymol.cmd.load(inpath_new, inname_new)
    a = pymol.cmd.align(inname_orig, inname_new, cycles=0, transform=0)

    print(a[3])

    pymol.cmd.quit()


if __name__=="__main__":
    main()

