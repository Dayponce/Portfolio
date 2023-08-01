#Data set: Longnose.csv

#RQ: Does dissolved oxygen, depth, nitrates, sulfates, and temperature explain
#fish density?

#Predictors:
#five continuous IV or predictors: dissolved oxygen, depth, nitrates,
#sulfates, and temperature; and one continuous DV or response, fish density
#Response: Density (continous )


#Null Hypothesis
#H0: dissolved oxygen does not explain fish density
#H0: depth does not explain fish density
#H0: nitrates does not explain fish density
#H0: sulfates does not explain fish density
#H0: temperature does not explain fish density
#H0: dissolved oxygen does not interact with depth
#H0: dissolved oxygen does not interact with nitrates
#H0: dissolved oxygen does not interact with sulfates
#H0: dissolved oxygen does not interact with temperature
#H0: depth does not interact with nitrates
#H0: depth does not interact with sulfates
#H0: depth does not interact with temperature
#H0: nitrates do not interact with sulfates
#H0: nitrates do not interact with temperature
#H0: sulfates do not interact with temperature



attach(Longnose)
library(Matrix)
library(lme4)
library(carData)
library(car)

#Scatterplot
scatterplotMatrix(~fish_density+do2+depth+no3+so4+temp, diagonal=list(method= 'boxplot'))
#all predictors have a fairly linear relationship with the response
shapiro.test(fish_density) #H0: data is normal;#W = 0.90039, p-value = 0.0001749
#p<0.05, data is not normal and will need to do transformations
scatterplotMatrix(~log(fish_density)+do2+depth+no3+so4+temp)
shapiro.test(log(fish_density)) #H0: data is normal
#W = 0.89857, p-value = 0.0001506
#different transformation
scatterplotMatrix(~sqrt(fish_density)+do2+depth+no3+so4+temp)
shapiro.test(sqrt(fish_density)) #H0: data is normal
#W = 0.98004, p-value = 0.4535
#p>0.05, therefore data is normal and the normality assumption is met with sqrt

#transformation
scatterplotMatrix(~sqrt(fish_density)+do2+depth+no3+so4+temp)
#Linearity assumption is met
#Homogeneity of variances assumption is met because the cloud of data points
#does not expand or decrease in a funnel shape

#Test the Lack of Multicollinearity assumption
cols<-c(4,5,6,7,8)
cor(Longnose[,cols])
# do2 depth no3 so4 temp
#do2 1.00000000 -0.03491633 0.31517668 -0.07661177 -0.29808897
#depth -0.03491633 1.00000000 0.07931433 -0.00441695 -0.04695988
#no3 0.31517668 0.07931433 1.00000000 -0.23409365 -0.03962756
#so4 -0.07661177 -0.00441695 -0.23409365 1.00000000 0.13719171
#temp -0.29808897 -0.04695988 -0.03962756 0.13719171 1.00000000
#The predictor variables are not highly correlated (they are all less 0.5).

#Determine the variance inflation and their inverses (tolerances)
vif (lm(sqrt(fish_density)~do2+depth+no3+so4+temp))
# do2 depth no3 so4 temp
#1.231009 1.015415 1.189579 1.078871 1.127945
1/vif (lm(sqrt(fish_density) ~do2+depth+no3+ so4+temp))
# do2 depth no3 so4 temp
#0.8123414 0.9848193 0.8406336 0.9268953 0.8865682
#the variance inflation of all the predictors is <5, and their tolerance
# is >0.2, thus the multicollinearity assumption is met. Now , fit a
#multiplicative model.

mod1.lm <-lm(sqrt(fish_density)~do2+depth+no3+so4+temp+do2:depth+do2:no3+do2:so4+do2:temp+depth:no3+depth:so4+depth:temp+no3:so4+no3:temp+so4:temp)
summary (mod1.lm) # H0: Fish Density is not affected by the predictors
#Call:
#lm(formula = sqrt(fish_density) ~ do2 + depth + no3 + so4 + temp +
# do2:depth + do2:no3 + do2:so4 + do2:temp + depth:no3 + depth:so4 +
# depth:temp + no3:so4 + no3:temp + so4:temp)
#Residuals:
# Min 1Q Median 3Q Max
#-0.46265 -0.09753 -0.02295 0.08539 0.39637
#Coefficients:
# Estimate Std. Error t value Pr(>|t|)
#(Intercept) -1.555e+00 1.998e+00 -0.778 0.441
#do2 1.259e-01 1.864e-01 0.676 0.503
#depth 1.139e-02 1.205e-02 0.946 0.350
#no3 2.456e-01 3.407e-01 0.721 0.475
#so4 -5.350e-02 7.514e-02 -0.712 0.480
#temp 5.282e-02 8.092e-02 0.653 0.517
#do2:depth -1.069e-03 1.097e-03 -0.974 0.335
#do2:no3 -1.448e-02 2.260e-02 -0.641 0.525
#do2:so4 9.759e-03 7.706e-03 1.267 0.212
#do2:temp -1.702e-03 7.740e-03 -0.220 0.827
#depth:no3 6.424e-04 8.413e-04 0.764 0.449
#depth:so4 -1.162e-04 2.345e-04 -0.495 0.623
#depth:temp -2.015e-05 4.457e-04 -0.045 0.964
#no3:so4 -3.176e-03 3.694e-03 -0.860 0.395
#no3:temp -5.286e-03 8.731e-03 -0.605 0.548
#so4:temp -9.659e-04 1.949e-03 -0.496 0.623
#Residual standard error: 0.1994 on 42 degrees of freedom
#Multiple R-squared: 0.3951, Adjusted R-squared: 0.1791
#F-statistic: 1.829 on 15 and 42 DF, p-value: 0.06261

