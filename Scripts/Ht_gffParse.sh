# gffParse.pl is used to extract the fasta sequence of both nucleotide and amino acid sequence

gffParse.pl -i ../resources/genome/Haemoproteus_tartakovskyi.filter.genome \
-g ../results/01_gene_pred/Ht.gtf \
-f CDS \
-b ../results/02_CDS/Ht \
-p -c -a gene_id

# -i: genome FASTA
# -g: GFF/GTF annotation
# -f: feature to extract (CDS)
# -b: output file prefix
# -p: generate protein sequence
# -c: overcome the internal stop codons
# -a: attribute used for FASTA IDs
