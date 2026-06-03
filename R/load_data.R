#' Load democracy and dictatorship data
#'
#' Downloads the democracy dataset from the TidyTuesday GitHub repository
#' and returns it as a tibble.
#'
#' @return A tibble containing democracy and dictatorship data by country and year.
#' @importFrom readr read_csv
#' @export
#'
#' @examples
#' democracy_data <- load_data()
#' head(democracy_data)
load_data <- function() {
  readr::read_csv(
    "https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-11-05/democracy_data.csv",
    show_col_types = FALSE
  )
}
