test_that("add_regions works", {
  test_data <- tibble::tibble(country_code = c("NUR", "GER", "PRI", "MAR",
                                           "USA", "IND", "ZAR"))
  result <- add_regions(test_data)

  # Check object type
  expect_s3_class(result, "tbl_df")

  # Check expected columns
  expect_equal(names(result), c("country_code", "region"))

  # Check mappings
  expected <- c(
    "East Asia & Pacific",
    "Europe & Central Asia",
    "Latin America & Caribbean",
    "Middle East & North Africa",
    "North America",
    "South Asia",
    "Sub-Saharan Africa"
  )
  expect_equal(result$region, expected)
})
