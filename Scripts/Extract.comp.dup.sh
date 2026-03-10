# for extracting complete
# one duplicate Busco Id

for sp in Ht Pb Pc Pf Pk Pv Py Tg
do
    cd ../results/03_Busco/$sp/run_apicomplexa_odb10/

    awk '!/^#/ {
      # Only consider Complete or Duplicated
      if ($2=="Complete") {
       # creates an array
        best[$1]=$0      # Prefer Complete; $1: BUSCO id
      }
      else if ($2=="Duplicated" && !($1 in best)) {
        best[$1]=$0      # Keep first duplicated only by checking !($1 in best)
      }
    }
    END {
        for (id in best) print best[id]
    }
    ' full_table.tsv > one_to_one.tsv

    # extract the geneid and busco id
    awk '{print $1, "\t"$3}' one_to_one.tsv > one_to_one_id.tsv

    # move the extracted file to a desired path for further analysis
    mv one_to_one_id.tsv ../../ids/${sp}_one_to_one_id.tsv

    cd - > /dev/null
done

