install.packages("BSDA")
library(BSDA)
install.packages("reshape2")
library(reshape2)
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
install.packages("car")
library(car)
library(MASS)


# Joining and resampling the data
kaggle_training_data <- read.csv("customer_propensity_training_sample.csv")
kaggle_testing_data <- read.csv("customer_propensity_testing_sample.csv")

kaggle_total_data <- rbind(kaggle_training_data, kaggle_testing_data)

dim(kaggle_training_data)
dim(kaggle_testing_data)
dim(kaggle_total_data)

ind <- sample(c(1, 2), nrow(kaggle_total_data), replace = TRUE, prob = c(0.75, 0.25))
training <- kaggle_total_data[ind == 1, ]
testing <- kaggle_total_data[ind == 2, ]

summary(training$ordered)
summary(testing$ordered)
summary(kaggle_training_data$ordered)
summary(kaggle_testing_data$ordered)
