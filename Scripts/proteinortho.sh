# remove the * from the faa file
sed -i -E '/^>/! s/[^XOUBZACDEFGHIKLMNPQRSTVWYxoubzacdefghiklmnpqrstvwy]//g; /^$/d' ../results/02_CDS/*.faa

# proteinortho6
# used for ortholog prediction
nohup proteinortho6.pl ../results/02_CDS/{Ht,Pb,Pc,Pf,Pk,Pv,Py,Tg}.faa > ../results/04_proteinortho/proteinortho6.log 2>&1 &

PID=$!
wait $PID
echo "proteinortho6.pl run completed!" | tee -a ../results/04_proteinortho/proteinortho6.log

# move the output to a desired path
mv myproject.* ../results/04_proteinortho/


