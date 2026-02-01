#' Backup a file to .rtimecapsule folder
#'
#' @param file File path to back up
#' @param root Project root path (default: detected automatically)
#' @return NULL (invisibly)
#' @keywords internal
#' @examples
#' # Create a temporary file to demonstrate backup
#' tmp <- tempfile(fileext = ".R")
#' writeLines("print('hello world')", tmp)
#'
#' # Backup the temporary file
#' \dontrun{
#' backup_file(tmp, root = tempdir())
#' }
#'
#' # Clean up
#' unlink(tmp)
backup_file <- function(file, root = project_root()) {
  if (grepl("^\\.rtimecapsule/", file)) {
    return(FALSE)
  }

  src <- file.path(root, file)
  if (!file.exists(src)) {
    return(FALSE)
  }

  dest <- file.path(root, ".rtimecapsule", file)
  dir.create(dirname(dest), recursive = TRUE, showWarnings = FALSE)

  file.copy(src, dest, overwrite = TRUE)
}
