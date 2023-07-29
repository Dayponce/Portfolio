# Depscriptive Statistics
attach (Fish.1)

# Measures of Central Tendency: Mean, Mode, and Median
mean(SL.mm.) #123.3684 mm
mode <- function(r) {
  ur <- unique(r)
  ur[which.max(tabulate(match(r, ur)))]
}
mode(SL.mm.) # 119
median(SL.mm.) # 123

# Measures of Dispersion/Spread and Variability
max(SL.mm.)- min(SL.mm.)# Range= 33 
var(SL.mm.) # Variance= 61.24561
sd (SL.mm.) #St dev= 7.825958
quantile(SL.mm., type=1)
# 0%  25%  50%  75% 100% 
# 105  118  123  130  138 
IQR(SL.mm., type=1) #Inrerquartile range= 12
#Skewdeness: slightly postively (right) skewed
#Kurtosis: leptokurtic = positive kurtosis: accentuated peak 

#	Measures of Precision of estimates
sd(SL.mm.)/ sqrt(length(SL.mm.)) #Standard error= 1.795398
library(gmodels) 
ci(SL.mm.) #provides an estimate of the mean, confidence interval and standard error 
# Estimate   CI lower   CI upper Std. Error 
# 123.368421 119.596430 127.140412   1.795398

#VISUALIZATIONS
#Histogram
hist(SL.mm.)
#Boxplot
boxplot(SL.mm.)
#Boxplot: relationship between Population (categorical) and SL (continous)
boxplot(SL.mm.~Population) #larger in Baffinlsl vs Greenland
#Scatterplot 
plot(SL.mm.,Specimen)
plot(Specimen,SL.mm.)
detach(Fish.1)

# The dataset contains measurements of Standard Length (SL) in millimeters for 
# fish specimens. The measures of central tendency reveal that the mean SL is approximately 123.37 mm, the mode is 119 mm, and the median is 123 mm. The data exhibit a slight positive (right) skewness and are leptokurtic, indicating an accentuated peak.
# 
# The measures of dispersion and variability show that the range of SL values
# is 33 mm, with a variance of 61.25 and a standard deviation of 7.83. The 
# variance and standard deviation indicate high variation around the mean, 
# with relatively small distances within the sample.
# 
# The quartiles indicate that 25% of the data falls between 105 mm and 118 mm,
# while the interquartile range is 12 mm, highlighting considerable variability
# within the dataset.
# 
# The analysis of precision shows that the average standard error is 1.80, 
# suggesting an accurate representation of the true population mean.
# 
# Visualizations such as the histogram, boxplot, and scatter plot provide 
# insights into the distribution and relationship between SL and the categorical 
# variable "Population." The boxplot suggests that SL is larger in Baffinlsl
# compared to Greenland, showing significant differences in the range of fish 
# samples between the two populations.
