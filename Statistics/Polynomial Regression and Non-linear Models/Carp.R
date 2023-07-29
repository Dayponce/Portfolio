#Stocking Density and Yield in Carps

#Dataset: Carp.csv
#RQ: #How does stocking density affects Yield? 

#Variables:
#Stock density (continuous/predictor) and Yield (continuous/response)

#Hypothesis:
#H0: Stock density does not affect yield.
#H1: Stock density does not affect yield.

library(lme4)
library(car)
attach(Carp)

#Scatterplot
scatterplot(SD, Yield)
mod.lm<-lm(Yield~SD)
plot(mod.lm)
#Scatterplot: Data is not linear and has a peak. Yield box plot appears normal but stock 
#density is positively skewed.
#Residual plots: Trend line is not flat and normal q-q plot does not look normal.
#Assumptions not met.

#Transformation
scatterplot(log10(Yield)~log10(SD))
mod.lm2<-lm(log10(Yield)~log10(SD))
plot(mod.lm2)
#Parametric assumptions are not met.
scatterplot(sqrt(Yield)~sqrt(SD))
mod.lm<-lm(sqrt(Yield)~sqrt(SD))
plot(mod.lm)
#Parametric assumptions are not met.

#Curvilinear Regression
scatterplot (Yield ~SD, regLine = F) 
#Relationship does not plateau but peak is present.

#Polynomial Regression
#3rd order
mod.lm3<- lm (Yield ~ poly (SD, 3, raw=T))
#2nd order
mod.lm4 <- lm (Yield ~ poly (SD, 2, raw=T))
anova(mod.lm3, mod.lm4) #H0: models are equal
# Analysis of Variance Table
# Model 1: Yield ~ poly(SD, 3, raw = T)
# Model 2: Yield ~ poly(SD, 2, raw = T)
# Res.Df    RSS Df Sum of Sq      F Pr(>F)
# 1     15 295859                           
# 2     16 297561 -1   -1701.5 0.0863  0.773
#P-value is 0.773 (>0.05). 
#The F-statistic of 0.0863 indicates that the difference between the models'
#performance is not statistically significant, as the p-value (0.773) is 
#greater than the commonly used significance level of 0.05. Therefore, the 
#simpler Model 2 (degree 2 polynomial) may be preferred over Model 1.

#Model Summary
summary(mod.lm2)
# Call:
#   lm(formula = log10(Yield) ~ log10(SD))
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -0.23362 -0.09412 -0.00397  0.07193  0.24963 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)
# (Intercept)  -0.1214     0.4853  -0.250    0.805
# log10(SD)     0.8113     0.1409   5.759 2.31e-05
# 
# (Intercept)    
# log10(SD)   ***
#   ---
#   Signif. codes:  
#   0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.1324 on 17 degrees of freedom
# Multiple R-squared:  0.6611,	Adjusted R-squared:  0.6412 
# F-statistic: 33.16 on 1 and 17 DF,  p-value: 2.315e-05

#Plot
plot(Yield~SD,pch=16,axes=F,xlab='Stocking denisty',ylab='Yield')
axis(1,cex.axis=0.8)
mtext(text='Stocking Density', side=1,line=3)
axis(2,las=1)
mtext(text='Yield',side=2,line=3)
box(bty='l')
summary(mod.lm4)
IVpred<-seq(min(SD),max(SD),l=1000)
points(IVpred,predict(mod.lm4,data.frame(SD=IVpred)),type='l')

#Summary
#The stocking density significantly affects the yield of carp
#(F2,16=18.46, P=6.983x10^-05), specifically 65.99% of the variation in the 
#yield is explained by the stock density (R2=0.6599). The model that best 
#explain their relationship is Yield= − 1.844 +  5.008-( -4.052*Stock density^2 )

#Predictions
#What is the stocking density that optimizes (maximizes) fishing yield of
#carps?
min(SD) #1056
max(SD) #7578
yield.function<-function(c){-2.648e02+4.079e-01*c+3.926e-05*c}
optimize(yield.function,interval = c(1056,7578), maximum= TRUE)
#$maximum
#[1] 7578
#$objective
#[1] 2826.564
#The stocking density that optimizes (maximizes) fishing yield of carps is
#2826.564
detach(Carp)
