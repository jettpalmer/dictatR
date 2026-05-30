test_that("make_regime_map works", {
  democracy_data <- load_data()
  world_data <- load_world_data()

  regime_map <- make_regime_map(democracy_data, world_data)

  expect_s3_class(regime_map, "leaflet")
})
