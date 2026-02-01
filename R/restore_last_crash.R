#' Restore all files from last backup
#'
#' @return Invisibly TRUE
#' @export
restore_last_crash <- function() {
  root <- project_root()
  backup_root <- file.path(root, ".rtimecapsule")

  if (!dir.exists(backup_root)) {
    stop("No backups found")
  }

  files <- list.files(backup_root, recursive = TRUE, full.names = TRUE)

  for (b in files) {
    rel <- sub(paste0("^", backup_root, "/"), "", b)
    target <- file.path(root, rel)

    dir.create(dirname(target), recursive = TRUE, showWarnings = FALSE)
    file.copy(b, target, overwrite = TRUE)
  }

  invisible(TRUE)
}
