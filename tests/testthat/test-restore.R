test_that("restore_file restores deleted file", {
  with_temp_project(function(root) {
    writeLines("x <- 42", "analysis.R")
    backup_file("analysis.R")

    unlink("analysis.R")
    expect_false(file.exists("analysis.R"))

    restore_file("analysis.R")
    expect_true(file.exists("analysis.R"))
  })
})

test_that("restore_last_crash restores all files", {
  with_temp_project(function(root) {
    writeLines("a <- 1", "a.R")
    writeLines("b <- 2", "b.R")

    backup_file("a.R")
    backup_file("b.R")

    unlink(c("a.R", "b.R"))

    restore_last_crash()

    expect_true(file.exists("a.R"))
    expect_true(file.exists("b.R"))
  })
})
