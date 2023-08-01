# ITIS2.csv

#RQ:Does fluorescence changes with depth?
#RQ: Does the effect of depth on phytoplankton fluorescence vary between sample locations? 


#Flourescence: response continuous
#Depth: predictor continuous
#Station: predictor categorical

#Since this is a continuation fromt he previous exercise we already know this is a GAM

#H0: fluorescence does not change with depth
#H0: Fluorescence does not change between locations
#H0: Station and depth do not interact
#H1: fluorescence changes with depth
#H1: Fluorescence changes between locations
#H1: Station and depth interact
detach(ITIS2)
#install.packages("mgcv")
library(mgcv)

## Fit the candidate models:
gam1 <- gam(Fluorescence~s(Depth)+factor(Station), data=ITIS2)

gam2 <- gam(Fluorescence~s(Depth)+s(Depth, by=factor(Station))+factor(Station), data=ITIS2)

AIC(gam1, gam2)     ## AIC suggests that gam2 is the better fit, because it has a much lower AIC score

summary(gam2)

## The summary tells us that:
## 1. Fluorescence at factor(Station)2 is significantly different (higher, because the Estimate is positive) 
##    to the reference level (station1): p = 2.82e-09

## 2. There is a significant overall effect of depth (s(Depth)) on Fluorescence (p < 2e-16)
## 3. Station 1 is significantly different to the mean smoother (at p = 0.0315), but the effect is marginal. 
##    Because the p-value in this case is close to 0.05 and the edf of the smoother is close to linear, it's
##    the pattern at Station 1 may not be meaningfully different to the overall smoother. We should
##    be cautious here.
## 4. Station 2 is significantly different to the mean smoother (at p = 2.46e-09)
## 5. gam2 is a very good fit to the data, and explains 97.2% (adj R-sq) of the observed variance (deviance) 
##    in the data.

## Check the residuals to see if we can trust the model:
par(mfrow=c(2,2), mar=c(4,4,1,1))   ## Optional but convenient

gam.check(gam2) ## This looks better than before. Residuals are smaller. There are still a couple of outlying points that might,
## be worth checking in more detail, but overall there's not much else to worry about.

## Plot the fitted smoothers:
par(mfrow=c(3,1))  ## Optional but convenient
plot(gam2) 

###########################################
## Summary plot of the best-fitting model
###########################################

## Create new data to predict against:

## Repeats a sequence of depths from the minimum depth recorded to the maximum, then repeats it for
## the number of levels we have in our factor. In this case, we have 2 stations, so the depths are 
## repeated twice:
new.data.depth <- rep(seq(min(ITIS2$Depth),max(ITIS2$Depth)), 
                      length(unique(factor(ITIS2$Station)))[1])  

## We make a list of Station numbers that corresponds to the depth sequences...
new.data.station <- c(rep("1", length(new.data.depth)/2), rep("2", length(new.data.depth)/2)) 

## Then we combine them in a data frame:
new.data <- as.data.frame(cbind(new.data.depth, new.data.station))
names(new.data) ## OPTIONAL: As you can see at this point, the column names are the same as the objects that we 
## just made. However, since we want to use them in predictions, we have to rename the
## columns to be EXACTLY the same as the names of the IVs used in our selected model (gam2)

## So we rename the columns:
names(new.data) <- c("Depth", "Station") 

## Make sure your continuous variable is numeric:
new.data$Depth<-  as.numeric(as.character(new.data$Depth))  

model.predict <- predict(gam2, newdata = new.data, type="response",  se.fit=TRUE)

preds <- cbind(model.predict, new.data)
names(preds)

##############################

## Separate the predicted values by our factorial variable (Station) so we
## can plot them separately:

pred.1 <- subset(preds, preds$Station=="1")
pred.2 <- subset(preds, preds$Station=="2")

## Separate the original data by our factorial variable so we can plot
## them separately too:

dataset.1 <- subset(ITIS2, ITIS2$Station=="1")
dataset.2 <- subset(ITIS2, ITIS2$Station=="2")

##############################

## If we want to plot the error associated with the predictions we can do it 
## by creating a polygon. In R, we draw polygons by following the x-axis in one
## direction for the lower edge, then following the x-axis backwards to draw the 
## upper edge.

x <- c(pred.1$Depth, rev(pred.1$Depth))
y1 <- c(pred.1$fit+pred.1$se.fit, rev(c(pred.1$fit-pred.1$se.fit)))
y2 <- c(pred.2$fit+pred.2$se.fit, rev(c(pred.2$fit-pred.2$se.fit)))

#############################################
## Bringing everything together in one plot:
#############################################

par(mfrow=c(1,1))
plot(fit~Depth, col="blue", data=pred.1, type="l", lwd=3, 
     ylim=c(0, max(ITIS2$Fluorescence)))

points(fit~ Depth, col="red", data=pred.2, type="l", lwd=3)

points(Fluorescence ~ Depth, col="blue", data= dataset.1, pch=20, cex=3)
points(Fluorescence ~ Depth, col="red", data= dataset.2, pch=20, cex=3)
legend("topright",legend=c(levels(factor(ITIS2$Station))[1], levels(factor(ITIS2$Station))[2]), fill=c("blue", "red"))

polygon(x, y1, density=NA,  col=rgb(0, 0, 0.5, 0.2), border=NA) 
polygon(x, y2, density=NA,  col=rgb(0.5, 0, 0, 0.2), border=NA)

###############################

# Summary: Both predictors significantly affect the response (all p<0.05). 
#Specifically, Fluoresce is significantly affected by the continuous Depth (p<2x10-16,F6.5819=24.829), 
#and this relationship varies depending on the level of the categorical IV (p=2.82x10-9, t=7.908). 
#The predictors explain 97.9% of the variation in the response (R2=0.972).

