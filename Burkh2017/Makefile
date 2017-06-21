
complete_burkh_ftp_addresses.txt:Burkh_assembly_summary_genbank.txt
	grep "Complete Genome" $< | awk -F'\t' '{ print $$20 }' sed 's/$/\//g' > $@

CompleteBurkhs:
	mkdir -p $@

CompleteBurkhs/GCA_002111385.1_ASM211138v1:scripts/dload.R complete_burkh_ftp_addresses.txt
	Rscript $< -i $(word 2, $^) -o CompleteBurkhs

incomplete_burkh_ftp_addresses.txt:Burkh_assembly_summary_genbank.txt
	grep "Contig\|Scaffold" $< | awk -F'\t' '{ print $$20 }' | sed 's/$/\//g' > $@

InCompleteBurkhs:
	mkdir -p $@

InCompleteBurkhs/GCA_002111385.1_ASM211138v1:scripts/dload.R incomplete_burkh_ftp_addresses.txt
	Rscript $< -i $(word 2, $^) -o InCompleteBurkhs