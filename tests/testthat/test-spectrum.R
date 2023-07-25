library(testthat)

# Test read_data function for supported file types
test_that("spectrum function returns raman, ftir, or unknown spectrum", {
  # Test reading each file type and check for no errors
  result <- spectrum("data/testdata.csv")

  expect_match(result, "Raman|FTIR|Unknown")
})
