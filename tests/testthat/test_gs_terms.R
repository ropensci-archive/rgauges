context("testing gs_terms")

key <- Sys.getenv("GaugesKey")

a <- gs_terms(id='4efd83a6f5a1f5158a000004', date="2014-12-01", key=key)
b <- gs_terms(id='4efd83a6f5a1f5158a000004', date="2014-12-01", page = 2, key=key)

test_that("gs_terms returns correct class", {
  expect_is(a, "list")
  expect_is(a$metadata, "list")
  expect_is(a$data, "data.frame")
  expect_is(a$data$term, "character")
  expect_null(a$metadata$urls$previous_page)

  expect_is(b, "list")
  expect_is(b$metadata, "list")
  expect_null(b$data)
  expect_is(b$metadata$urls$previous_page, "character")
})

test_that("gs_terms fails correctly", {
  library('httr')
  expect_error(gs_terms(key=key), 'argument "id" is missing')
  expect_error(gs_terms(id='4efd83a6f5a1f5158a000004', key=key, config=timeout(0.01)), "timed out after")
})
