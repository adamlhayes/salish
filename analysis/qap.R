setwd("C:/Users/alhayes/Desktop/salish/analysis")

require(statnet)
require(sna)

load("NetworkReady.RData")
load("net_twitter_mat.RData")
load("twitter_all.RData")
load("twitter_NoRT.RData")
load("hyperlinksICL2.RData")
load("netHypIC2.RData")

#matched twitter_hyperlink matrix
vertex_match <- match(network.vertex.names(hypIC2), network.vertex.names(twitter_all), nomatch=999)
missingNode <- c()
for (i in 1:length(vertex_match)){
  if (vertex_match[i] == 999){
    missingNode <- c(missingNode, i)
  }
}
hyp2IC_twitter <- as.matrix(hypIC2)
hyp2IC_twitter <- hyp2IC_twitter[-c(missingNode),]
hyp2IC_twitter <- hyp2IC_twitter[,-c(missingNode)]

vertex_match <- match(network.vertex.names(twitter_all), network.vertex.names(hypIC2), nomatch=999)
missingNode <- c()
for (i in 1:length(vertex_match)){
  if (vertex_match[i] == 999){
    missingNode <- c(missingNode, i)
  }
}
twitterAll_hypIC2 <- as.matrix(twitter_all)
twitterAll_hypIC2 <- twitterAll_hypIC2[-c(missingNode),]
twitterAll_hypIC2 <- twitterAll_hypIC2[,-c(missingNode)]
twitterNoRT_hypIC2 <- as.matrix(twitter_NoRT)
twitterNoRT_hypIC2 <- twitterNoRT_hypIC2[-c(missingNode),]
twitterNoRT_hypIC2 <- twitterNoRT_hypIC2[,-c(missingNode)]

#QAP Survey_hyperlink
mat.net_hypIC2 <- array(dim=c(2, 186, 186))
mat.net_hypIC2[1,,] <- as.matrix(net_hypIC2)
mat.net_hypIC2[2,,] <- as.matrix(hypIC2)
q.net_hypIC2 <- qaptest(mat.net_hypIC2, gcor, g1=1, g2=2)
summary(q.net_hypIC2)

#QAP Survey_twitterAll
mat.net_twitterAll <- array(dim=c(2, 121, 121))
mat.net_twitterAll[1,,] <- as.matrix(net_twitter_mat)
mat.net_twitterAll[2,,] <- as.matrix(twitter_all)
q.net_twitterAll <- qaptest(mat.net_twitterAll, gcor, g1=1, g2=2)
summary(q.net_twitterAll)

#QAP Survey_twitterNoRT
mat.net_twitterNoRT <- array(dim=c(2, 121, 121))
mat.net_twitterNoRT[1,,] <- as.matrix(net_twitter_mat)
mat.net_twitterNoRT[2,,] <- as.matrix(twitter_NoRT)
q.net_twitterNoRT <- qaptest(mat.net_twitterNoRT, gcor, g1=1, g2=2)
summary(q.net_twitterNoRT)
plot(q.net_twitterNoRT)

#matched twitter and hyperlink nodes
mat.hypIC2_twitterAll <- array(dim=c(2, 115, 115))
mat.hypIC2_twitterAll[1,,] <- as.matrix(hyp2IC_twitter)
mat.hypIC2_twitterAll[2,,] <- as.matrix(twitterAll_hypIC2)
q.hypIC2_twitterAll <- qaptest(mat.hypIC2_twitterAll, gcor, g1=1, g2=2)
summary(q.hypIC2_twitterAll)

mat.hypIC2_twitterNoRT <- array(dim=c(2, 115, 115))
mat.hypIC2_twitterNoRT[1,,] <- as.matrix(hyp2IC_twitter)
mat.hypIC2_twitterNoRT[2,,] <- as.matrix(twitterNoRT_hypIC2)
q.hypIC2_twitterNoRT <- qaptest(mat.hypIC2_twitterNoRT, gcor, g1=1, g2=2)
summary(q.hypIC2_twitterNoRT)

#twitter matrices
mat.twitterAll_twitterNoRT <- array(dim=c(2, 121, 121))
mat.twitterAll_twitterNoRT[1,,] <- as.matrix(twitter_all)
mat.twitterAll_twitterNoRT[2,,] <- as.matrix(twitter_NoRT)
q.twitterAll_twitterNoRT <- qaptest(mat.twitterAll_twitterNoRT, gcor, g1=1, g2=2)
summary(q.twitterAll_twitterNoRT)


full<-array(dim=c(2,221,221))
full[1,,]<-as.matrix(net)
full[2,,]<-as.matrix(twitterMX)
q.full<-qaptest(full,gcor, g1=1, g2=1)

sub<-array(dim=c(2,121, 121))
sub[1,,] <- as.matrix(net_twittersub)
sub[2,,] <- as.matrix(twitterM)
q.sub<-qaptest(sub,gcor, g1=1, g2=2)
q.sub<-qaptest(sub,gcor, g1=1, g2=2)


#triad.census(net, mode = "digraph")
#sum(triad.census(net, mode = "digraph"))
net.triads <- triad.census(net, mode = "digraph")[-1]/sum(triad.census(net, mode = "digraph")[-1])
twitter_NoRT.triads <- triad.census(twitter_NoRT, mode = "digraph")[-1]/sum(triad.census(twitter_NoRT, mode = "digraph")[-1])
twitter_all.triads <- triad.census(twitter_all, mode = "digraph")[-1]/sum(triad.census(twitter_all, mode = "digraph")[-1])
hypIC2.triads <- triad.census(hypIC2, mode = "digraph")[-1]/sum(triad.census(hypIC2, mode = "digraph")[-1])

plot(net.triads, pch = 20)
points(twitter_NoRT.triads, col = "cyan", pch = 20)
points(twitter_all.triads, col = "darkblue", pch = 20)
points(hypIC2.triads, col = "green", pch = 20)
