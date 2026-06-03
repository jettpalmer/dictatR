#' Load coup data
#'
#' Downloads the coup dataset and returns it as a tibble.
#'
#' @return A tibble containing coup attempts and outcomes by country and year.
#' @importFrom readr read_tsv
#' @export
load_coup_data <- function() {
  readr::read_tsv(
    "http://www.uky.edu/~clthyn2/coup_data/candidate_dataset.txt"
  )
}
