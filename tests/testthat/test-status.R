test_that("capsule_status reports correctly", {
  with_temp_project(function(root) {
    writeLines("x <- 1", "x.R")
    backup_file("x.R")

    s <- capsule_status()

    expect_true(is.list(s))
    expect_equal(s$tracked_files, 1)
    expect_equal(s$backup_files, 1)
  })
})
