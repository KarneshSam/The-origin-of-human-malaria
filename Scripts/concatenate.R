# load each file and merge them based on the first column (BUSCOID)
data_1 = read.table(file = "../results/05_Busco/ids/Ht_one_to_one_id.tsv", header = F)
data_2 = read.table(file = "../results/05_Busco/ids/Pb_one_to_one_id.tsv", header = F)
merged_data = merge(data_1, data_2, by="V1")

data_3 = read.table(file = "../results/05_Busco/ids/Pc_one_to_one_id.tsv", header = F)
data_4 = read.table(file = "../results/05_Busco/ids/Pf_one_to_one_id.tsv", header = F)
merged_data_1 = merge(data_3, data_4, by="V1")

data_5 = read.table(file = "../results/05_Busco/ids/Pk_one_to_one_id.tsv", header = F)
data_6 = read.table(file = "../results/05_Busco/ids/Pv_one_to_one_id.tsv", header = F)
merged_data_2 = merge(data_5, data_6, by="V1")

data_7 = read.table(file = "../results/05_Busco/ids/Py_one_to_one_id.tsv", header = F)
data_8 = read.table(file = "../results/05_Busco/ids/Tg_one_to_one_id.tsv", header = F)
merged_data_3 = merge(data_7, data_8, by="V1")

merged_data_4 = merge(merged_data, merged_data_1, by="V1")
merged_data_5 = merge(merged_data_2, merged_data_3, by="V1")
merged_data_6 = merge(merged_data_4, merged_data_5, by="V1")

# add column names
c1 = c("BUSCOID", "Ht", "Pb", "Pc", "Pf", "Pk", "Pv", "Py", "Tg")
colnames(merged_data_6) = c1

# write the merged data to a new file
write.table(merged_data_6, file = "../results/05_Busco/ids/concatenated_ids.tsv", row.names = F, sep="\t", quote = F)
