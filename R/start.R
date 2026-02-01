#' Start rtimecapsule auto-backup (non-blocking)
#'
#' Runs a background task that mirrors selected files
#' into the .rtimecapsule folder whenever they change.
#' @param interval Seconds between checks
#' @param files NULL (default), a file extension (e.g. ".R"),
#'   or a character vector of file names
#'
#' @return Invisibly TRUE
#' @export
start_autobackup <- function(interval = 2, files = NULL) {
  if (!requireNamespace("later", quietly = TRUE)) {
    stop("The 'later' package is required for background mode", call. = FALSE)
  }

  root <- project_root()

  if (isTRUE(.rtimecapsule_state$running)) {
    message("rtimecapsule is already running")
    return(invisible(TRUE))
  }

  .rtimecapsule_state$running <- TRUE
  .rtimecapsule_state$hashes <- new.env(parent = emptyenv())
  .rtimecapsule_state$files <- files

  scan_once <- function() {
    if (!isTRUE(.rtimecapsule_state$running)) {
      return()
    }

    tracked <- tracked_files(
      root = root,
      files = .rtimecapsule_state$files
    )

    for (f in tracked) {
      h <- file_hash(f, root)

      if (!identical(.rtimecapsule_state$hashes[[f]], h)) {
        backup_file(f, root)
        .rtimecapsule_state$hashes[[f]] <- h
      }
    }

    later::later(scan_once, delay = interval)
  }

  scan_once()
  message("rtimecapsule started in background")
  invisible(TRUE)
}
