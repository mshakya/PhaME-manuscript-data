all:Salmonella_assembly_summary_genbank.txt complete_Salmonella_ftp_addresses.txt \
	CompleteSalmonella CompleteSalmonella/GCA_900185485.1_BL60006

##################################################################################################
# Downloads complete and incomplete Salmonella genomes
##################################################################################################
Salmonella_assembly_summary_genbank.txt:
	@echo "Subsetting lines that contain Salmonella from summary assembly files"
	zgrep "Salmonella"  ../assembly_summary_genbank.txt.gz > $@

complete: complete_Salmonella_ftp_addresses.txt CompleteSalmonella \
	CompleteSalmonella/GCA_900174625.1_WI1-reUpload complete_complete

complete_Salmonella_ftp_addresses.txt:Salmonella_assembly_summary_genbank.txt
	@echo "Subsetting lines corresponding to complete Salmonella genomes"
	grep "Complete Genome" $< | awk -F'\t' '{ print $$20 }' | sed 's/$$/\//g' > $@

# Create a folder to download complete Salmonella genomes
CompleteSalmonella:
	@echo "Creating folder for downloading complete genomes"
	mkdir -p $@

CompleteSalmonella/GCA_900185485.1_BL60006:../scripts/dload.R complete_Salmonella_ftp_addresses.txt
	@echo "Downloading complete genomes as listed in  *.txt file"
	Rscript $< -i $(word 2, $^) -o CompleteSalmonella


complete_complete:
	mkdir -p Salmonella_PhaME/ref
	find CompleteSalmonella -name '*_genomic.fna.gz'| grep -v "from" > complete.txt
	rsync -av --files-from=complete.txt . Salmonella_PhaME/ref/
	find Salmonella_PhaME/ref -iname "*.gz" -exec mv {} Salmonella_PhaME/ref/ \;
	rm -rf Salmonella_PhaME/ref/CompleteSalmonella
	find Salmonella_PhaME/ref -iname "*.gz" -exec gzip -d {} \;
	touch $@


incomplete:incomplete_Salmonella_ftp_addresses.txt InCompleteSalmonella \
	InCompleteSalmonella/GCA_900177355.1_IMG-taxon_2608642167_annotated_assembly \


incomplete_Salmonella_ftp_addresses.txt:Salmonella_assembly_summary_genbank.txt
	@echo "Subsetting incomplete genomes to the new text file"
	grep "Contig\|Scaffold" $< | awk -F'\t' '{ print $$20 }' | sed 's/$$/\//g' > $@


# Create the directory to download incomple genomes into
InCompleteSalmonella:
	mkdir -p $@

# Download incomplete genomes
InCompleteSalmonella/GCA_900177355.1_IMG-taxon_2608642167_annotated_assembly:../scripts/dload.R incomplete_Salmonella_ftp_addresses.txt
	Rscript $< -i $(word 2, $^) -o InCompleteSalmonella


incomplete_incomplete:
	@echo ""
	find InCompleteSalmonella -name '*_genomic.fna.gz'| grep -v "from" > incomplete.txt
	rsync -av --files-from=complete.txt . Salmonella_PhaME/ref/
	find Salmonella_PhaME/ref -iname "*.gz" -exec mv {} Salmonella_PhaME/ref/ \;
	rm -rf Salmonella_PhaME/InCompleteSalmonella
	find Salmonella_PhaME/InCompleteSalmonella -iname "*.gz" -exec gzip -d {} \;
	touch $@

