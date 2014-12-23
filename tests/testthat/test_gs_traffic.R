context("testing gs_traffic")

key <- Sys.getenv("GaugesKey")

a <- gs_traffic(id='4efd83a6f5a1f5158a000004', key=key)
b <- gs_traffic(id='4efd83a6f5a1f5158a000004', date = "2014-11-21", key=key)

test_that("gs_traffic returns correct class", {
  expect_is(a, "list")
  expect_is(a$metadata$people, "integer")
  expect_is(a$metadata, "list")
  expect_is(a$data, "data.frame")
  expect_is(a$data$date, "character")

  expect_is(b, "list")
  expect_is(b$metadata, "list")
  expect_is(b$data, "data.frame")
  expect_is(b$metadata$urls$newer, "character")
})

test_that("gs_traffic fails correctly", {
  library('httr')
  expect_error(gs_traffic(key=key), 'argument "id" is missing')
  expect_error(gs_traffic(id='4efd83a6f5a1f5158a000004', key=key, config=timeout(0.01)), "timed out after")
})
