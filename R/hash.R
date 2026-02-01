#' Compute file hash
#'
#' @param file File path relative to project root
#' @param root Project root path. Defaults to current RStudio project.
#' @keywords internal
#' @returns Character string of the file's MD5 hash, or NA if the file does not exist

#'
#' @examples
#' \dontrun{
#' file_hash("script.R")
#' }
file_hash <- function(file, root = project_root()) {
  path <- file.path(root, file)
  if (!file.exists(path)) {
    return(NA_character_)
  }
  unname(tools::md5sum(path))
}
