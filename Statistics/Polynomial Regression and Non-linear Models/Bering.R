#Fish Density Variation with Water Depth

#Dataset: Bering.csv
#RQ: How does fish length changes with age?

#Variables:
#Fish density (continuous/response) and Water depth (contiuous/predictor)

#Hypothesis:
#H0: Fish density does not change with water depth.
#H1: Fish density does change with water depth.

library(lme4)
library(car)
attach(Bering)

#Scatter/residual plots
scatterplot(Depth,FishDensity)
mod.lm<-lm(FishDensity~Depth)
plot(mod.lm)
#Scatterplot and residual plots do not show linearity. 

#Transformations
scatterplot(log10(FishDensity)~log10(Depth))
mod.lm<-lm(log10(FishDensity)~log10(Depth))
plot(mod.lm)
#Transformed data does not meet parametric assumptions.

#Curvilinear regression
scatterplot(FishDensity~Depth,regLine=F)
#Relationship has a plateau therefore non-linear models will be used.

#Non-linear models
powermodel <- nls(FishDensity~a*Depth^b, start=list(a=1,b=0.1))
expmodel <- nls(FishDensity~a*exp(b*Depth), start=list(a=1,b=0.1))
asymodel <- nls(FishDensity~SSasymp(Depth,Asym,r0,lrc))
micmodel <- nls(FishDensity~SSmicmen(Depth,a,b))
logismodel <- nls(FishDensity~SSlogis(Depth,Asym,xmid,scal))
weibmodel <- nls(FishDensity~SSweibull(Depth, Asym, Drop, lrc, pwr))
vbmodel <- nls(FishDensity~Linf*(1-exp(-k*(Depth-t0))), start=list
               (Linf=45, k=0.5, t0=0.2))
logmodel <- nls(FishDensity~a*log(Depth), start=list(a=1))
fplmodel <- nls(FishDensity~SSfpl(Depth,pAsym,nAsym,xmid,scal))
biexpmodel <- nls(FishDensity~SSbiexp(Depth, A1, lrc1, A2, lrc2))
gmodel <- nls(FishDensity~SSgompertz(Depth, Asym, b2, b3))
AIC(powermodel, micmodel, logismodel,logmodel, fplmodel)
#Model with lowest AIC is logismodel.
#  df       AIC
#powermodel  3  91.77953
#micmodel    3  94.94343
#logismodel  4  38.50803
#logmodel    2 104.75621 lowest aic
#fplmodel    5  40.21437

#Summary
summary(logismodel)
# Formula: FishDensity ~ SSlogis(Depth, Asym, xmid, scal)
# 
# Parameters:
#   Estimate Std. Error t value Pr(>|t|)    
# Asym    3.3630     0.1848  18.196 9.51e-15 ***
#   xmid 1019.8568    43.7996  23.285  < 2e-16 ***
#   scal -115.6797    25.0726  -4.614 0.000135 ***
#   ---
#   Signif. codes:  
#   0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.4748 on 22 degrees of freedom
# 
# Number of iterations to convergence: 1 
# Achieved convergence tolerance: 3.586e-06

#Plot
plot(FishDensity~Depth,pch=16,axes=F,xlab='Depth',ylab='Fish density')
axis(1,cex.axis=0.8)
mtext(text='Depth', side=1,line=3)
axis(2,las=1)
mtext(text='Fish Density',side=2,line=3)
box(bty='l')
IVpred<-seq(min(Depth),max(Depth),l=1000)
points(IVpred,predict(logismodel,data.frame(Depth=IVpred)),type='l')

#The equation that best fits the relation between depth and fish density
#is : Fish density = 3.360/(1+exp((1019.8568-Depth)/-115.6797)).
#All parameters of the model have a p<0.05, thus we conclude that depth 
#significantly affects fish density.

#Predict
#What is the predicted fish density at a depth of 800m?
IVpred <- c(800)
predict (logismodel, data.frame (Depth = IVpred), interval='p')
#It is predicted that at 800m in depth the fish density will be 2.925687. 
detach(Bering)
