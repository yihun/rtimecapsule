test_that("project_root errors when not in a valid project", {
  expect_error(project_root())
})
