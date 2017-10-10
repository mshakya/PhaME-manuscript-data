To extract name of organism from the genbank file.
 
```
zgrep "Salmonella\|Shigella\|Escherichia" ../assembly_summary_genbank.txt.gz | grep "Complete Genome" | awk -F'\t' '{$20=$20 "_genomic\t"; print $20, $8, $9, $1}' | sed 's/^ftp.*\/G/G/g' | sed 's/[;\.\:-\,= ]/_/g'  > EschShigSalm_name.txt
```

# Assign name to tree file
perl taxnameconvert.pl -f 1 -t 2 EschShigSalm_name.txt PhaME/results/EschShigSalmRef_all.fasttree > EschShigSalmRef.fasttree


# Map bootstraps to best tree from RaxML

 raxmlHPC-PTHREADS -m GTRCAT -p 12345 -f b -t PhaME/results/RAxML_bestTree.EschShigSalmRef_all -z PhaME/results/RAxML_bootstrap.EschShigSalmRef_all_b -n mapped

# Rename taxa names of mapped bootstrap tree

 perl taxnameconvert.pl -f 1 -t 2 EschShigSalm_name.txt RAxML_bipartitions.mapped EschShigSalmRef_bs_raxml.tre