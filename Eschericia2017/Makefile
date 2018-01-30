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
	grep "Complete Genome\|Chromosome" $< | awk -F'\t' '{ print $$20 }' | sed 's/$$/\//g' > $@

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

##############################################################################
# TW genomes (cryptic clades)
TWs:Escherichia_TW.txt Escherichia_TW_ftp.txt TW_genomes TW_genomes/GCA_000208585.2_ASM20858v2

Escherichia_TW.txt:Escherichia_assembly_summary_genbank.txt
	awk -F'\t' '$$9~/TW/' $< | grep "Georgia" > $@

Escherichia_TW_ftp.txt:Escherichia_TW.txt
	awk -F'\t' '{ print $$20 }' $< | sed 's/$$/\//g' > $@

TW_genomes:
	mkdir -p $@

TW_genomes/GCA_000208585.2_ASM20858v2:../scripts/dload.R Escherichia_TW_ftp.txt
	Rscript $< -i $(word 2, $^) -o TW_genomes

################################################################################
Fergusons:Escherichia_fergusonii.txt Escherichia_fergusonii_ftp.txt fergusonii_genomes fergusonii_genomes/GCA_001471755.1_ASM147175v1

Escherichia_fergusonii.txt:Escherichia_assembly_summary_genbank.txt
	grep "fergusonii" $< > $@

Escherichia_fergusonii_ftp.txt:Escherichia_fergusonii.txt
	awk -F'\t' ' { print $$20 } ' $< | sed 's/$$/\//g' > $@

fergusonii_genomes:
	mkdir -p $@

fergusonii_genomes/GCA_001471755.1_ASM147175v1:../scripts/dload.R Escherichia_fergusonii_ftp.txt
	Rscript $< -i $(word 2, $^) -o fergusonii_genomes

################################################################################
hermannii:hermannii.txt hermannii_ftp.txt hermannii_genomes hermannii_genomes/GCA_001471755.1_ASM147175v1

hermannii.txt:../assembly_summary_genbank.txt.gz
	zgrep "hermannii" $< > $@

hermannii_ftp.txt:hermannii.txt
	awk -F'\t' ' { print $$20 } ' $< | sed 's/$$/\//g' > $@

hermannii_genomes:
	mkdir -p $@

hermannii_genomes/GCA_001471755.1_ASM147175v1:../scripts/dload.R hermannii_ftp.txt
	Rscript $< -i $(word 2, $^) -o hermannii_genomes


################################################################################
blattae:blattae.txt blattae_ftp.txt blattae_genomes blattae_genomes/GCA_001471755.1_ASM147175v1

blattae.txt:../assembly_summary_genbank.txt.gz
	zgrep "blattae" $< > $@

blattae_ftp.txt:blattae.txt
	awk -F'\t' ' { print $$20 } ' $< | sed 's/$$/\//g' > $@

blattae_genomes:
	mkdir -p $@

blattae_genomes/GCA_001471755.1_ASM147175v1:../scripts/dload.R blattae_ftp.txt
	Rscript $< -i $(word 2, $^) -o blattae_genomes

################################################################################
albertii:albertii.txt albertii_ftp.txt albertii_genomes albertii_genomes/GCA_001471755.1_ASM147175v1

albertii.txt:Escherichia_assembly_summary_genbank.txt
	grep "albertii" $< > $@

albertii_ftp.txt:albertii.txt
	awk -F'\t' ' { print $$20 } ' $< | sed 's/$$/\//g' > $@

albertii_genomes:
	mkdir -p $@

albertii_genomes/GCA_001471755.1_ASM147175v1:../scripts/dload.R albertii_ftp.txt
	Rscript $< -i $(word 2, $^) -o albertii_genomes
