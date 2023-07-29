#Descriptive Stats
attach (fatcats)

# Measures of Central Tendency: Mean, Mode, and Median
#Body wt (Bwt)
mean(Bwt) #2.723611
mode <- function(r) {
  ur <- unique(r)
  ur[which.max(tabulate(match(r, ur)))]
}
mode(Bwt) # 2.2
median(Bwt) # 2.7

# Measures of Dispersion/Spread and Variability
max(Bwt)- min(Bwt)# Range= 1.9
var(Bwt) # Variance= 0.2355225
sd (Bwt) #St dev= 0.4853066
quantile(Bwt, type=1)
# 0%  25%  50%  75% 100% 
# 2.0  2.3  2.7  3.0  3.9 
IQR(Bwt, type=1) #Inrerquartile range= 0.7

#	Measures of Precision of estimates
sd(Bwt)/ sqrt(length(Bwt)) #Standard error= 0.04044222
library(gmodels) 
ci(Bwt) #provides an estimate of the mean, confidence interval and standard error 
# Estimate   CI lower   CI upper Std. Error 
# 2.72361111 2.64366929 2.80355293 0.04044222 

#VISUALIZATIONS
#Histogram
hist(Bwt,xlab='Body weight',col=c('red','blue','black'),xlim=c(1.5,4.5),ylim=c(0,35))
  #Postive skew

#Boxplot
boxplot(Bwt~Sex,xlab='Sex',ylab='Body weight', col=c('pink', 'blue'))
abline(h=mean(Bwt),lty=4)
text(0.5,2.8,bquote(paste('mean')))
  #Male have a higher Bwt than Female cats (F cats below overall avg)

#Horizontal Boxplot
boxplot(Bwt~Sex, horizontal= TRUE, ylab='Sex',xlab='Body weight', col=c('pink', 'blue'))
abline(v=mean(Bwt),lty=3)
text(0.5,2.8,bquote(paste('mean')))

# The dataset consists of body weight (Bwt) measurements for cats. The measures of central tendency indicate that the mean body weight is approximately 2.72, the mode is 2.2, and the median is 2.7.
# 
# Measures of dispersion and variability show that the range of body weights is 1.9, with a variance of 0.24 and a standard deviation of 0.49. The data exhibit a positive skewness, suggesting a tail on the right side of the distribution.
# 
# The interquartile range (IQR) for body weight is 0.7, indicating considerable variability within the dataset.
# 
# The standard error is 0.04, which provides a measure of precision for the estimate of the mean body weight.
# 
# Visualizations include a histogram and boxplots. The histogram reveals a positive skewness in the data distribution. The boxplot analysis demonstrates that male cats have a higher body weight than female cats, 
# Load the dataset (if not already loaded)
data(fatcats)

# Correlation analysis between Body weight (Bwt) and Heart weight (Hwt)
correlation <- cor(fatcats$Bwt, fatcats$Hwt)
# Print the correlation coefficient
cat("Correlation Coefficient between Bwt and Hwt:", correlation)
  #Correlation Coefficient between Bwt and Hwt: 0.8041274
# Scatter plot to visualize the relationship
plot(fatcats$Bwt, fatcats$Hwt, xlab = "Body weight (Bwt)", ylab = "Heart weight (Hwt)", main = "Scatter plot of Bwt vs Hwt")
  #postive corr; linearity
#Quick summary: The correlation analysis between body weight (Bwt) and heart 
#weight (Hwt) in the "fatcats" dataset indicates a strong positive correlation 
#(correlation coefficient: 0.804), as shown in the scatter plot, suggesting a
#linear relationship between these two variables

# PLOT WITH GGPLOTS
library(ggplot2)
# Boxplot with custom colors and themes
ggplot(fatcats, aes(x = Sex, y = Bwt, fill = Sex)) +
  geom_boxplot() +
  labs(title = "Boxplot of Body weight by Sex",
       x = "Sex",
       y = "Body weight") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))
# Scatter plot with regression line
ggplot(fatcats, aes(x = Bwt, y = Hwt)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Scatter plot of Body weight vs Heart weight",
       x = "Body weight",
       y = "Heart weight") +
  theme_minimal()
# Histogram with density plot
ggplot(fatcats, aes(x = Bwt, fill = Sex)) +
  geom_histogram(binwidth = 0.2, alpha = 0.7) +
  geom_density(alpha = 0.5, color = "red") +
  labs(title = "Histogram with Density Plot of Body Weight",
       x = "Body weight",
       y = "Density") +
  theme_minimal()

detach(fatcats)
