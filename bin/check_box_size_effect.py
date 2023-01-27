#! /usr/bin/env python3

from scipy import stats
import os
import pandas as pd

def ttest_lists (list1, list2):
    ttest=stats.ttest_ind (list1, list2, equal_var=True)
    return ttest.pvalue

def start ():
    rootdir = os.popen("git rev-parse --show-toplevel").read()
    os.chdir(rootdir[:-1] + "/box_size")
    complexes = os.popen("ls").read().split(sep="\n")[:-1]
    return complexes

def get_matrix_characteristic (PDBID, characteristic, value):
    complex_matrix = pd.read_csv (PDBID + "/RMSDs.csv")
    return complex_matrix[complex_matrix[characteristic] == value]

def get_old_matrix_characteristic (complex_matrix, characteristic, value):
    return complex_matrix[complex_matrix[characteristic] == value]

def get_exha_effect ():
    list_of_complexes = start ()
    list1 = []
    list2 = []
    list4 = []
    corr32 = 0
    corr16 = 0
    corr8 = 0
    for PDBID in list_of_complexes:
        try:
            conf1_matrix = get_matrix_characteristic (PDBID, "conformation", 1)
            exha8_matrix = get_old_matrix_characteristic (conf1_matrix,
                            "size", 16)
            size1_matrix = float (get_old_matrix_characteristic (exha8_matrix,
                            "exhaustiveness", 32)["RMSD"])
            size2_matrix = float (get_old_matrix_characteristic (exha8_matrix,
                            "exhaustiveness", 16)["RMSD"])
            size4_matrix = float (get_old_matrix_characteristic (exha8_matrix,
                            "exhaustiveness", 8)["RMSD"])
            if (size1_matrix <= 2.0):
                list1.append (1)
                list2.append (size2_matrix/size1_matrix)
                list4.append (size4_matrix/size1_matrix)
                corr32 += 1
                if (size2_matrix <= 2.0):
                    corr16 += 1
                if (size4_matrix <= 2.0):
                    corr8 += 1
        except:
            pass
    pval12 = ttest_lists (list1, list2)
    pval14 = ttest_lists (list1, list4)
    print ("Succeeded (exhaustiveness=32): " + str(corr32))
    print ("Succeeded (exhaustiveness=16): " + str(corr16))
    print ("Succeeded (exhaustiveness=8): " + str(corr8))
    if (pval12 <= 0.025) or (pval14 <= 0.025):
        print("Exhaustiveness has statistically significant effects")
    else:
        print("Exhaustiveness has no statistically significant effects")
    print ("( p =", pval12, ", ", pval14, ")")

def get_size_effect ():
    list_of_complexes = start ()
    list1 = []
    list2 = []
    list4 = []
    corr4 = 0
    corr8 = 0
    corr16 = 0
    for PDBID in list_of_complexes:
        try:
            conf1_matrix = get_matrix_characteristic (PDBID, "conformation", 1)
            exha8_matrix = get_old_matrix_characteristic (conf1_matrix,
                            "exhaustiveness", 8)
            size1_matrix = float (get_old_matrix_characteristic (exha8_matrix,
                            "size", 4)["RMSD"])
            size2_matrix = float (get_old_matrix_characteristic (exha8_matrix,
                            "size", 8)["RMSD"])
            size4_matrix = float (get_old_matrix_characteristic (exha8_matrix,
                            "size", 16)["RMSD"])
            if (size1_matrix <= 2.0):
                list1.append (1)
                list2.append (size2_matrix/size1_matrix)
                list4.append (size4_matrix/size1_matrix)
                corr4 += 1
                if (size2_matrix <= 2.0):
                    corr8 += 1
                if (size4_matrix <= 2.0):
                    corr16 += 1
        except:
            pass
    pval12 = ttest_lists (list1, list2)
    pval14 = ttest_lists (list1, list4)
    print ("Succeeded (normal size): " + str(corr4))
    print ("Succeeded (twice the normal size): " + str(corr8))
    print ("Succeeded (four times the normal size): " + str(corr16))
    if (pval12 <= 0.025) or (pval14 <= 0.025):
        print("Size has statistically significant effects")
    else:
        print("Size has no statistically significant effects")
    print ("( p =", pval12, ", ", pval14, ")")


def main ():
    get_exha_effect ()
    get_size_effect ()

main()

