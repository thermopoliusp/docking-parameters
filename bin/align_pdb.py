#! /usr/bin/env python3

# This script reads two molecules and aligns the first to the second.

import __main__
__main__.pymol_argv = [ 'pymol', '-qc']

import pymol
import sys, os

def usage (string):
    print ("Usage: " + string + "path/to_the/first_mol path/to_the/sec_mol new_file")

def main ():

    if ( len(sys.argv) != 4 ):
        usage (sys.argv[0])
        exit (127)

    pymol.finish_launching()

    inpath_mobile = os.path.abspath(sys.argv[1])
    inpath_target = os.path.abspath(sys.argv[2])
    outpath = os.path.abspath(sys.argv[3])
    inname_mobile = inpath_mobile.split('/')[-1].split('.')[0]
    inname_target = inpath_target.split('/')[-1].split('.')[0]

    pymol.cmd.load(inpath_mobile, inname_mobile)
    pymol.cmd.load(inpath_target, inname_target)
    a = pymol.cmd.align(inname_mobile, inname_target)

    print(a[3])

    pymol.cmd.save(outpath, inname_mobile)

    pymol.cmd.quit()


if __name__=="__main__":
    main()

