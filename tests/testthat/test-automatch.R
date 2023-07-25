library(testthat)

# Test read_data function for supported file types
test_that("Test automatch function for no errors", {
  # Test reading each file type and check for no errors
  expect_snapshot(automatch("data/testdata.csv"))
})
