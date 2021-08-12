library(tidyverse)
source("R/dateros.R")

original_data <- read_csv("pollos_petrel/train.csv")
original_data <- na.omit(original_data)
testing_data <- read_csv("pollos_petrel/test.csv")
testing_data <- na.omit(testing_data)

training_data <- divide_data(original_data)

submission_data <- eval_quadratic(training_data, testing_data) %>%
  select(c(id, target))

write_csv(submission_data, "pollos_petrel/dateros_submission.csv")

submission_data <- eval_two_variables_quadratic(training_data, testing_data) %>%
  select(c(id, target))

write_csv(submission_data, "pollos_petrel/daterosTVQ_submission.csv")

submission_data <- eval_two_quadratic(training_data, testing_data) %>%
  select(c(id, target))

write_csv(submission_data, "pollos_petrel/daterosTQ_submission.csv")