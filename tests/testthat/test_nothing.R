library(testthat)
source('../../R/dateros.R')

describe("Test dummy", {
  it("Returns 1", {
    expected <- 1
    obtained <- return_1()
    expect_equal(expected,obtained,tolerance = 1e-3)
  })
})
