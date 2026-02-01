with_temp_project <- function(code) {
  old <- getwd()
  tmp <- tempfile("rtc_proj_")
  dir.create(tmp)
  file.create(file.path(tmp, "test.Rproj"))

  setwd(tmp)
  on.exit(setwd(old), add = TRUE)

  code(tmp)
}
