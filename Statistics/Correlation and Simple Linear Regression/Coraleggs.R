#Coral Egg Dataset Analysis

#Dataset: Coral_eggs.csv
#RQ: Do coral species with small egg sizes develop faster (i.e. does egg size 
#determines development time)?

#Variables:
#Egg size (Continuous/predictor) and Devo Time (Continuous/response)

#Hypothesis:
#H0: Egg size doesn't affect development time.
#H1: Egg size determines development time.

attach(coraleggs)
library(lme4)
library(car)

scatterplot(EggSize,DevTime, smooth=F)
scatterplot(EggSize,DevTime,smooth=F)
mod.lm<-lm(DevTime~EggSize)
plot(mod.lm)
par(mfrow=c(2,2))
#Fairly linear but check normality assumption.

#Confirm normality 
shapiro.test(DevTime)#W = 0.9336, p-value = 0.1811
shapiro.test(EggSize)#W = 0.95398, p-value = 0.4315
#Both are normal; assumption met.

#Ordinary Least Squares Regression (OLS)
mod.lm <- lm(DevTime~EggSize)

summary(mod.lm)
#Multiple R-squared: 0.7996, Egg Size (IV) explains nearly 80% of the
#variation of Development Time (DV) the dependent variable that is explained by
#the independent variable
#EggSize standard error: 0.007027
#Residual standard error: 4.062, df= 18
#96% confidence
#p-value= 1.069x10^-07
#coef.intercept <- 0.06695
#coef.EggSize <- 0.05955

#Plot
plot(DevTime~EggSize,pch=16,axes=F,xlab='',ylab='')
axis(1,cex.axis=0.8)
mtext(text='EggSize',side=1,line=3)
axis(2,las=1)
mtext(text='DevTime',side=2,line=3)
box(bty='l')
abline(mod.lm)
x <- seq (min(EggSize),max(EggSize),l=1000)
y <- predict (mod.lm,data.frame(EggSize=x),interval='c')
matlines(x,y,lty=2,col=1)
mtext(text='Development Time = 0.06695 + 0.05955 *EggSize, R2= 0.7996, p= 1.069x10^-07', side=3, line=1)

confint(mod.lm)
# 2.5 % 97.5 %
# (Intercept) -6.09509712 6.22900537
# EggSize 0.04478764 0.07431553
# 95% confidence intervals for the intercept and the coefficient of the EggSize
#variable in the linear regression model (mod.lm), suggesting that the true population values of these coefficients are likely to lie within the specified ranges with 95% confidence

#Using model for Preditions
predict (mod.lm, data.frame(EggSize=c(296.8)),interval= 'p')
# fit lwr upr
# 17.74186 8.87241 26.61132

predict (mod.lm, data.frame(EggSize=c(453.6)),interval= 'p')
# fit lwr upr
# 27.07955 18.29392 35.86518

#Larvae from Cyphastrea japonica, with egg size of 296.8 μm are estimated to
#develop in 17.7h; we have 97.5% confidence that the real development time will
#be in the interval [8.87241, 26.61132] h.
#Larvae from Favites stylifera with an eggs size of 296.8 μm are
#estimated to develop in 27.07h; we have 97.5% confidence that the real
#development time will be in the interval [18.29392, 35.86518] h.

detach(coraleggs)

#Summary:gg Size significantly influences the Development Time of Coral
# Eggs (F df1, df18= 71.81, p=1.069x10^-07). The Egg Size explains 79.96% of
#the variance of Development Time (R2= 0.7996). This effect can be expressed
#as: Development Time= 0.066954 + 0.059552*Egg Size




