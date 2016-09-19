
library(ggthemes)
library(scales)
library(ggplot2)

base_prob <- seq(from=0, to=1, by=0.001)
log_odds_base <- log(base_prob/(1-base_prob))
#est. coefficient on survey tie parameter for each model
hyperB <- 2.21
hyperF <- 1.55
twitterB <- 1.63
twitterF <- 0.92
#translate baseline odds without survey tie to est. odds with survey tie
hyperB_odds <- exp(log_odds_base+hyperB)/(1+exp(log_odds_base + hyperB))
twitterB_odds <- exp(log_odds_base+twitterB)/(1+exp(log_odds_base + twitterB))
hyperF_odds <- exp(log_odds_base+hyperF)/(1+exp(log_odds_base + hyperF))
twitterF_odds <- exp(log_odds_base+twitterF)/(1+exp(log_odds_base + twitterF))

hypercol <- colorblind_pal()(8)[2]
twittercol <- colorblind_pal()(8)[6]

#create plot
png("survey_margeffect.png", width = 600, height =450)
plot(y=hyperB_odds,x=base_prob,type="l",xaxs="i",yaxs="i",axes=FALSE,ylab="",xlab="",ylim=c(0,1),xlim=c(0,1),col=hypercol,lty=2)
axis(side=2,at=c(.25,.5,.75,1),col="gray80")
axis(side=1,at=c(0,.25,.5,.75,1),col="gray80")
mtext("Estimate probability of online tie (survey tie=1)",side=2,line=2)
mtext("Probability of online tie (survey tie=0)",side=1,line=2)
lines(y=twitterB_odds,x=base_prob,lty=2,col=twittercol)
lines(y=hyperF_odds,x=base_prob,col=hypercol)
lines(y=twitterF_odds,x=base_prob,col=twittercol)
abline(a=0,b=1)
text(x=.12,y=.096,labels=45~degree*" line",col="gray50",srt=37,cex=.8)
legend("bottomright", bty="n",
       legend=c("Network Mode","Hyper(Base)","Twitter(Base)","Hyper(Full)","Twitter(Full)"), 
       lty=c(0,2,2,1,1),col=c("black",hypercol,twittercol,hypercol,twittercol),
       text.col=c("black",hypercol,twittercol,hypercol,twittercol))
dev.off()
