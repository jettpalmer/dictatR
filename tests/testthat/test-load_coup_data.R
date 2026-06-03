test_that("load_coup_data works", {
  coups <- load_coup_data()

  expect_s3_class(coups, "tbl_df")
  expect_true("country" %in% names(coups))
})