#Remove the interaction that was less significant (had the highest
#p-value) on the summary, and build a new model without the interaction. In this
#case, that is the interaction depth:temp with a P= 0.964

mod2.lm <-lm(sqrt(fish_density)~do2+depth+no3+so4+temp+do2:depth+do2:no3+do2:so4+do2:temp+depth:no3+depth:so4+no3:so4+no3:temp+so4:temp)
summary(mod2.lm)


mod3.lm <-lm(sqrt(fish_density)~do2+depth+no3+so4+temp+do2:depth+do2:no3+do2:so4+depth:no3+depth:so4+no3:so4+no3:temp+so4:temp)
summary(mod3.lm)


mod4.lm <-lm(sqrt(fish_density)~do2+depth+no3+so4+temp+do2:depth+do2:no3+do2:so4+depth:no3+depth:so4+no3:so4+no3:temp)

summary(mod4.lm)


mod5.lm <-lm(sqrt(fish_density)~do2+depth+no3+so4+temp+do2:depth+do2:no3+do2:so4+depth:no3+no3:so4+no3:temp)
summary(mod5.lm)


mod6.lm <-lm(sqrt(fish_density)~do2+depth+no3+so4+temp+do2:depth+do2:so4+depth:no3+no3:so4+no3:temp)
summary(mod6.lm)


mod7.lm <-lm(sqrt(fish_density)~do2+depth+no3+so4+temp+do2:depth+do2:so4+depth:no3+no3:so4)
summary(mod7.lm)


mod8.lm <-lm(sqrt(fish_density)~do2+depth+no3+so4+temp+do2:so4+depth:no3+no3:so4)
summary(mod8.lm)


mod9.lm <-lm(sqrt(fish_density)~do2+depth+no3+so4+temp+do2:so4+no3:so4)
summary(mod9.lm)


mod10.lm <-lm(sqrt(fish_density)~do2+depth+no3+so4+temp+do2:so4)
summary(mod10.lm)


mod11.lm <-lm(sqrt(fish_density)~do2+depth+no3+so4+temp)
summary(mod11.lm)

mod12.lm <-lm(sqrt(fish_density)~do2+depth+no3+temp)
summary(mod12.lm)

mod13.lm <-lm(sqrt(fish_density)~do2+depth+no3)
summary(mod13.lm)

mod14.lm <-lm(sqrt(fish_density)~do2+depth)
summary(mod14.lm)

# Call:
# lm(formula = sqrt(fish_density) ~ do2 + depth)
# Residuals:
# Min 1Q Median 3Q Max
# -0.42162 -0.12488 -0.00756 0.11241 0.41393
# Coefficients:
# Estimate Std. Error t value Pr(>|t|)
# (Intercept) -0.4233078 0.2229086 -1.899 0.062812 .
# do2 0.0920147 0.0240149 3.832 0.000329 ***
# depth 0.0017927 0.0008792 2.039 0.046263 *

---
  # Signif. codes: 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
  #Residual standard error: 0.194 on 55 degrees of freedom
  #Multiple R-squared: 0.2498, Adjusted R-squared: 0.2225
  #F-statistic: 9.158 on 2 and 55 DF, p-value: 0.0003691
  #The p-value in all the remaining variables are significant (p<0.05), thus the
#null hypothesis can be rejected.

avPlots (mod14.lm, ask = F)
detach(Longnose)

#Summary:Together the variables do2 and depth significantly affect density of
#fish (F 2,55= 9.158, p=0.0003691).
#do2 significantly affects the density of fish (t=3.832, p=0.000329)
#depth also significantly affects the density of fish (t=2.039, p=0.046263)
#all the other variables do not significantly affect the density of fish
#(all had p>0.05).

#The final model is:
#sqrt(Fish Density) = -0.4233078 + 0.0920147 * Dissolved Oxygen + 0.0017927 * Depth


#These predictors explain 24.98% of the variation in fish density (R2= 0.2498)