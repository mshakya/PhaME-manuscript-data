library(SRAdb)
library(stringr)
library(RCurl)
library(optparse)
library(curl)

# A script to download reads of following SRPs corresponding to Burkholderias

option_list <- list(
    make_option(c("-o", "--output"),
        help = "output directory"))

opt <- parse_args(OptionParser(option_list = option_list))

store_path <- opt$output
path <- file.path(store_path)
  if (!dir.exists(path = path)){
      dir.create(path = path, showWarnings = FALSE)}

# need to download sqlite database if not present
sqlfile <- "/users/222935/data/SRAmetadb.sqlite"
sra_con <- dbConnect(dbDriver("SQLite"), sqlfile)

################################################################################
# uncomment lines below to get Run number information for each SRP project
################################################################################
burkhs <- dbGetQuery(sra_con, "select * from experiment where PLATFORM = 'ILLUMINA' and
                 library_layout like '%PAIRED%' and
                study_accession in 
                 ('SRP049112','SRP049075','SRP049110','SRP062112','SRP049114')")
                 #  'SRP062077','SRP049124','SRP049146','SRP049149','SRP062115',
                 #  'SRP049123','SRP062079','SRP062081','SRP060201','SRP060210',
                 #  'SRP060209','SRP060216','SRP060248','SRP060264','SRP060249',
                 #  'SRP060250','SRP060262','SRP060260','SRP048778','SRP049181',
                 #  'SRP048989','SRP049182','SRP049074','SRP049073','SRP062817',
                 #  'SRP062818','SRP062824','SRP062827','SRP049160','SRP048996',
                 #  'SRP049185','SRP065554' ,'SRP048978','SRP062049','SRP065540',
                 #  'SRP048773','SRP065534','SRP048979','SRP048780','SRP062815',
                 #  'SRP049170','SRP048774','SRP048779','SRP065533','SRP049093',
                 #  'SRP048980','SRP049181','SRP048777','SRP048748','SRP048749',
                 #  'SRP062146','SRP048981')")

burkhs_runs <- listSRAfile( c(burkhs$study_accession), sra_con,
  fileType = 'fastq', srcType = "ftp" )

write.csv(burkhs_runs, file.path(store_path, "burks_reads.csv"))
################################################################################

burkhs_runs <- read.csv(file.path(store_path, "burks_reads.csv"))

# print(head(burkhs_runs))

for (ftp in burkhs_runs$ftp) {
    file_name <- rev(strsplit(ftp, "/")[[1]])[1]
    file_path <- file.path(path, file_name)
    print(file_path)
      
    if (!file.exists(file_path)) {
        print(paste(Sys.time(), ": processing ftp ", ftp, " into ", file_path))
        print(paste(Sys.time(), ": downloading file ", ftp, " into ", file_path))
        curl_fetch_disk(ftp, file_path)
        print(paste(Sys.time(), ": downloading file finished"))

}
  else{
    "File exists, skipping!"
  }
}