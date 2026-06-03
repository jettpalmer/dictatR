test_that("load_world_data works", {
  world_data <- load_world_data()

  expect_s3_class(world_data, "sf")
  expect_true("geometry" %in% names(world_data))
})
