#' Map countries to World Bank regions
#'
#' @param democracy_data Dataframe of countries.
#'
#' @returns Input dataframe with added region column.
#' @importFrom dplyr mutate
#' @importFrom countrycode countrycode
add_regions <- function(democracy_data = load_data()) {
  democracy_data |>
    mutate(region = countrycode(country_code,
                                origin = 'iso3c',
                                destination = 'region',
                                # Custom matches for the codes that don't find match
                                custom_match = c('ZAR' = 'Sub-Saharan Africa',
                                                 'GER' = 'Europe & Central Asia',
                                                 'NUR' = 'East Asia & Pacific',
                                                 'PRI' = 'Latin America & Caribbean',
                                                 'ROM' = 'Europe & Central Asia'
                                                 )
                                )
           )
}
