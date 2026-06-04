#' Validate a dataset
#'
#' @param democracy_data Dataframe of countries' regimes.
#'
#' @returns Invisibly returns `TRUE` when the data input is a dataframe.
validate_dataset <- function(country, democracy_data = load_data()) {

  if (!is.data.frame(country)) {
    stop("data input must be a dataframe", call. = FALSE)
  }

  invisible(TRUE)
}



#' Validate a country
#'
#' @param country Three letter ISO country code.
#' @param democracy_data Optional dataframe of countries' regimes.
#'
#' @returns Invisibly returns `TRUE` when the country code input is present in the data.
validate_country <- function(country, democracy_data = load_data()) {

  if (!is.character(country)) {
    stop("Country code input must be a string", call. = FALSE)
  }

  if (!nchar(country) == 3) {
    stop("Country code input must three letters", call. = FALSE)
  }

  if (!country %in% democracy_data$country_code) {
    stop("Country code not found in the dataset", call. = FALSE)
  }

  invisible(TRUE)
}



#' Validate a region
#'
#' @param region World Bank region.
#'
#' @returns Invisibly returns `TRUE` when the region input is a valid World Bank region.
validate_region <- function(region) {

  if (!is.character(region)) {
    stop("Region input must be a string", call. = FALSE)
  }

  valid_regions <- c("East Asia & Pacific",
                     "Europe & Central Asia",
                     "Latin America & Caribbean",
                     "Middle East & North Africa",
                     "North America",
                     "South Asia",
                     "Sub-Saharan Africa"
                     )

  if (!region %in% valid_regions) {
    stop("Region must be one of: East Asia & Pacific, Europe & Central Asia,
    Latin America & Caribbean, Middle East & North Africa, North America,
    South Asia, Sub-Saharan Africa.", call. = FALSE)
  }

  invisible(TRUE)
}
