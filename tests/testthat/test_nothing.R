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

describe("Divide data in a proportion of 80/20", {
  datos_prueba <- tibble(A=c(1,2,3,4,5),B=c('A','B','C','D','E'))
  it("That the number of rows is 4", {
    expected_n_row <- 4
    obtained_data <- divide_data(datos_prueba)
    obtained_n_row <- nrow(obtained_data)
    expect_equal(expected_n_row,obtained_n_row,tolerance = 1e-3)
  })
  datos_prueba <- tibble(A=c(1,2,3,4,5,1,2,3,4,5),B=c('A','B','C','D','E','A','B','C','D','E'))
  it("That the number of rows is 8", {
    expected_n_row <- 8
    obtained_data <- divide_data(datos_prueba)
    obtained_n_row <- nrow(obtained_data)
    expect_equal(expected_n_row,obtained_n_row,tolerance = 1e-3)
  })
  datos_prueba <- tibble(A=c(1,2,3,4,5,1,2,3,4,5,3,4,5,1,2),B=c('A','B','C','D','E','A','B','C','D','E','A','B','C','D','E'))
  it("That the number of rows is 8", {
    expected_n_row <- 12
    obtained_data <- divide_data(datos_prueba)
    obtained_n_row <- nrow(obtained_data)
    expect_equal(expected_n_row,obtained_n_row,tolerance = 1e-3)
  })
})

describe("Test fit mean", {
  datos_prueba <- tibble(A=c(1,2,3,4,5),B=c('A','B','C','D','E'),target=c(3,3,3,3,3),id=c('A','B','C','D','E'))
  it("Mean is correct", {
    expected <- 3
    obtained <- fit_mean(datos_prueba)
    expect_equal(expected,obtained,tolerance = 1e-3)
  })
  datos_prueba <- tibble(A=c(1,2,3,4,5),B=c('A','B','C','D','E'),target=c(6,4,5,5,5),id=c('A','B','C','D','E'))
  it("Mean is correct", {
    expected <- 5
    obtained <- fit_mean(datos_prueba)
    expect_equal(expected,obtained,tolerance = 1e-3)
  })
  datos_prueba <- tibble(A=c(1,2,3,4,5),B=c('A','B','C','D','E'),target=c(6,4,8,5,2),id=c('A','B','C','D','E'))
  it("Mean is correct", {
    expected <- 5
    obtained <- fit_mean(datos_prueba)
    expect_equal(expected,obtained,tolerance = 1e-3)
  })
})

describe("Eval fit mean", {
  it("Target equal to 3", {
    training_data <- tibble(A=c(1,2,3,4,5),B=c('A','B','C','D','E'),target=c(3,3,3,3,3),id=c('A','B','C','D','E'))
    expected_data <- tibble(A=c(1,2),B=c('A','B'),target=c(3,3),id=c('A','B'))
    testing_data <- tibble(A=c(1,2),B=c('A','B'),target=c(5,8),id=c('A','B'))
    obtained_data <- eval_fit_mean(training_data,testing_data)
    expect_equal(expected_data,obtained_data,tolerance = 1e-3)
  })
  it("Target equal to 5", {
    training_data <- tibble(A=c(1,2,3,4,5),B=c('A','B','C','D','E'),target=c(5,5,5,5,5),id=c('A','B','C','D','E'))
    expected_data <- tibble(A=c(1,2),B=c('A','B'),target=c(5,5),id=c('A','B'))
    testing_data <- tibble(A=c(1,2),B=c('A','B'),target=c(5,8),id=c('A','B'))
    obtained_data <- eval_fit_mean(training_data,testing_data)
    expect_equal(expected_data,obtained_data,tolerance = 1e-3)
  })
})
