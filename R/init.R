#' Enable rtimecapsule auto-start
#'
#' Adds rtimecapsule startup to the project .Rprofile
#'
#' @return Invisibly TRUE
#' @export
use_autobackup <- function() {
  root <- project_root()
  rprofile <- file.path(root, ".Rprofile")

  line <- "if (interactive()) rtimecapsule::start_autobackup()"

  if (!file.exists(rprofile) || !any(grepl(line, readLines(rprofile)))) {
    write(line, rprofile, append = TRUE)
    message(".Rprofile updated")
  }

  invisible(TRUE)
}
