test_that("file_hash and backup_file work", {
  with_temp_project(function(root) {
    f <- "analysis.R"
    writeLines("x <- 1", f)

    h1 <- file_hash(f)
    expect_true(nzchar(h1))

    backup_file(f)

    backup <- file.path(".rtimecapsule", f)
    expect_true(file.exists(backup))

    writeLines("x <- 2", f)
    h2 <- file_hash(f)

    expect_false(identical(h1, h2))
  })
})
