# Subset lines that contain Burkholderias from summary assembly files

Burkh_assembly_summary_genbank.txt:
	zgrep "Burkholderia"  ../assembly_summary_genbank.txt.gz > $@

# Subset lines corresponding to complete burkholderia genomes
complete_burkh_ftp_addresses.txt:Burkh_assembly_summary_genbank.txt
	grep "Complete Genome" $< | awk -F'\t' '{ print $$20 }' | sed 's/$$/\//g' > $@

# Create a folder to download complete burkholderia genomes
CompleteBurkhs:
	mkdir -p $@

# Download the complete genomes as listed in te *.txt file
CompleteBurkhs/GCA_002111385.1_ASM211138v1:scripts/dload.R complete_burkh_ftp_addresses.txt
	Rscript $< -i $(word 2, $^) -o CompleteBurkhs

# subset incomplete genomes to the new text file
incomplete_burkh_ftp_addresses.txt:Burkh_assembly_summary_genbank.txt
	grep "Contig\|Scaffold" $< | awk -F'\t' '{ print $$20 }' | sed 's/$/\//g' > $@


# Create the directory to download incomple genomes into
InCompleteBurkhs:
	mkdir -p $@

# Download incomplete genomes
InCompleteBurkhs/GCA_002111385.1_ASM211138v1:scripts/dload.R incomplete_burkh_ftp_addresses.txt
	Rscript $< -i $(word 2, $^) -o InCompleteBurkhs

Phame:Burkh_PhaME complete_complete incomplete_incomplete

Burkh_PhaME:
	@echo "Create working directory for Phame run"
	mkdir -p $@
	mkdir -p $@/ref
	mkdir -p $@/contigs

complete_complete:
	@echo "Copy genomic fna files into the ref folder"
	find CompleteBurkhs -name '*_genomic.fna.gz'| grep -v "from" > complete.txt
	rsync -av --files-from=complete.txt . Burkh_PhaME/ref/
	find Burkh_PhaME/ref/ -iname "*.gz" -exec gunzip -d {} \;
	find Burkh_PhaME/ref -iname "*.fna" -exec cp {} Burkh_PhaME/ref \;
	rm -rf Burkh_PhaME/ref/CompleteBurkhs
	touch $@

incomplete_incomplete:
	@echo "Copy and rename fna files of incomplete genomes."
	find InCompleteBurkhs -name '*_genomic.fna.gz'| grep -v "from" > incomplete.txt
	rsync -av --files-from=incomplete.txt . Burkh_PhaME/contigs/
	find Burkh_PhaME/contigs -iname "*.gz" -exec gunzip -d {} \;
	cd Burkh_PhaME/contigs
	rename .fna .contig *.fna
	mv *.contig ../
	cd ..
	rm -rf contigs






