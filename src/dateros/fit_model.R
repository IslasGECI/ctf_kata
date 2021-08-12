library(tidyverse)
source("R/dateros.R")

original_data <- read_csv("pollos_petrel/train.csv")
testing_data <- read_csv("pollos_petrel/test.csv")

training_data <- divide_data(original_data)

submission_data <- eval_quadratic(training_data, testing_data) %>%
  select(c(id, target))

write_csv(submission_data, "pollos_petrel/dateros_submission.csv")
