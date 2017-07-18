all:Escherichia_assembly_summary_genbank.txt complete_Escherichia_ftp_addresses.txt \
	CompleteEscherichia CompleteEscherichia/GCA_900174625.1_WI1-reUpload

# Subset lines that contain Escherichia from summary assembly files
Escherichia_assembly_summary_genbank.txt:
	zgrep "Escherichia"  ../assembly_summary_genbank.txt.gz > $@

# Subset lines corresponding to complete Escherichia genomes
complete_Escherichia_ftp_addresses.txt:Escherichia_assembly_summary_genbank.txt
	grep "Complete Genome" $< | awk -F'\t' '{ print $$20 }' | sed 's/$$/\//g' > $@

# Create a folder to download complete Escherichia genomes
CompleteEscherichia:
	mkdir -p $@

# Download the complete genomes as listed in te *.txt file
CompleteEscherichia/GCA_900174625.1_WI1-reUpload:../scripts/dload.R complete_Escherichia_ftp_addresses.txt
	Rscript $< -i $(word 2, $^) -o CompleteEscherichia

# subset incomplete genomes to the new text file
incomplete_Escherichia_ftp_addresses.txt:Escherichia_assembly_summary_genbank.txt
	grep "Contig\|Scaffold" $< | awk -F'\t' '{ print $$20 }' | sed 's/$/\//g' > $@


# Create the directory to download incomple genomes into
InCompleteEscherichia:
	mkdir -p $@

# Download incomplete genomes
InCompleteEscherichia/GCA_002111385.1_ASM211138v1:../scripts/dload.R incomplete_Escherichia_ftp_addresses.txt
	Rscript $< -i $(word 2, $^) -o InCompleteEscherichia


# Create working directory for Phame run
Burkh_PhaME:
	mkdir -p $@
	mkdir -p $@/ref

# Copy genomic fna files into the ref folder

complete_complete:
	find CompleteEscherichia -name '*_genomic.fna.gz'| grep -v "from" > complete.txt
	rsync -av --include-from=complete.txt Burkh_PhaME/ref/
	# rm complete.txt
	touch $@