#' Load world map data
#'
#' Loads small-scale country geometries from Natural Earth and returns them
#' as an sf object.
#'
#' @return An sf object containing country geometries.
#' @importFrom rnaturalearth ne_countries
#' @export
#'
#' #' @examples
#' world_data <- load_world_data()
#' head(world_data)
load_world_data <- function() {
  rnaturalearth::ne_countries(
    scale = "small",
    returnclass = "sf"
  )
}
