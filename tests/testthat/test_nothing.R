library(testthat)
library(tidyverse)
source("../../R/dateros.R")

describe("Test dummy", {
  it("Returns 1", {
    expected <- 1
    obtained <- return_1()
    expect_equal(expected, obtained, tolerance = 1e-3)
  })
})

describe("Divide data in a proportion of 80/20", {
  datos_prueba <- tibble(A = c(1, 2, 3, 4, 5), B = c("A", "B", "C", "D", "E"))
  it("That the number of rows is 4", {
    expected_n_row <- 4
    obtained_data <- divide_data(datos_prueba)
    obtained_n_row <- nrow(obtained_data)
    expect_equal(expected_n_row, obtained_n_row, tolerance = 1e-3)
  })
  datos_prueba <- tibble(A = c(1, 2, 3, 4, 5, 1, 2, 3, 4, 5), B = c("A", "B", "C", "D", "E", "A", "B", "C", "D", "E"))
  it("That the number of rows is 8", {
    expected_n_row <- 8
    obtained_data <- divide_data(datos_prueba)
    obtained_n_row <- nrow(obtained_data)
    expect_equal(expected_n_row, obtained_n_row, tolerance = 1e-3)
  })
  datos_prueba <- tibble(A = c(1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 3, 4, 5, 1, 2), B = c("A", "B", "C", "D", "E", "A", "B", "C", "D", "E", "A", "B", "C", "D", "E"))
  it("That the number of rows is 8", {
    expected_n_row <- 12
    obtained_data <- divide_data(datos_prueba)
    obtained_n_row <- nrow(obtained_data)
    expect_equal(expected_n_row, obtained_n_row, tolerance = 1e-3)
  })
})

describe("Test fit mean", {
  datos_prueba <- tibble(A = c(1, 2, 3, 4, 5), B = c("A", "B", "C", "D", "E"), target = c(3, 3, 3, 3, 3), id = c("A", "B", "C", "D", "E"))
  it("Mean is correct", {
    expected <- 3
    obtained <- fit_mean(datos_prueba)
    expect_equal(expected, obtained, tolerance = 1e-3)
  })
  datos_prueba <- tibble(A = c(1, 2, 3, 4, 5), B = c("A", "B", "C", "D", "E"), target = c(6, 4, 5, 5, 5), id = c("A", "B", "C", "D", "E"))
  it("Mean is correct", {
    expected <- 5
    obtained <- fit_mean(datos_prueba)
    expect_equal(expected, obtained, tolerance = 1e-3)
  })
  datos_prueba <- tibble(A = c(1, 2, 3, 4, 5), B = c("A", "B", "C", "D", "E"), target = c(6, 4, 8, 5, 2), id = c("A", "B", "C", "D", "E"))
  it("Mean is correct", {
    expected <- 5
    obtained <- fit_mean(datos_prueba)
    expect_equal(expected, obtained, tolerance = 1e-3)
  })
})

describe("Eval fit mean", {
  it("Target equal to 3", {
    training_data <- tibble(A = c(1, 2, 3, 4, 5), B = c("A", "B", "C", "D", "E"), target = c(3, 3, 3, 3, 3), id = c("A", "B", "C", "D", "E"))
    expected_data <- tibble(A = c(1, 2), B = c("A", "B"), target = c(3, 3), id = c("A", "B"))
    testing_data <- tibble(A = c(1, 2), B = c("A", "B"), target = c(5, 8), id = c("A", "B"))
    obtained_data <- eval_fit_mean(training_data, testing_data)
    expect_equal(expected_data, obtained_data, tolerance = 1e-3)
  })
  it("Target equal to 5", {
    training_data <- tibble(A = c(1, 2, 3, 4, 5), B = c("A", "B", "C", "D", "E"), target = c(5, 5, 5, 5, 5), id = c("A", "B", "C", "D", "E"))
    expected_data <- tibble(A = c(1, 2), B = c("A", "B"), id = c("A", "B"), target = c(5, 5))
    testing_data <- tibble(A = c(1, 2), B = c("A", "B"), id = c("A", "B"), target = c(5, 8))
    obtained_data <- eval_fit_mean(training_data, testing_data)
    expect_equal(expected_data, obtained_data, tolerance = 1e-3)
  })
  it("Target without column target and 3 rows", {
    training_data <- tibble(A = c(1, 2, 3, 4, 5), B = c("A", "B", "C", "D", "E"), target = c(5, 5, 5, 5, 5), id = c("A", "B", "C", "D", "E"))
    expected_data <- tibble(A = c(1, 2, 3), B = c("A", "B", "C"), id = c("A", "B", "C"), target = c(5, 5, 5))
    testing_data <- tibble(A = c(1, 2, 3), B = c("A", "B", "C"), id = c("A", "B", "C"))
    obtained_data <- eval_fit_mean(training_data, testing_data)
    expect_equal(expected_data, obtained_data, tolerance = 1e-3)
  })
})

