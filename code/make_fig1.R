setwd("H:/")
load("ReadyNetworks.Rdata")

#library(ggthemes)
#library(scales)
#library(ggplot2)

library(statnet)

ideg_net <- degree(net,cmode="indegree")
ideg_netIC2 <- ideg_net[absentIC2==0]
ideg_netWget <- ideg_net[absentWget==0]
ideg_netT <- ideg_net[absentT==0]
odeg_net <- degree(net,cmode="outdegree")
odeg_netIC2 <- odeg_net[absentIC2==0]
odeg_netWget <- odeg_net[absentWget==0]
odeg_netT <- odeg_net[absentT==0]

ideg_IC2 <- degree(netIC2_temp,cmode="indegree")
ideg_IC2 <- ideg_IC2[absentIC2==0]
odeg_IC2 <- degree(netIC2_temp,cmode="outdegree")
odeg_IC2 <- odeg_IC2[absentIC2==0]

ideg_Wget <- degree(netWget_temp,cmode="indegree")
ideg_Wget <- ideg_Wget[absentWget==0]
odeg_Wget <- degree(netWget_temp,cmode="outdegree")
odeg_Wget <- odeg_Wget[absentWget==0]

ideg_TAll <- degree(netTAll_temp,cmode="indegree")
ideg_TAll <- ideg_TAll[absentT==0]
odeg_TAll <- degree(netTAll_temp,cmode="outdegree")
odeg_TAll <- odeg_TAll[absentT==0]

ideg_TNRT <- degree(netTNRT_temp,cmode="indegree")
ideg_TNRT <- ideg_TNRT[absentT==0]
odeg_TNRT <- degree(netTNRT_temp,cmode="outdegree")
odeg_TNRT <- odeg_TNRT[absentT==0]

ideg_hyper <- as.vector(c(ideg_IC2,ideg_Wget))
ideg_netHyper <- as.vector(c(ideg_netIC2,ideg_netWget))
ideg_twitter <- c(ideg_TAll,ideg_TNRT)
ideg_netTwitter <- c(ideg_netT,ideg_netT)

odeg_hyper <- as.vector(c(odeg_IC2,odeg_Wget))
odeg_netHyper <- as.vector(c(odeg_netIC2,odeg_netWget))
odeg_twitter <- c(odeg_TAll,odeg_TNRT)
odeg_netTwitter <- c(odeg_netT,odeg_netT)

LPIH <- predict(loess(ideg_hyper~ideg_netHyper), se=T)
LPIT <- predict(loess(ideg_twitter~ideg_netTwitter), se=T)

LPOH <- predict(loess(odeg_hyper~odeg_netHyper), se=T)
LPOT <- predict(loess(odeg_twitter~odeg_netTwitter), se=T)


hypercol <- colorblind_pal()(8)[2]
hypercola <- rgb(230, 159, 0, maxColorValue=255,alpha = 125)
twittercol <- colorblind_pal()(8)[6]
twittercola <- rgb(0, 114, 178, maxColorValue=255,alpha = 125)

png("fig1.png", width = 800, height =450)
par(mfrow=c(1, 2), mar = c(2,2,0,0),cex.axis=.8)
plot(x=jitter(ideg_netHyper,1.5),y=jitter(ideg_hyper,1.5),pch=20,col=hypercol,cex=.8,ylim=c(0,65),xlim=c(0,65),xaxs="i",yaxs="i", axes=FALSE,xlab="",ylab="")
axis(side=2,at=c(0,60),col="gray80",cex=.8)
axis(side=1,at=c(0,60),col="gray80",cex=.8)
lines(sort(ideg_netHyper),LPIH$fit[order(ideg_netHyper)], col=hypercol)
points(x=jitter(ideg_netTwitter,1.5),y=jitter(ideg_twitter,1.5),pch=20,col=twittercol,cex=.8)
lines(sort(ideg_netTwitter),LPIT$fit[order(ideg_netTwitter)], col=twittercol)
polygon(c(sort(ideg_netTwitter), rev(sort(ideg_netTwitter))), c(LPIT$fit[order(ideg_netTwitter)] + 2*LPIT$s[order(ideg_netTwitter)], rev(LPIT$fit[order(ideg_netTwitter)] - 2*LPIT$s[order(ideg_netTwitter)])),
        col = twittercola, border = NA)
polygon(c(sort(ideg_netHyper), rev(sort(ideg_netHyper))), c(LPIH$fit[order(ideg_netHyper)] + 2*LPIH$s[order(ideg_netHyper)], rev(LPIH$fit[order(ideg_netHyper)] - 2*LPIH$s[order(ideg_netHyper)])),
        col = hypercola, border = NA)
mtext("online network degree",side=2,cex=.8)
mtext("survey network in-degree",side=1,cex=.8)
legend("topleft",legend="in-degree centrality",bty="n",cex=.8)

par(mar = c(2,1,0,0))
plot(x=jitter(odeg_netHyper,1.5),y=jitter(odeg_hyper,1.5),pch=20,col=hypercol,cex=.8,ylim=c(0,65),xlim=c(0,65),xaxs="i",yaxs="i", axes=FALSE,xlab="",ylab="")
axis(side=2,at=c(0,60),col="gray80",labels=FALSE,cex=.8)
axis(side=1,at=c(0,60),col="gray80",cex=.8)
lines(sort(odeg_netHyper),LPOH$fit[order(odeg_netHyper)], col=hypercol)
points(x=jitter(odeg_netTwitter,1.5),y=jitter(odeg_twitter,1.5),pch=20,col=twittercol,cex=.8)
lines(sort(odeg_netTwitter),LPOT$fit[order(odeg_netTwitter)], col=twittercol)
polygon(c(sort(odeg_netTwitter), rev(sort(odeg_netTwitter))), c(LPOT$fit[order(odeg_netTwitter)] + 2*LPOT$s[order(odeg_netTwitter)], rev(LPOT$fit[order(odeg_netTwitter)] - 2*LPOT$s[order(odeg_netTwitter)])),
        col = twittercola, border = NA)
polygon(c(sort(odeg_netHyper), rev(sort(odeg_netHyper))), c(LPOH$fit[order(odeg_netHyper)] + 2*LPOH$s[order(odeg_netHyper)], rev(LPOH$fit[order(odeg_netHyper)] - 2*LPOH$s[order(odeg_netHyper)])),
        col = hypercola, border = NA)
mtext("survey network out-degree",side=1,cex=.8)
legend("topleft",legend="out-degree centrality",bty="n",cex=.8)
legend("topright", legend=c("Network Mode:","Hyperlink","Twitter"),
       text.col=c("black",hypercol,twittercol),cex=.8,bty="n",horiz=FALSE)
dev.off()
