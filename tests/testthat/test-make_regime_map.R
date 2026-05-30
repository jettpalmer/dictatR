test_that("make_regime_map outputs a class:leaflet", {
  democracy_data <- load_data()
  world_data <- load_world_data()

  regime_map <- make_regime_map(democracy_data, world_data)

  # Check object type
  expect_s3_class(regime_map, "leaflet")
})
