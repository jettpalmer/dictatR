test_that("load_data works", {
  democracy_data <- load_data()

  expect_s3_class(democracy_data, "tbl_df")
  expect_true("country_name" %in% names(democracy_data))
})
