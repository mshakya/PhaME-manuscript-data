
ALL:all_zebov.fasta indiv_fasta zaire_ebola_phame \
	zaire_ebola_phame/KR105346_1_Zaire_ebolavirus_isolate_Ebola_virus_H_sapiens_wt_SLE_2014_Makona_G6091_1__partial_genome.contig \

all_zebov.fasta:data/Carroll2015.fasta data/Others.fasta data/PRJNA257197.fasta data/Simon-Loriere2015.fasta
	cat $< $(word 2, $^) $(word 3, $^) $(word 4, $^) > $@

indiv_fasta:../scripts/fastas2fasta.py all_zebov.fasta
	python $< -i $(word 2, $^) -o $@

zaire_ebola_phame:
	@echo "creating folder for phame run"
	mkdir -p $@
	mkdir -p $@/ref

zaire_ebola_phame/KR105346_1_Zaire_ebolavirus_isolate_Ebola_virus_H_sapiens_wt_SLE_2014_Makona_G6091_1__partial_genome.contig:zaire_ebola_phame
	cp indiv_fasta/*.fna zaire_ebola_phame/ref/
	cp indiv_fasta/*.contig zaire_ebola_phame/
