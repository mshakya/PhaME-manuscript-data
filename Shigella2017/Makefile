all:Shigella_assembly_summary_genbank.txt complete_Shigella_ftp_addresses.txt \
	CompleteShigella CompleteShigella/GCA_900174625.1_WI1-reUpload

##################################################################################################

##################################################################################################
Shigella_assembly_summary_genbank.txt:
	@echo "Subsetting lines that contain Shigella from summary assembly files"
	zgrep "Shigella"  ../assembly_summary_genbank.txt.gz > $@

complete: complete_Shigella_ftp_addresses.txt CompleteShigella \
	CompleteShigella/GCA_900174625.1_WI1-reUpload complete_complete

complete_Shigella_ftp_addresses.txt:Shigella_assembly_summary_genbank.txt
	@echo "Subsetting lines corresponding to complete Shigella genomes"
	grep "Complete Genome" $< | awk -F'\t' '{ print $$20 }' | sed 's/$$/\//g' > $@

# Create a folder to download complete Shigella genomes
CompleteShigella:
	@echo "Creating folder for downloading complete genomes"
	mkdir -p $@

CompleteShigella/GCA_900174625.1_WI1-reUpload:../scripts/dload.R complete_Shigella_ftp_addresses.txt
	@echo "Downloading complete genomes as listed in  *.txt file"
	Rscript $< -i $(word 2, $^) -o CompleteShigella


complete_complete:
	mkdir -p Shigella_PhaME/ref
	find CompleteShigella -name '*_genomic.fna.gz'| grep -v "from" > complete.txt
	rsync -av --files-from=complete.txt . Shigella_PhaME/ref/
	find Shigella_PhaME/ref -iname "*.gz" -exec mv {} Shigella_PhaME/ref/ \;
	rm -rf Shigella_PhaME/ref/CompleteShigella
	find Shigella_PhaME/ref -iname "*.gz" -exec gzip -d {} \;
	touch $@

################################################################################

incomplete:incomplete_Shigella_ftp_addresses.txt InCompleteShigella \
	InCompleteShigella/GCA_900177355.1_IMG-taxon_2608642167_annotated_assembly \


incomplete_Shigella_ftp_addresses.txt:Shigella_assembly_summary_genbank.txt
	@echo "Subsetting incomplete genomes to the new text file"
	grep "Contig\|Scaffold" $< | awk -F'\t' '{ print $$20 }' | sed 's/$$/\//g' > $@


# Create the directory to download incomple genomes into
InCompleteShigella:
	mkdir -p $@

# Download incomplete genomes
InCompleteShigella/GCA_900177355.1_IMG-taxon_2608642167_annotated_assembly:../scripts/dload.R incomplete_Shigella_ftp_addresses.txt
	Rscript $< -i $(word 2, $^) -o InCompleteShigella


incomplete_incomplete:
	@echo ""
	find InCompleteShigella -name '*_genomic.fna.gz'| grep -v "from" > incomplete.txt
	rsync -av --files-from=complete.txt . Shigella_PhaME/ref/
	find Shigella_PhaME/ref -iname "*.gz" -exec mv {} Shigella_PhaME/ref/ \;
	rm -rf Shigella_PhaME/InCompleteShigella
	find Shigella_PhaME/InCompleteShigella -iname "*.gz" -exec gzip -d {} \;
	touch $@

################################################################################

rand_100_Shigella_draft:rand_100_shigella_draft_genomes rand_100_shigella_draft_ftp_addresses.txt rand_100_shigella_draft_genomes/GCA_002109845.1_ASM210984v1

rand_100_shigella_draft_genomes:
	mkdir -p $@

rand_100_shigella_draft_ftp_addresses.txt:Shigella_assembly_summary_genbank.txt
	@echo "Subsetting ftp addressses of random shigella draft genomes"
	grep "Shigella" $< | shuf -n 100 | grep "Contig\|Scaffold" | awk -F'\t' '{ print $$20 }' | sed 's/$$/\//g' > $@

rand_100_shigella_draft_genomes/GCA_002109845.1_ASM210984v1:../scripts/dload.R rand_100_shigella_draft_ftp_addresses.txt
	@echo "Downloading complete genomes as listed in  *.txt file"
	Rscript $< -i $(word 2, $^) -o rand_100_shigella_draft_genomes

################################################################################
