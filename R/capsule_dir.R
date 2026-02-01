#' Get or create the rtimecapsule directory
#'
#' Internal helper to locate the `.rtimecapsule` directory
#' inside the current project.
#'
#' @keywords internal
capsule_dir <- function() {
  root <- project_root()
  dir <- file.path(root, ".rtimecapsule")

  if (!dir.exists(dir)) {
    dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  }

  dir
}
