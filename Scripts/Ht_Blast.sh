# using blastx
# the blast was performed on Swissprot database

blastx -query ../results/02_CDS/Ht.fna \
-db SwissProt \
-evalue 1e-10 \
-out ../results/03_Blast/ht.blastx \
-num_descriptions 10 \
-num_alignments 5 \
-num_threads 20

# -query: Input sequence file (FASTA)
# -db: Protein database
# -out: Output file
# -evalue: Expectation value threshold that filters weak matches
# -num_description: Number of database sequences to show in the description section
# -num_alignment: Number of sequence alignments to display for each query
# -num_threads: Number of CPU threads
