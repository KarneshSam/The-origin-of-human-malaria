# BUSCO
# Loop over all .faa files

for faa in ../results/02_CDS/*.faa; do
    # Extract base name (e.g., Pb.faa → Pb)
    base=$(basename "$faa" .faa)

    # Run BUSCO
    busco -i "$faa" -o "../results/05_Busco/$base" -m prot -l apicomplexa --download_path ../resources/busco_downloads
done

# -i: input protein file
# -o: output directory
# -m: protein mode
# -l: lineage dataset
# --download_path: directory where BUSCO stores/downloads lineage datasets

