test_that("start_autobackup runs and stops cleanly", {
  skip_if_not_installed("later")

  with_temp_project(function(root) {
    writeLines("x <- 1", "a.R")

    start_autobackup(interval = 0.1)

    Sys.sleep(0.3)

    expect_true(
      file.exists(file.path(".rtimecapsule", "a.R"))
    )

    stop_autobackup()

    expect_false(isTRUE(.rtimecapsule_state$running))
  })
})
