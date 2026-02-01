#' Show rtimecapsule status
#'
#' @return Invisibly returns a list
#' @export
capsule_status <- function() {
  root <- project_root()
  backup_dir <- file.path(root, ".rtimecapsule")

  files <- tracked_files(root)

  list(
    running = isTRUE(.rtimecapsule_state$running),
    tracked_files = length(files),
    backup_files = if (dir.exists(backup_dir)) {
      length(list.files(backup_dir, recursive = TRUE))
    } else {
      0L
    }
  )
}
