#' Load coup data
#'
#' Downloads the coup dataset from Powell & Thyne (2011)
#' and returns it as a tibble.
#'
#' @return A tibble containing coup attempts and outcomes by country and year.
#' @importFrom readr read_tsv
#' @export
#'
#' #' @examples
#' coups <- load_coup_data()
#' head(coups)
load_coup_data <- function() {
  readr::read_tsv(
    "http://www.uky.edu/~clthyn2/coup_data/candidate_dataset.txt"
  )
}
