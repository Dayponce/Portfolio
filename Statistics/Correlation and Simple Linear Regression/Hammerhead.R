#Hammerhead Shark Dataset Analysis

#Dataset: Hammerhead.csv
#RQ: How does the maximum narial distance of hammerhead sharks relates to the height
#of their caudal fin?

#Variables:
#Maximum narial distance of hammerhead (continuous) and Caudal fin height (continuous).

#Hypothesis:
#H0: Narial distance does not relate to the height of the hammerheads caudal fin.
#H1: Narial distance and height of caudal fin are correlated.

attach(hammerhead)
library(lme4)
library(car)

#Exploring data
scatterplot(NarialDistance,CaudalHeight)
#Data is linear; assumption met

#Shapiro-Wilks test
shapiro.test(NarialDistance) #W = 0.98583, p-value = 0.8066
shapiro.test(CaudalHeight) # = 0.98262, p-value = 0.6663
#Data is normal; assumption met

cor.test(NarialDistance,CaudalHeight)
#data: NarialDistance and CaudalHeight
#t = 8.7736, df = 48, p-value = 1.531e-11
#alternative hypothesis: true correlation is not equal to 0
#95 percent confidence interval:
# 0.6480205 0.8725483
#sample estimates:
# cor 0.7848084

#p-value= 1.531x10^-11, the variables are significantly correlated
#r= 0.7848084,  variables are highly directly correlated


#Plot
lm(CaudalHeight~NarialDistance)
#coef.intercept<- 4.9304
#coef.NarialDistance<- 0.5614
plot(CaudalHeight~NarialDistance,pch=16,axes=F,xlab='',ylab='')
axis(1,cex.axis=0.8)
mtext(text='Narial Distance',side=1,line=3)
axis(2,las=1)
mtext(text='Caudal Height',side=2,line=3)
box(bty='l')
abline(lm(CaudalHeight~NarialDistance))
x <- seq (min(NarialDistance),max(NarialDistance),l=1000)
y <- predict (lm(CaudalHeight~NarialDistance),data.frame(NarialDistance=x),interval='c')
matlines(x,y,lty=2,col=1)
mtext(text='Caudal Height= 4.9304 + 0.5614 *Narial Distance, r = 0.7848084' , side=3, line=1)
detach(hammerhead)

#Summary:There is a relationship between maximum narial distance of
#hammerhead and the height of their caudal finThe variables Caudal Height and Narial Distance are significantly
#positively correlated (t48= 8.7736, p= 1.531x10^-11, r= 0.7848084. The equation
#that best describes their relationship is
#Caudal Height= 4.9304 + 0.5614 *Narial Distance, r = 0.7848084