       refdir = ref  # directory where reference files are located
      workdir = workdir # directory where contigs/reads files are located and output is stored

    reference = 1  # 0:pick a random reference; 1:use given reference; 2: pick a reference based on mash distance
      reffile = GCA_000015625.1_ASM1562v1_genomic.fna  # reference filename 

      project = b_all  # main alignment file name

      cdsSNPS = 1  # 0:no cds SNPS; 1:cds SNPs

    FirstTime = 1  # 1:yes; 2:update existing SNP alignment

         data = 6  # *See below 0:only complete(F); 1:only contig(C); 2:only reads(R); 
                   # 3:combination F+C; 4:combination F+R; 5:combination C+R; 
                   # 6:combination F+C+R; 7:realignment  *See below 
        reads = 3  # 1: single reads; 2: paired reads; 3: both types present;

   SNPSfilter = 0.0 # proportion of polymorphic site (based off total coverage)

         tree = 4  # 0:no tree; 1:use FastTree; 2:use RAxML; 3: use IQ-TREE; 4:use all;
    bootstrap = 1  # 0:no; 1:yes;  # Run bootstrapping  *See below
            N = 100  # Number of bootstraps to run *See below

    PosSelect = 0  # 0:No; 1:use PAML; 2:use HyPhy; 3:use both

        clean = 1  # 0:no clean; 1:clean

      threads = 24  # Number of threads to use

       cutoff = 0  # Mismatch cutoff - ignore SNPs within cutoff length of each other.

* When using data option 1,2,5 need a complete reference to align/map to. 
* Use data option 7 when need to extract SNPs using a sublist of already aligned genomes. 
