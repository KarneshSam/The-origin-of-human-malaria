# filter the bird genome from the parasite using gc content and remove the contig with sequence length less than 3000
# removeScaffolds.py is used to filter it.
python removeScaffolds.py ../resources/genome/Haemoproteus_tartakovskyi.raw.genome 25 ../resources/genome/Haemoproteus_tartakovskyi.filter.genome 3000

# Gene prediction - Genemark
# using the Haemoproteus tartakovskyi genome

nohup gmes_petap.pl --cores 20 --min_contig 10000 --ES --sequence ../resources/genome/Haemoproteus_tartakovskyi.filter.genome \
    > ..results/01_gene_pred/gmes_petap.Ht.log 2>&1 &
PID=$!
wait $PID
echo "gmes_petap.pl run completed!" | tee -a ..results/01_gene_pred/gmes_petap.Ht.log

# --cores: CPU cores to use
# --min_contig: minimum contig length used for training
# --ES: Self-training gene prediction
# PID: Process id (assigned to each running program in Linux)
# tee: writes the output to both file and the terminal (-a append to the file)

# move the default genemark.gtf to a defined file name
mv genemark.gtf ..results/01_gene_pred/Ht.gtf
