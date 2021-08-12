return_1 <- function() {
  return(1)
}

divide_data <- function(input_data) {
  output_data <- sample_frac(input_data, size = 0.8)
  return(output_data)
}

fit_mean <- function(input_data) {
  mean_target <- mean(input_data$target)
  return(mean_target)
}

eval_fit_mean <- function(training_data, testing_data) {
  evaluated_data <- testing_data$target
  return(evaluated_data)
}
