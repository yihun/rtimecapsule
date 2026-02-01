#' List tracked files in the project
#'
#' Determines which files should be tracked based on user input.
#'
#' @param root Project root path
#' @param files NULL (default), a single extension like ".R",
#'   or a character vector of specific file names
#'
#' @return Character vector of relative file paths
#' @keywords internal
#' @examples
#' \dontrun{
#' # Only works inside an RStudio project
#' tracked_files()
#' }
tracked_files <- function(
  root = project_root(),
  files = NULL
) {
  # ---- Case 1: default → track all R / Rmd / qmd ----
  if (is.null(files)) {
    exts <- c("R", "r", "Rmd", "rmd", "qmd", "Qmd")

    all_files <- list.files(
      root,
      recursive = TRUE,
      full.names = FALSE
    )

    all_files <- all_files[!grepl("^\\.rtimecapsule/", all_files)]

    return(
      all_files[
        grepl(
          paste0("\\.(", paste(exts, collapse = "|"), ")$"),
          all_files,
          ignore.case = TRUE
        )
      ]
    )
  }

  # ---- Case 2: extension only (".R") ----
  if (length(files) == 1 && grepl("^\\.", files)) {
    ext <- sub("^\\.", "", files)

    all_files <- list.files(
      root,
      recursive = TRUE,
      full.names = FALSE
    )

    all_files <- all_files[!grepl("^\\.rtimecapsule/", all_files)]

    return(
      all_files[
        grepl(
          paste0("\\.", ext, "$"),
          all_files,
          ignore.case = TRUE
        )
      ]
    )
  }

  # ---- Case 3: explicit file list ----
  if (is.character(files)) {
    missing <- files[!file.exists(file.path(root, files))]

    if (length(missing) > 0) {
      stop(
        "These files do not exist in the project:\n",
        paste(missing, collapse = ", "),
        call. = FALSE
      )
    }

    return(files)
  }
  stop("Invalid 'files' specification", call. = FALSE)
}
