
####################################################################################################
# Prepares genome file to create SNP matrix for Ecoli and Shigella
# GCA_900174625.1_WI1-reUpload doesnt exist, or was not downloaded.
# GCA_000005845.2_ASM584v2 doesnt exist, or was not downloaded in Escherichia2017
####################################################################################################

ecoli:complete_Ecoli_genomes.txt dload_ecoli copy_ecoli

complete_Ecoli_genomes.txt:../Eschericia2017/Escherichia_assembly_summary_genbank.txt
	@echo "Subsetting lines corresponding to complete Ecoli genomes"
	grep "coli" ../Eschericia2017/Escherichia_assembly_summary_genbank.txt | grep "Complete Genome" | awk -F'\t' '{ print $$20 }' | sed 's/ftp.*[0-9]\///g' |  sed 's/$$/\//g' > $@


dload_ecoli:complete_Ecoli_genomes.txt
	@echo "Copying Ecoli genomes folder"
	mkdir -p CompleteEcoli
	rsync -av --files-from=complete_Ecoli_genomes.txt ../Eschericia2017/CompleteEscherichia/ CompleteEcoli/
	touch $@

copy_ecoli:dload_ecoli
	mkdir -p EcoliShigella_PhaME/ref	
	find CompleteEcoli -iname "*_genomic.fna.gz" | grep -v "from" > ecoli.txt
	rsync -av --files-from=ecoli.txt . EcoliShigella_PhaME/ref/
	touch $@

shigella: shigella_copy

shigella_copy:copy_ecoli
	@echo "Copying Shigella genomes fna files"
	find ../Shigella2017/CompleteShigella -iname "*_genomic.fna.gz" | grep -v "from" > shigella.txt
	rsync -av --files-from=shigella.txt ../ EcoliShigella_PhaME/ref/
	touch $@

both:unzip_genomes

unzip_genomes:
	find EcoliShigella_PhaME/ref -iname "*.gz" -exec gunzip -d {} \;
	find EcoliShigella_PhaME/ref -iname "*.fna" -exec cp {} EcoliShigella_PhaME/ref\;
	rm -rf EcoliShigella_PhaME/ref/Shigella2017 EcoliShigella_PhaME/ref/CompleteEcoli
	touch $@
