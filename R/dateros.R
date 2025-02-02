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
  testing_data$target <- fit_mean(training_data)
  evaluated_data <- testing_data
  return(evaluated_data)
}

eval_quadratic <- function(training_data, testing_data) {
  training_data$Peso2 <- training_data$Peso^2
  fitted_quadratic_model <- lm(target ~ Peso + Peso2, data=training_data)
  testing_data$target <- predict(fitted_quadratic_model, list(Peso=testing_data$Peso, Peso2=testing_data$Peso^2))
  names(testing_data$target) <- NULL
  evaluated_data <- testing_data
  return(evaluated_data)
}

eval_two_variables_quadratic <- function(training_data, testing_data) {
  training_data$Peso2 <- training_data$Peso^2
  training_data$Longitud_tarso2 <- training_data$Longitud_tarso^2
  fitted_quadratic_model <- lm(target ~ Peso + Peso2 + Longitud_tarso + Longitud_tarso2, data=training_data)
  testing_data$target <- predict(fitted_quadratic_model, list(Peso=testing_data$Peso, Peso2=testing_data$Peso^2, Longitud_tarso=testing_data$Longitud_tarso, Longitud_tarso2=testing_data$Longitud_tarso^2))
  evaluated_data <- testing_data
  return(evaluated_data)
}

eval_two_variables_quadratic_wings <- function(training_data, testing_data) {
  training_data$Peso2 <- training_data$Peso^2
  training_data$Longitud_ala2 <- training_data$Longitud_ala^2
  fitted_quadratic_model <- lm(target ~ Peso + Peso2 + Longitud_ala + Longitud_ala2, data=training_data)
  testing_data$target <- predict(fitted_quadratic_model, list(Peso=testing_data$Peso, Peso2=testing_data$Peso^2, Longitud_ala=testing_data$Longitud_ala, Longitud_ala2=testing_data$Longitud_ala^2))
  evaluated_data <- testing_data
  return(evaluated_data)
}

eval_two_quadratic <- function(training_data, testing_data) {
  center_point <- half_weight(training_data)
  are_lower_weight <- training_data$Peso < center_point
  are_lower_weight_testing <- testing_data$Peso < center_point
  lower_weight <- training_data[are_lower_weight,]
  upper_weight <- training_data[!are_lower_weight,]
  lower_weight_testing <- testing_data[are_lower_weight_testing,]
  upper_weight_testing <- testing_data[!are_lower_weight_testing,]
  lower_weight_testing <- eval_quadratic(lower_weight, lower_weight_testing)
  upper_weight_testing <- eval_quadratic(upper_weight, upper_weight_testing)
  evaluated_data <- bind_rows(lower_weight_testing, upper_weight_testing)
}

half_weight <- function(data){
  medium_point <- (max(data$Peso) + min(data$Peso))/2
  return(medium_point)
}