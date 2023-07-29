#Relationship Between Fish Length and Age

#Dataset: Snapper.csv
#RQ: How does fish length changes with age?

#Variables:
#Fish length (continous/response) and Age(continous/predictor)

#Hypothesis:
#H0: Fish Length does not change with age
#H1: Fish length does change with age.

library(lme4)
library(car)
attach(Snapper)

scatterplot(Age,Length,smooth = F)
mod.lm<-lm(Length~Age)
plot(mod.lm)
#Scatterplot shows that trendline underestimates most of the data and over 
#estimates first and last data points. Linearity assumption not met.

#Transformation
scatterplot(log10(Length)~log10(Age), smooth=F)
mod.lm2<-lm(log10(Length)~log10(Age), smooth=F)
plot(mod.lm2)
return
return
return
return
#Data is not linear, scatterplot assumptions still not met. Length boxplot is 
#negatively skewed.
#Residualvs fitted shows curviture.

#Curvilinear Regression
scatterplot(Length~Age,regLine=F)
powermodel<-nls(Length~a*Age^b, start=list(a=1,b=0.1))
expmodel <- nls(Length~a*exp(b*Age), start=list(a=1,b=0.1))
asymodel <- nls(Length~SSasymp(Age,Asym,r0,lrc))
micmodel <- nls(Length~SSmicmen(Age,a,b)) 
logismodel <- nls(Length~SSlogis(Age,Asym,xmid,scal))
weibmodel <- nls(Length~SSweibull(Age, Asym, Drop, lrc, pwr)) 
vbmodel <- nls(Length~Linf*(1-exp(-k*(Age-t0))), start=list
               (Linf=45, k=0.5, t0=0.2))
logmodel <- nls(Length~a*log(Age), start=list(a=1))
fplmodel <- nls(Length~SSfpl(Age,pAsym,nAsym,xmid,scal))
biexpmodel <- nls(Length~SSbiexp(Age, A1, lrc1, A2, lrc2))
gmodel <- nls(Length~SSgompertz(Age, Asym, b2, b3)) 
AIC(powermodel, expmodel, asymodel, micmodel, logismodel,
    weibmodel, vbmodel, logmodel, gmodel)
#Lowest AIC is vbmodel and asymodel (same AIC of 92.79162)

summary(vbmodel)
#Parameters:
#Estimate Std. Error t value Pr(>|t|)    
#Linf 42.32036    2.04009  20.744 1.86e-12 ***
# k     0.43517    0.08408   5.176 0.000113 ***
#t0    0.31995    0.18580   1.722 0.105621    
---
  #Signif. codes:  
  #0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
  #Residual standard error: 2.794 on 15 degrees of freedom
  #Number of iterations to convergence: 3 
  #Achieved convergence tolerance: 2.735e-07
  
detach(Snapper)

#Summary
#The equation that best fits the relation between fish length and age is: 
#Length=42.3204+(-6.3223-42.3204)*exp(-exp(-0.8320)*Age)

#Most parameters of the model have a p<0.05, this we conclude that age 
#significantly affects coral mortality.

