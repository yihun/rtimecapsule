#' Stop rtimecapsule auto-backup
#'
#' Stops the background backup loop.
#'
#' @return Invisibly TRUE
#' @export
stop_autobackup <- function() {
  .rtimecapsule_state$running <- FALSE
  message("rtimecapsule stopped")
  invisible(TRUE)
}
