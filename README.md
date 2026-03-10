# **Case Study: The origin of human malaria**
## **Background:**
Malaria is caused by parasites belonging to the phylum *Apicomplexa*. One of
the more well known genera causing malaria is Plasmodium. The species of this
genus infect not only humans, but also other mammals, birds and "reptiles". The
single one species that causes most malaria infections in humans is *Plasmodium falciparum*. This is also the most serious of malaria infections. Many genomes
of Plasmodium have been sequenced. Recently the first genome of an avian
(bird) malaria parasite has been sequenced. The species’ name is *Haemoproteus tartakovskyi*. There is a controversy among researches whether *Plasmodium falciparum* is related to the other mammalian parasites, or if it originates from a bird malaria
parasite which has changed its host. We may solve this by making an extensive
phylogenetic analysis. 

## **Data Description:**
### *Input Data:*
The genomes used in the study are

* *Plasmodium berghei* - Host (Rodent)
* *Plasmodium cynomolgi* - Host (macaques)
* *Plasmodium falciparum* - Host (Humans)
* *Plasmodium knowlesi* - Host (Lemures)
* *Plasmodium vivax* - Host (Humans)
* *Plasmodium yoelii* - Host (Rodents)
* *Haemoproteus tartakovskyi* - Host (Birds)
* *Toxoplasma gondii* - Host (Humans)

The database used in the study are

* NCBI Taxonomy Database: ftp://ftp.ebi.ac.uk/pub/databases/taxonomy/taxonomy.dat
* SwissProt Database: ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.dat.gz 

**Note:** 

* *Haemoproteus tartakovskyi* contains both the parasite and host genome content in the sequence.
* The *Toxoplasma gondii* is used as outgroup for the phylogenetic study.
* Download the database using ```wget``` in bash

## **Workflow:**
The pipeline consist of the following major steps:

*Preprocessing of *Haemoproteus tartakovskyi* genome:*
* The *Haemoproteus tartakovskyi's* host (bird) genomic content was initially removed from the genome using GC content <25% [(Bensch et al., 2016)](https://pmc.ncbi.nlm.nih.gov/articles/PMC4898798/).

* The genes were predicted for the genome through Genemark.

* Eventhough the genome is filtered by GC content still the bird genomic content is present in the genes, which was removed by performing BLASTX.

* Once the host genomic content were removed, the Genemark was performed omce again on the cleaned *Haemoproteus tartakovskyi* genome.

*Ortolog Identification:*

* The genes were predicted for rest of the genome using Genemark.

* The .gtf file of each genome were parsed using gffParse.pl to extract both amino acid and nucleotide sequneces in FASTA format.

* *Proteinortho* and *BUSCO* were used to predict the ortologous genes.

*Multiple Sequence Alignment:*

* The BUSCO results of each genome were used to perform MSA.

* Only Complete BUSCO id and allow having Duplicated BUSCO ids as one.

* Create a FASTA file for each BUSCO id, which contains the gene sequences of gene id (genes comes under a BUSCO id) across the genome. So a BUSCO id FASTA file contains 8 sequences (each sequence for one genome).

* Clustalo was performed for each BUSCO id FASTA file for MSA.

*Phylogeny Analysis:*

* The Ramkl was used to identify the outtree for each BUSCO id.

* Concatenate each outtree and perform phylip to get a consense outtree of all BUSCO ids.

## **Required Software:**
This workflow mainly uses conda environments for reproducibility.

Main tools:

* Python (3.12.10)
* BLAST (2.17.0)
* Proteinortho (6.3.6)
* BUSCO (6.0.0)
* Clustalo (1.2.4)
* Ramkl (8.2.13)

All dependencies are managed through Conda environments.

## **Output File:**
Key output include:

* Genemark file for each genome.
* .faa and .fna for each genome (gffParse).
* BLASTX result.
* Proteinortho and BUSCO result.
* Clustalo (MSA) alignment file.
* outtree using Ramkl.
* Consense outtree.

## **People Involved:**
* **Name:** Karnesh Sampath, Dag Ahren (Professor), Mirjam Müller (Phd), Eleni Theofania Skorda (Phd)
* **Date:** 02.03.2025










