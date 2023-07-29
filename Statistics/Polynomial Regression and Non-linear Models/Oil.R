#Stocking Density and Yield in Carps

#Dataset: Oil.csv
#RQ: Does oil concentration affect dead area in corals?
  #1) How much dead area does 8ppm of oil causes?
  #2) What concentration of pollutant causes 50 cm2
    #of dead area on corals?

#Variables:
#two continuous variables, oil concentration and coral dead area. Oil
#concentration is a predictor (IV) and coral dead area is the response (DV)

#Hypothesis:
#H0: Oil concentration does not affect dead area in corals
#H1: Oil concentration does affect dead area in coral


#Simple Regression 
attach (Oil)
#Check parametric assumptions for Regression Analysis
#Scatter plot:
#install packages lme4 and car
library(lme4)
library(car)	
scatterplot(Concentration,DeadArea, smooth=F)# Concentration and DeadArea are the dependent and independent variables 
boxplot (DeadArea)
#response does not look normal but observation show some linearity

#Residuals plots
mod.lm<-lm(DeadArea~Concentration)
plot(mod.lm)

#residuals vs fitted show dispersion, not linear
#q-q plot show data ends trails away from line
#scale-location: not flat although points are between -4,4
#Assumation not met.

#Normality test
shapiro.test(DeadArea) #W = 0.77357, p-value = 0.0001123
#Data is not normal. Assumptions not met, transformation needed.

#Transformations
#scatterplot
scatterplot(log10(DeadArea+1)~log10(Concentration+1))
  #Data is not linear
mod.lm<-lm(log10(DeadArea+1)~log10(Concentration+1))
plot(mod.lm) #Residuals still not good

#Parametric Assumptions are not met because data is not linear

#Curvilinear Regression
scatterplot (DeadArea ~ Concentration, regLine = F, smooth=T)
#Relationship reaches a plateau, try different Non-linear Model and 
#select best fit

#Non-linear Model Selection using AIC
#Power: DV= a*IV^b
powermodel <- nls(DeadArea~a*Concentration^b, start=list(a=1,b=0.1))
plot(powermodel) #error
#Exponential: DV=a*exp(b*IV)
expmodel <- nls(DeadArea~a*exp(b*Concentration), start=list(a=1,b=0.1))
plot(expmodel)
#Asymptotic exponential: DV= Asym + (r0-Asym) * exp(-exp(lrc)*IV)
asymodel <- nls(DeadArea~SSasymp(Concentration,Asym,r0,lrc))
plot(asymodel)
#Michaelis-Menten: DV = (a*IV)/(b+IV)
micmodel <- nls(DeadArea~SSmicmen(Concentration,a,b))
plot(micmodel)#error
#Simple Logistic: DV = Asym/(1+exp((xmid-IV)/scal))
logismodel <- nls(DeadArea~SSlogis(Concentration,Asym,xmid,scal))
plot(logismodel)
#Weibull: DV= Asym – Drop * exp(-(exp(lrc)*IV^pwr))
weibmodel <- nls(DeadArea~SSweibull(Concentration, Asym, Drop, lrc, pwr))
plot(weibmodel)#error
#Von Bertalanffy growth function: DV=Linf*(1-exp(-k*(IV-t0)))
vbmodel <- nls(DeadArea~Linf*(1-exp(-k*(Concentration-t0))), start=list (Linf=45, k=0.5, t0=0.2)) #error
plot(vbmodel)#error
#Logarithmic: DV=a*log(IV)
logmodel <- nls(DeadArea~a*log(Concentration), start=list(a=1))
plot(logmodel)#error
#Four-parameter Logistic: DV=pAsym + ((nAsym-pAsym)/(1+exp((xmid-IV)/scal)))
fplmodel <- nls(DeadArea~SSfpl(Concentration,pAsym,nAsym,xmid,scal))
plot(fplmodel)
#Biexponential: DV= A1 * exp[-exp(lrc1)*IV]+ A2 * exp[-exp(lrc2)*IV]
biexpmodel <- nls(DeadArea~SSbiexp(Concentration, A1, lrc1, A2, lrc2))
plot(biexpmodel)#error
#Gompertz: DV= Asym *exp(-b2*b3^IV)
gmodel <- nls(DeadArea~SSgompertz(Concentration, Asym, b2, b3))
plot(gmodel)
AIC(expmodel,asymodel,logismodel,fplmodel,gmodel)
# df      AIC
# expmodel    3 221.4219
# asymodel    4 204.4499
# logismodel  4 179.9363
# fplmodel    5 168.1649
# gmodel      4 190.1821
#lowest aic: fplmodel

#Model Summary
summary(fplmodel)
# Formula: DeadArea ~ SSfpl(Concentration, pAsym, nAsym, xmid, scal)
# 
# Parameters:
#   Estimate Std. Error t value Pr(>|t|)    
# pAsym  12.7263     2.5224   5.045 6.19e-05 ***
#   nAsym  99.1847     3.5091  28.265  < 2e-16 ***
#   xmid    5.1567     0.4218  12.224 9.79e-11 ***
#   scal    0.8789     0.2954   2.976  0.00747 ** 
#   ---
#   Signif. codes:  
#   0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 7.152 on 20 degrees of freedom
# 
# Number of iterations to convergence: 0 
# Achieved convergence tolerance: 1.356e-06

# Plot
plot(DeadArea~Concentration,pch=16,axes=F,xlab='',ylab='')
axis(1,cex.axis=0.8)
mtext(text='Concentration', side=1,line=3)
axis(2,las=1)
mtext(text='Coral Dead Area',side=2,line=3)
box(bty='l')
Concentrationpred<-seq(min(Concentration),max(Concentration),l=1000)
points(Concentrationpred,predict(fplmodel,data.frame(Concentration=Concentrationpred)),type='l')


#Summary: 
#All the parameters have a p<0.05, therefore Oil concentration significantly 
#affects dead area in coral
#Coral Dead Area= 12.7263+((99.1847-12.7263)/(1+exp((5.1567-Oil Concentration)/0.8789))).

#Prediction:
#1) How much dead area does 8ppm of oil causes?
Concentrationpred <- c(8)
predict (fplmodel, data.frame (Concentration = Concentrationpred), interval='p')
# [1] 95.91024
# attr(,"gradient")
# pAsym     nAsym      xmid      scal
# [1,] 0.03787333 0.9621267 -3.584359 -11.59504
#8ppm of oil causes 95.91024 cm2 of coral dead area

#2) What concentration of pollutant causes 50 cm2 of dead area on corals?
Concentrationpred <-seq(min(Concentration),max(Concentration),l=1000)
DeadAreapred <- predict(fplmodel, data.frame (Concentration = Concentrationpred))
Query <- round(DeadAreapred,0)== c(50)
Concentrationpred[Query]
#[1] 4.900901 4.916917 4.932933
#A concentration of ~5ppm
detach(Oil)
