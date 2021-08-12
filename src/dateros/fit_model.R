library(tidyverse)
source('R/dateros.R')

original_data <- read_csv("pollos_petrel/train.csv")

training_data <- divide_data(original_data)

