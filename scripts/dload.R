
library(RCurl)
library(curl)
library(stringr)
library(data.table)
library(optparse)

# If you have proxy, then all proxy needs to be disabled, including the one
# set in .Renviron

option_list <- list(
    make_option(c("-i", "--input"),
        help = "input file with ftp addresses to genomes"),
    make_option(c("-o", "--output"),
        help = "output folder where genomes will be downloaded"))

opt <- parse_args(OptionParser(option_list = option_list))


store_path <- opt$output

# setwd(store_path)
folderz <- unlist(fread(opt$input, sep = "\t", header=FALSE))
#
userpwd <- "anonymous:anonymous"
#
for (folder in folderz) {

    path <- file.path(store_path, basename(folder))
    if (!dir.exists(path = path)){
        dir.create(path = path, showWarnings = FALSE)

        print(paste(Sys.time(), ": processing folder ", folder, " into ", path))
        filenames <- getURL(folder, userpwd = userpwd,
                    ftp.use.epsv = FALSE, dirlistonly = TRUE)
        # print(filenames)
        filenames <- strsplit(filenames, "\n", fixed = FALSE,
            perl = FALSE, useBytes = FALSE)[[1]]
        filenames <- filenames[grepl("*.gz", filenames)]
        print(filenames)
        for (f in filenames) {
            uri <- paste0(folder, f)
            # print(uri)
            print(paste(Sys.time(), ": downloading file ",
                f, " into ", file.path(path, f)))
            curl_fetch_disk(uri, file.path(path, f))
      }
  }
  else{print(paste(folder, " exists!, skipping!"))}

    }
