#!/usr/bin/env python3
"""
extractBuscoSeq.py (script's name)

Description:
      This program extracts orthologous BUSCO protein sequences from multiple species 
      using a BUSCO ID table and protein FASTA files. The BUSCO table contains the 
      BUSCO identifiers and corresponding gene IDs for each species. The script reads 
      the protein FASTA files, matches the gene IDs with the BUSCO table, and creates 
      individual FASTA files for each BUSCO ortholog group.

      The output FASTA files contain sequences from all species for a particular BUSCO 
      gene. These files can be used for downstream analysis such as multiple sequence 
      alignment, ortholog analysis, and phylogenetic tree construction.

      The program is designed specifically for handling BUSCO ortholog datasets where 
      a concatenated BUSCO ID table is provided and corresponding protein sequences 
      are available in FASTA format.

      If the output directory does not exist, the program will automatically create it.
Procedure:
      1. The program starts by defining the BUSCO ID table and the protein FASTA files 
         for each species.
      2. The output directory is created if it does not already exist.
      3. Protein FASTA files are loaded using Biopython and stored in dictionaries 
         for fast sequence retrieval.
      4. The BUSCO table is read using a tab-delimited parser.
      5. For each BUSCO ID, the script retrieves the corresponding gene IDs for all 
         species listed in the table.
      6. The corresponding sequences are extracted from the loaded FASTA dictionaries.
      7. A new FASTA file is created for each BUSCO ID containing sequences from all 
         available species.

Input:
      1. BUSCO ID table - a tab-delimited file containing BUSCO IDs and gene IDs for 
         multiple species (e.g., concatenated_ids.tsv).
      2. Protein FASTA files - protein sequence files (.faa) for each species.

Output:
      1. Multiple FASTA files - each file corresponds to a BUSCO ortholog group and 
         contains sequences from all species.

Usage: python extractBuscoSeq.py

Version: 1.00
Date: 2026-03-04
Name: Karnesh Sampath

"""

# csv used to access gene IDs for each species
# Biopython used to read fasta files and write output fasta files for each BUSCO gene
# The output files will be in the format "BUSCOID.fasta" and will contain the sequences for that BUSCO gene from all species where it is present.
import csv
from Bio import SeqIO
import os

# input files
table_file = "../results/05_Busco/ids/concatenated_ids.tsv"

# creates a dictionary of species names and their corresponding fasta file paths
fasta_files = {
    "Ht": "../results/02_CDS/Ht.faa",
    "Pb": "../results/02_CDS/Pb.faa",
    "Pc": "../results/02_CDS/Pc.faa",
    "Pf": "../results/02_CDS/Pf.faa",
    "Pk": "../results/02_CDS/Pk.faa",
    "Pv": "../results/02_CDS/Pv.faa",
    "Py": "../results/02_CDS/Py.faa",
    "Tg": "../results/02_CDS/Tg.faa"
}

# output directory
outdir = "../results/06_BuscoIdfa"
os.makedirs(outdir, exist_ok=True)

# load fasta sequences into dictionaries
seq_dict = {}
for sp, fasta in fasta_files.items():
    # SeqIO.to_dict creates a dictionary where the keys are the sequence IDs (gene IDs) 
    # and the values are SeqRecord objects containing the sequence data
    seq_dict[sp] = SeqIO.to_dict(SeqIO.parse(fasta, "fasta"))

#print("Loaded FASTA files")

# process BUSCO table
with open(table_file) as f:
    # csv.DictReader reads the TSV file and allows us to access each row as a dictionary
    # where the keys are the column headers (e.g., "BUSCOID", "Ht", "Pb", etc.) 
    # and the values are the corresponding entries for that row.
    reader = csv.DictReader(f, delimiter="\t")
    
    # iterate through each row in the BUSCO table
    for row in reader:
        busco = row["BUSCOID"]
        # for each BUSCO gene, we will create an output FASTA file named after the BUSCO ID (e.g., "BUSCOID.fasta")
        outfile = os.path.join(outdir, f"{busco}.fasta")
        
        # open the output file for writing and iterate through each species in our fasta_files dictionary
        with open(outfile, "w") as out:
            for sp in fasta_files.keys():
                gene = row[sp]
                # check if the gene ID for this species is present in the sequence dictionary 
                # for that species
                if gene in seq_dict[sp]:
                    # if the gene ID is found, we retrieve the corresponding sequence (SeqRecord object)
                    seq = seq_dict[sp][gene]
                    out.write(f">{sp}\n{seq.seq}\n")

print("Finished extracting BUSCO sequences")
