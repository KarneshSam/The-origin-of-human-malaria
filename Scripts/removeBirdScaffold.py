#!/usr/bin/env python

""" Script to create a new fasta file, excluding bird scaffolds based on input file including scaffolds to remove
run like: python removeBirdScaffold.py input.fasta scaffolds_to_remove.txt output.fasta """

import sys

scaffolds = set()

genomefile = sys.argv[1]
birdfile = sys.argv[2]
outfile = sys.argv[3]

with open(birdfile, "r") as B1:
    for line in B1:
        line = line.rstrip()
        scaffolds.add(line)

with open(genomefile,'r') as I1, open(outfile, 'w') as O1:
    for line in I1:
        if line.startswith(">"):
            IDline = line
            scaffold = line.split()[0][1:]
        else:
            seq = line
            if scaffold not in scaffolds:
                O1.write(IDline + seq)
