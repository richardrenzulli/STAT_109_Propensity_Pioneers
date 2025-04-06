install.packages("BSDA")
library(BSDA)
install.packages("reshape2")
library(reshape2)
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
install.packages("car")
library(car)
library(MASS)
# Define data

kaggle_training_data <- read.csv("customer_propensity_training_sample.csv")
# str(kaggle_training_data)
# summary(kaggle_training_data)
kaggle_training_data_df <- as.data.frame(kaggle_training_data)
str(kaggle_training_data)

# Sample dataframe
set.seed(123)
sampled_kaggle_training_data_df <- kaggle_training_data_df[sample(nrow(kaggle_training_data_df), size = 100000), ]

# Sample Satistics
# sampled_data_mean = mean()

for (col in names(sampled_kaggle_training_data_df)) {
  barplot(table(sampled_kaggle_training_data_df[[col]]), main = paste("Bar Plot of", col), xlab = col)
}

for (col in names(sampled_kaggle_training_data_df)) {
  prop <- prop.table(table(sampled_kaggle_training_data_df[[col]]))
  barplot(prop, main = paste("Proportion Plot of", col), xlab = col, ylab = "Proportion")
}

df_melted <- melt(sampled_kaggle_training_data_df)
ggplot(df_melted, aes(x = variable, fill = value)) +
  geom_bar(position = "fill") +
  labs(title = "Stacked Bar Plot of Binomial Variables", x = "Variables", y = "Proportion")

# prop.table(table(sampled_kaggle_training_data_df))

# barplot(table(sampled_kaggle_training_data_df))


#CI for sample
tsum.test(mean.x = )

# Define model
m2 <- glm(ordered ~ . -UserID -loc_uk, data = kaggle_training_data) # sampled_kaggle_training_data_df
summary(m2)

m2_sample <- glm(ordered ~ . -UserID -loc_uk, data = sampled_kaggle_training_data_df) # sampled_kaggle_training_data_df
summary(m2_sample)

# Best predictor assessment
model1 <- stepAIC(m2_sample, direction = "both", trace = F)
summary(model1)
attributes(model1)
model1$coefficients

model2 <- stepAIC(m2_sample, direction = "backward", trace = F)
summary(model2)
model2$coefficients

model3 <- stepAIC(m2_sample, direction = "forward", trace = F)
summary(model3)
model3$coefficients

# Assuming you have three models: model1, model2, model3
coefficients_list <- list(model1$coefficients, model2$coefficients, model3$coefficients)

# Get all unique coefficient names
all_coeff_names <- unique(unlist(lapply(coefficients_list, names)))

# Create a data frame to store coefficients
coefficients_df <- data.frame(matrix(nrow = length(coefficients_list), ncol = length(all_coeff_names)))
colnames(coefficients_df) <- all_coeff_names
row.names(coefficients_df) <- c("Model 1", "Model 2", "Model 3")

# Fill the data frame with coefficients
for (i in 1:length(coefficients_list)) {
  coeff <- coefficients_list[[i]]
  coefficients_df[i, names(coeff)] <- coeff
}

# Display the organized coefficients
coefficients_df
