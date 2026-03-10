# clustalo for msa

for i in ../results/06_BuscoIdfa/*.fasta; do 
    file=$(basename $i .fasta);  
    clustalo -i $i -o ../results/07_clustal/${file}_align.fasta -v --threads 20; 
done

# -i: Input FASTA file
# -o: Output alignment file
# -v: Verbose mode
# --threads: CPU cores
