#required packages
library(optparse)
library(ggtree)
library(gridExtra)
library(ape)
library(RColorBrewer)


option_list <- list(
    make_option(c("-i", "--input"), action="store",
              help="input tree to be colored"),
    make_option(c("-t", "--table"), action="store",
              help="input table that contains a column with matching taxa 
              and a column with categorical data"),
    make_option(c("-n", "--name"), action="store",
              help="column # in the table that has taxa name matching
              tree taxa"),
    make_option(c("-c", "--category"), action="store",
              help="column # in the table that has categorical value for coloring"),
    make_option(c("-o", "--output"), action="store",
              help="output tree pdf file")
)

opt<-parse_args(OptionParser(option_list=option_list))

tree_file <- opt$input
table_file <- opt$table
name_col <- opt$name
category_col <- opt$category
out_file <- opt$output

################################################################################

annot_table <- read.table(opt$table, sep=",", header=T)

tree <- read.tree(tree_file)
print(tree)
p <- ggtree(tree)
p <- p %<+% annot_table + geom_tiplab(aes(color=Phylo.group2))

p <- p+theme(legend.position="right")
ggsave("test.pdf", plot=p, width=32, height = 99, units="in", limitsize=FALSE)


