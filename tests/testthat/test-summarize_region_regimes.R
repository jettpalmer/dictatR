test_that("summarize_region_regimes works", {
  dat <- load_data()

  result <- summarize_region_regimes("East Asia & Pacific")

  # Check object type
  expect_s3_class(result, "tbl_df")

  # Check expected columns
  expect_equal(names(result), c("total",
                                "Democratic",
                                "Presidential",
                                "Monarch",
                                "Commonwealth",
                                "Colony",
                                "Communist")
               )

  # Check expected values
  expect_equal(result$total[1], 2556)
  expect_equal(result$Democratic[1], 0.442488, tolerance = 1e-4)
})
