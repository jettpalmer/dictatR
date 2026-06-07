#' Write dictatR datasets as Parquet files
#'
#' @param path A directory where the Parquet files should be saved.
#'
#' @return A character vector of the desired file path to write Parquet files.
#'
#' @export
#' Write dictatR datasets as Parquet files
#'
#' @param path A directory where the Parquet files should be saved.
#'
#' @return A character vector of file paths to the written Parquet files.
#'
#' @export
write_dictatr_parquet <- function(path = ".") {

  if (!requireNamespace("arrow", quietly = TRUE)) {
    stop("The arrow package is required to write Parquet files. ",
         "Install it with install.packages('arrow').",
         call. = FALSE)
  }

  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE)
  }

  files <- c(
    democracy = file.path(path, "democracy.parquet"),
    coups = file.path(path, "coups.parquet"),
    world = file.path(path, "world.parquet"))

  arrow::write_parquet(load_data(), files[["democracy"]])
  arrow::write_parquet(load_coup_data(), files[["coups"]])
  arrow::write_parquet(load_world_data(), files[["world"]])

  message("Wrote Parquet files to: ", normalizePath(path))

  invisible(files)
}
