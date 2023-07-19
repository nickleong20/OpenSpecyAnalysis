# test_spectrum.R

# Load the testthat package
library(testthat)

# Load the spectrum function from your package or source file
source("/Users/nick_leong/Library/CloudStorage/GoogleDrive-nickleong@g.ucla.edu/My Drive/MIPPR/OpenSpecyAnalysis/R/spectrum.R")  # Replace "path_to_your_file.R" with the actual path to the file containing the spectrum function

# Define the test cases
test_that("spectrum function correctly identifies spectrum type", {
  # Test case 1: Raman spectrum
  raman_file <- "/Users/nick_leong/Downloads/testdata.csv"
  expect_equal(spectrum(raman_file), "Raman")

  # Test case 2: FTIR spectrum
  ftir_file <- "/Users/nick_leong/Downloads/ftir_ldpe_soil.asp"
  expect_equal(spectrum(ftir_file), "FTIR")
})