describe("Half weight", {
  it("Returns 5", {
    datos_prueba <- tibble(A = c(1, 2, 3, 4, 5), B = c("A", "B", "C", "D", "E"), Peso = c(6, 4, 8, 5, 2), id = c("A", "B", "C", "D", "E"))
    expected <- 5
    obtained <- half_weight(datos_prueba)
    expect_equal(expected, obtained, tolerance = 1e-3)
  })
  it("Returns 3", {
    datos_prueba <- tibble(A = c(1, 2, 3, 4, 5), B = c("A", "B", "C", "D", "E"), Peso = c(1, 2, 3, 4, 5), id = c("A", "B", "C", "D", "E"))
    expected <- 3
    obtained <- half_weight(datos_prueba)
    expect_equal(expected, obtained, tolerance = 1e-3)
  })
  it("Returns 7", {
    datos_prueba <- tibble(A = c(1, 2, 3, 4, 5), B = c("A", "B", "C", "D", "E"), Peso = c(1, 2, 3, 4, 13), id = c("A", "B", "C", "D", "E"))
    expected <- 7
    obtained <- half_weight(datos_prueba)
    expect_equal(expected, obtained, tolerance = 1e-3)
  })
})

describe("Test eval_two_quadratic", {
  it("Target equal to 3", {
    training_data <- tibble(Peso = c(1, 2, 3, 4, 5), B = c("A", "B", "C", "D", "E"), target = c(1, 4, , 9, 15, 23), id = c("A", "B", "C", "D", "E"))
    expected_data <- tibble(id = c("A", "E"), Peso = c(1, 5), B = c("A", "E"), target = c(1, 23))
    testing_data  <- tibble(id = c("A", "E"), Peso = c(1, 2), B = c("A", "E"), target = c(5, 8))
    obtained_data <- eval_quadratic(training_data, testing_data)
    testthat::expect_equal(expected_data, obtained_data, tolerance = 1e-3)
  })
})

describe("Test eval_quadratic", {
  it("Target equal to 3", {
    training_data <- tibble(Peso = c(1, 2, 3, 4, 5), B = c("A", "B", "C", "D", "E"), target = c(3, 3, 3, 3, 3), id = c("A", "B", "C", "D", "E"))
    expected_data <- tibble(id = c("A", "B"), Peso = c(1, 2), B = c("A", "B"), target = c(3, 3))
    testing_data <- tibble(id = c("A", "B"), Peso = c(1, 2), B = c("A", "B"), target = c(5, 8))
    obtained_data <- eval_quadratic(training_data, testing_data)
    testthat::expect_equal(expected_data, obtained_data, tolerance = 1e-3)
  })
  it("A second example y=x^2", {
    training_data <- tibble(Peso = c(1, 2, 3, 4, 5), B = c("A", "B", "C", "D", "E"), target = c(1, 4, 9, 16, 25), id = c("A", "B", "C", "D", "E"))
    expected_data <- tibble(id = c("A", "B"), Peso = c(2, 3), B = c("A", "B"), target = c(4, 9))
    testing_data <- tibble(id = c("A", "B"), Peso = c(2, 3), B = c("A", "B"), target = c(5, 8))
    obtained_data <- eval_quadratic(training_data, testing_data)
    testthat::expect_equal(expected_data, obtained_data, tolerance = 1e-3)
  })
  it("A second example y=x^2-x+3", {
    training_data <- tibble(Peso = c(1, 2, 3, 4, 5), B = c("A", "B", "C", "D", "E"), target = c(3, 5, 9, 15, 23), id = c("A", "B", "C", "D", "E"))
    expected_data <- tibble(id = c("A", "B"), Peso = c(6, 7), B = c("A", "B"), target = c(33, 45))
    testing_data <- tibble(id = c("A", "B"), Peso = c(6, 7), B = c("A", "B"), target = c(5, 8))
    obtained_data <- eval_quadratic(training_data, testing_data)
    testthat::expect_equal(expected_data, obtained_data, tolerance = 1e-3)
  })
})