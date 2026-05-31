test_that("summarize_country_regimes works", {
  dat <- load_data()

  result <- summarize_country_regimes(dat, country = "Bolivia")

  # Check object type
  expect_s3_class(result, "tbl_df")

  # Check expected column names
  expect_equal(names(result), c("Year", "Regime"))

  # Check expected values (e.g., Bolivia in 1950)
  expect_equal(result$Year[1], 1950)
  expect_equal(result$Regime[1], "Civilian dictatorship")
})
