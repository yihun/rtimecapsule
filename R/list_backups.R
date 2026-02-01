#' List backups for a file
#'
#' @param root Project root path. Defaults to current RStudio project.
#' @param file File path relative to project root
#' @keywords internal
#' @return Character vector of backup filenames
list_backups <- function(file, root = project_root()) {
  backup_dir <- file.path(root, ".rtimecapsule")
  if (!dir.exists(backup_dir)) {
    return(character())
  }

  base <- basename(file)
  pattern <- paste0("^", gsub("\\.", "_", base))

  list.files(backup_dir, pattern = pattern, full.names = FALSE)
}
