# Generalized Additive Model

#Dataset: ITIS2.csv

#Research Question: Does the effect of depth on phytoplankton fluorescence vary between sample
#locations?

#Variables
#Response variable (DV): Fluorescence
#Explanatory variables (IV): Depth (continuous), Station (categorical)

#Model used: GAM to a univariate, normally-distributed DV and one continuous

#IV and one factorial IV

library(mgcv)

#same smoother across all levels of the factor
gam1<-gam(Fluorescence~s(Depth)+factor(Station),data = ITIS2)
#Then, I will fit the model using a different smoother for each level of the

#factor
gam2 <- gam (Fluorescence~s(Depth)+ s(Depth, by=factor(Station)) + factor(Station), data=ITIS2)
AIC(gam1,gam2)
# df AIC
#gam1 11.20937 285.854
#gam2 14.25486 234.152
# gam2 has the lowest AIC

summary(gam2)
#Family: gaussian
#Link function: identity
#Formula:
# Fluorescence ~ s(Depth) + s(Depth, by = factor(Station)) + factor(Station)
#Parametric coefficients:
# Estimate Std. Error t value Pr(>|t|)
#(Intercept) 14.2419 0.5750 24.770 < 2e-16 ***
# factor(Station)2 6.5471 0.8279 7.908 2.82e-09 ***
---
# Signif. codes: 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
  #Approximate significance of smooth terms:
  # edf Ref.df F p-value
  #s(Depth) 5.6725 6.5819 24.829 <2e-16 ***
  # s(Depth):factor(Station)1 0.6667 0.6667 7.526 0.0315 *
# s(Depth):factor(Station)2 4.9157 5.6961 14.393 <2e-16 ***
---
  # Signif. codes: 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
  #Rank: 28/29
  #R-sq.(adj) = 0.972 Deviance explained = 97.9%
  #GCV = 8.1065 Scale est. = 5.8679 n = 48
  
anova(gam2)
#Family: gaussian
#Link function: identity
#Formula:
# Fluorescence ~ s(Depth) + s(Depth, by = factor(Station)) + factor(Station)
#Parametric Terms:
# df F p-value
#factor(Station) 1 62.54 2.82e-09
#Approximate significance of smooth terms:
# edf Ref.df F p-value
#s(Depth) 5.6725 6.5819 24.829 <2e-16
#s(Depth):factor(Station)1 0.6667 0.6667 7.526 0.0315
#s(Depth):factor(Station)2 4.9157 5.6961 14.393 <2e-16

gam.check(gam2)
#Method: GCV Optimizer: magic
#Smoothing parameter selection converged after 18 iterations.
#The RMS GCV score gradient at convergence was 5.73154e-07 .
#The Hessian was positive definite.
#Model rank = 28 / 29
#Basis dimension (k) checking results. Low p-value (k-index<1) may
#indicate that k is too low, especially if edf is close to k'.

# k' edf k-index p-value
#s(Depth) 9.000 5.673 1.06 0.58
#s(Depth):factor(Station)1 9.000 0.667 1.06 0.64
#s(Depth):factor(Station)2 9.000 4.916 1.06 0.58

#Plot
plot(gam2)
new.data.Depth <- rep(seq(min(ITIS2$Depth),max(ITIS2$Depth)), length(unique(factor(ITIS2$Station)))[1])
new.data.Station <- c(rep("1", length(new.data.Depth)/2), rep("2", length(new.data.Depth)/2))
new.data <- as.data.frame(cbind(new.data.Depth, new.data.Station))
names(new.data) <- c(Depth, Station)
#make sure my continuous variable is numeric:
new.data$Depth<- as.numeric(as.character(new.data$Depth))
model.predict <- predict(gam2, newdata = new.data,type="response", se.fit=TRUE)
preds <- cbind(model.predict, new.data)
names(preds)
#separate the predicted values by the levels of the factorial variable 
#(Depth) tp plot separately
pred.1 <- subset(preds, preds$Station=="1")
pred.2 <- subset(preds, preds$Station=="2")
#separate the observed values to plot them separately 
dataset.1 <- subset(ITIS2, ITIS2$Station=="1")
dataset.2 <- subset(ITIS2, ITIS2$Station=="2")
#set up the data to plot error estimates

#plot the error associated with the predictions.. create a
#polygon
x <- c(pred.1$Depth, rev(pred.1$Depth))
y1 <- c(pred.1$fit+ pred.1$se.fit, rev(c(pred.1$fit- pred.1$se.fit)))
y2 <- c(pred.2$fit+ pred.2$se.fit, rev(c(pred.2$fit- pred.2$se.fit)))

#plot everything:
par(mfrow=c(1,1))
plot(fit~Depth, col="blue", data=pred.1, type="l", lwd=3,ylim=c(0, max(ITIS2$Fluorescence)))
points(fit~Depth, col="red", data=pred.2, type="l", lwd=3)
points(Fluorescence ~ Depth, col="blue", data= dataset.1, pch=20, cex=3)
points(Fluorescence ~ Depth, col="red", data= dataset.2, pch=20, cex=3)
legend("topright",legend=c(levels(factor(ITIS2$Station))[1], levels(factor(ITIS2$Station))[2]), fill=c("blue", "red"))
polygon(x, y1, density=NA, col=rgb(0.5, 0, 0, 0.2), border=NA)
polygon(x, y2, density=NA, col=rgb(0, 0, 0.5, 0.2), border=NA)

#Summary:
#Both predictors significantly affect the response (all p<0.05). Specifically,
#the Fluorescence is significantly affected by
#Depth (F 6.5819= 24.829, p<2x10^-16), and this relationship varies depending on
#the level of the Station (t=7.908, p=2.82x10^-9).
#The predictors explain 97.9% of the variation in the response (R2=0.972).