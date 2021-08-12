library(testthat)
library(tidyverse)
source('../../R/dateros.R')

describe("Test dummy", {
  it("Returns 1", {
    expected <- 1
    obtained <- return_1()
    expect_equal(expected,obtained,tolerance = 1e-3)
  })
})

describe("Divide datos proporción 20/80", {
  datos_prueba <- tibble(A=c(1,2,3,4,5),B=c('A','B','C','D','E'))
  it("Que los renglones sean 4", {
    expected_n_row <- 4
    obtained_data <- divide_data(datos_prueba)
    obtained_n_row <- nrow(obtained_data)
    expect_equal(expected_n_row,obtained_n_row,tolerance = 1e-3)
  })
})
