#' Restore a file from backup
#'
#' @param file File path relative to project root
#' @return Invisibly TRUE
#' @export
restore_file <- function(file) {
  root <- project_root()
  backup <- file.path(root, ".rtimecapsule", file)

  if (!file.exists(backup)) {
    stop("No backup available for ", file)
  }

  target <- file.path(root, file)
  dir.create(dirname(target), recursive = TRUE, showWarnings = FALSE)

  file.copy(backup, target, overwrite = TRUE)
  invisible(TRUE)
}
