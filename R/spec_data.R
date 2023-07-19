# Install Required Packages
library(lattice)
library(MASS)
library(OpenSpecy)
library(dplyr)

# Determine file type
spec_data <- function(pathname) {
  file_extension <- tools::file_ext(pathname)

  if (file_extension %in% c("csv", "CSV")) {
    data <- read.csv(pathname, header = TRUE, stringsAsFactors = FALSE)
  } else if (file_extension %in% c("asp", "ASP")) {
    data <- OpenSpecy::read_asp(pathname)
  } else if (file_extension %in% c("jdx", "JDX")) {
    data <- OpenSpecy::read_jdx(pathname)
  } else if (file_extension %in% c("spc", "SPC")) {
    data <- OpenSpecy::read_spc(pathname)
  } else if (file_extension %in% c("spa", "SPA")) {
    data <- OpenSpecy::read_spa(pathname)
  } else if (file_extension %in% c("0")) {
    data <- OpenSpecy::read_0(pathname)
  } else {
    # File type not supported
    stop(paste0("Unsupported file type: ", file_extension))
  }

  return(data)
}
