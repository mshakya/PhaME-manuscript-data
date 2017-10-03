all:Escherichia_assembly_summary_genbank.txt complete_Escherichia_ftp_addresses.txt \
	CompleteEscherichia CompleteEscherichia/GCA_900174625.1_WI1-reUpload

################################################################################
Escherichia_assembly_summary_genbank.txt:
	@echo "Subsetting lines that contain Escherichia from summary assembly files"
	zgrep "Escherichia"  ../assembly_summary_genbank.txt.gz > $@

complete: complete_Escherichia_ftp_addresses.txt CompleteEscherichia \
	CompleteEscherichia/GCA_900174625.1_WI1-reUpload complete_complete

complete_Escherichia_ftp_addresses.txt:Escherichia_assembly_summary_genbank.txt
	@echo "Subsetting lines corresponding to complete Escherichia genomes"
	grep "Complete Genome" $< | awk -F'\t' '{ print $$20 }' | sed 's/$$/\//g' > $@

# Create a folder to download complete Escherichia genomes
CompleteEscherichia:
	@echo "Creating folder for downloading complete genomes"
	mkdir -p $@

CompleteEscherichia/GCA_900174625.1_WI1-reUpload:../scripts/dload.R complete_Escherichia_ftp_addresses.txt
	@echo "Downloading complete genomes as listed in  *.txt file"
	Rscript $< -i $(word 2, $^) -o CompleteEscherichia


complete_complete:
	mkdir -p Escherichia_PhaME/ref
	find CompleteEscherichia -name '*_genomic.fna.gz'| grep -v "from" > complete.txt
	rsync -av --files-from=complete.txt . Escherichia_PhaME/ref/
	find Escherichia_PhaME/ref -iname "*.gz" -exec mv {} Escherichia_PhaME/ref/ \;
	rm -rf Escherichia_PhaME/ref/CompleteEscherichia
	find Escherichia_PhaME/ref -iname "*.gz" -exec gzip -d {} \;
	touch $@


################################################################################
incomplete:incomplete_Escherichia_ftp_addresses.txt InCompleteEscherichia \
	InCompleteEscherichia/GCA_900177355.1_IMG-taxon_2608642167_annotated_assembly \


incomplete_Escherichia_ftp_addresses.txt:Escherichia_assembly_summary_genbank.txt
	@echo "Subsetting incomplete genomes to the new text file"
	grep "Contig\|Scaffold" $< | awk -F'\t' '{ print $$20 }' | sed 's/$$/\//g' > $@


# Create the directory to download incomple genomes into
InCompleteEscherichia:
	mkdir -p $@

# Download incomplete genomes
InCompleteEscherichia/GCA_900177355.1_IMG-taxon_2608642167_annotated_assembly:../scripts/dload.R incomplete_Escherichia_ftp_addresses.txt
	Rscript $< -i $(word 2, $^) -o InCompleteEscherichia

incomplete_incomplete:
	@echo ""
	find InCompleteEscherichia -name '*_genomic.fna.gz'| grep -v "from" > incomplete.txt
	rsync -av --files-from=complete.txt . Escherichia_PhaME/ref/
	find Escherichia_PhaME/ref -iname "*.gz" -exec mv {} Escherichia_PhaME/ref/ \;
	rm -rf Escherichia_PhaME/InCompleteEscherichia
	find Escherichia_PhaME/InCompleteEscherichia -iname "*.gz" -exec gzip -d {} \;
	touch $@

################################################################################
Non_ecoli_draft:non_ecoli_draft_genomes non_ecoli_incomplete_Eschericia_ftp_addresses.txt \
	non_ecoli_draft_genomes/GCA_002109845.1_ASM210984v1
# To download incomplete non_ecoli genomes

non_ecoli_draft_genomes:
	mkdir -p $@

non_ecoli_incomplete_Eschericia_ftp_addresses.txt:Escherichia_assembly_summary_genbank.txt
	@echo "Subsetting ftp addressses of non-ecoli draft genomes"
	grep -v "coli"  $< | grep "Contig\|Scaffold" | awk -F'\t' '{ print $$20 }' | sed 's/$$/\//g' > $@


non_ecoli_draft_genomes/GCA_002109845.1_ASM210984v1:../scripts/dload.R non_ecoli_incomplete_Eschericia_ftp_addresses.txt
	@echo "Downloading complete genomes as listed in  *.txt file"
	Rscript $< -i $(word 2, $^) -o non_ecoli_draft_genomes

##############################################################################

rand_100_ecoli_draft:rand_100_ecoli_draft_genomes rand_100_ecoli_draft_ftp_addresses.txt rand_100_ecoli_draft_genomes/GCA_002109845.1_ASM210984v1

rand_100_ecoli_draft_genomes:
	mkdir -p $@

rand_100_ecoli_draft_ftp_addresses.txt:Escherichia_assembly_summary_genbank.txt
	@echo "Subsetting ftp addressses of random ecoli draft genomes"
	grep "coli" $< | shuf -n 100 | grep "Contig\|Scaffold" | awk -F'\t' '{ print $$20 }' | sed 's/$$/\//g' > $@

rand_100_ecoli_draft_genomes/GCA_002109845.1_ASM210984v1:../scripts/dload.R rand_100_ecoli_draft_ftp_addresses.txt
	@echo "Downloading complete genomes as listed in  *.txt file"
	Rscript $< -i $(word 2, $^) -o rand_100_ecoli_draft_genomes
