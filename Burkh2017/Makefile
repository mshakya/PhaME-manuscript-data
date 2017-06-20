
complete_burkh_ftp_addresses.txt:Burkh_assembly_summary_genbank.txt
	grep "Complete Genome" $< | awk -F'\t' '{ print $$20 }' > $@
