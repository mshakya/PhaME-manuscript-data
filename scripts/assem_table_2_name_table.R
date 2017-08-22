
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

print(head(assembly_table))