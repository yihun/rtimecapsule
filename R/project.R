#' Detect the current project root
#'
#' Walks up the directory tree until an `.Rproj` file is found.
#' Prevents execution inside an R package source directory.
#'
#' @return Absolute path to project root
#' @keywords internal
project_root <- function() {
  wd <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)

  repeat {
    # Block package source directories
    if (file.exists(file.path(wd, "DESCRIPTION")) &&
      file.exists(file.path(wd, "NAMESPACE"))) {
      stop(
        "rtimecapsule should be run inside a user project, not a package source directory",
        call. = FALSE
      )
    }

    if (any(grepl("\\.Rproj$", list.files(wd)))) {
      return(wd)
    }

    parent <- dirname(wd)
    if (identical(parent, wd)) {
      stop("rtimecapsule must be run inside an RStudio project", call. = FALSE)
    }

    wd <- parent
  }
}
