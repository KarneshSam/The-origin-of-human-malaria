# again run the gene prediction for the avian removed
nohup gmes_petap.pl --cores 50 --min_contig 10000 --ES --sequence ../resources/genome/Ht_clean.fasta \
> ../results/01_gene_pred/gmes_petap.Htclean.log 2>&1 &

PID=$!
wait $PID
echo "gmes_petap.pl run completed!" | tee -a ../results/01_gene_pred/gmes_petapHtclean.log

# --cores: CPU cores to use
# --min_contig: minimum contig length used for training
# --ES: Self-training gene prediction
# PID: Process id (assigned to each running program in Linux)
# tee: writes the output to both file and the terminal (-a append to the file)

# move the default genemark.gtf to a defined file name
mv genemark.gtf ..results/01_gene_pred/Ht_clean.gtf

# gff parsing
gffParse.pl -i ../resources/genome/Ht_clean.fasta \
-g ../results/01_gene_pred/Ht_clean.gtf \
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
