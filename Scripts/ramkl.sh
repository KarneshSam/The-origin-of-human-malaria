# for ramkl - Phylogeny tree
for i in ../results/07_clustal/*.fasta; do 
    file=$(basename $i _align.fasta); 
    mkdir -p ../results/08_ramkl/${file}; 
    raxmlHPC-PTHREADS -T 30 -s $i -n ${file}.tre -w ../results/08_ramkl/${file} -o Tg -m PROTGAMMABLOSUM62 -p 12345; 
done

# -T: CPU threads
# -s: Input alignment file
# -n: Output tree filename (basename)
# -w: Working/output directory where RAxML will write results
# -o: Sets the outgroup for rooting the tree
# -m: Protein substitution model
# -p: Random seed for reproducibility of the tree

