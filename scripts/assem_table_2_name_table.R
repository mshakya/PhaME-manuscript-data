
library(RCurl)
library(curl)
library(stringr)
library(data.table)
library(optparse)

option_list <- list(
    make_option(c("-i", "--input"),
        help = "input assembly_summary_file"),
    make_option(c("-o", "--output"),
        help = "table"))

opt <- parse_args(OptionParser(option_list = option_list))

assembly_file <- opt$input
store_path <- opt$output

assembly_table <- fread(paste("zcat", assembly_file))

#subset
names <- assembly_table[, c("# assembly_accession", "asm_name",
                               "organism_name", "infraspecific_name"), with=FALSE]

colnames(names) <- c("assembly_accession", "asm_name", "organism_name",
                     "infraspecific_name")

#TODO, find out what Phame uses and make sure its consistenet here.
names$assembly_accession <- gsub('\\.', "_", names$assembly_accession)
names$asm_name <- gsub("\\.", "_", names$asm_name)
names$tip_name <- paste(names$assembly_accession, names$asm_name, sep="_")

print(head(names))