#install.packages("statnet")

require(statnet)

#Previous data from Tyler's elwha
load("NetworkReady.RData")

#Read in data
edgesTAll <- read.csv("edgelist_All_valued.csv", header = FALSE)
edgesTNRT <- read.csv("edgelist_NoRT_valued.csv", header = FALSE)
countTAll <- read.csv("mentions_count_all.csv", header = FALSE)
countTNRT <- read.csv("twitterNoRT_nodes.csv", header = FALSE)
namesT <- as.vector(countTNRT[,1])
edgesIC2 <- read.csv("edgelist_ICL2_val.csv", header = FALSE)
countIC2 <- read.csv("icl2_nodes.csv", header = FALSE)
namesIC2 <- countIC2[,2]
edgesWget <- read.csv("hyperlinks_wget_valued.csv", header = FALSE)
countWget <- read.csv("seeds.csv", header = FALSE)
namesWget <- as.vector(countWget[,2])


#Create networks
online_temp <- network.initialize(length(network.vertex.names(net)),
                                      directed=TRUE,loops=FALSE, bipartite = FALSE)
network.vertex.names(online_temp) <- network.vertex.names(net)


#set vertex attributes
OrgType <- get.vertex.attribute(net, "ORGTYPE")
orgs_agg <- OrgType
orgs_agg[orgs_agg == "Consulting"
           | orgs_agg == "Federal_Agency"
           | orgs_agg == "Local_Advocacy"
           | orgs_agg == "Local_Commission"
           | orgs_agg == "Local_Outreach/Ed"
           | orgs_agg == "NGO"
           | orgs_agg == "NR_Industry"
           | orgs_agg == "Parks_Reserves"
           | orgs_agg == "Regional_Advocacy"
           | orgs_agg == "Regional_Commission"
           | orgs_agg == "Tribe"] <- "a"
orgs_agg[orgs_agg == "City_Gov"
         | orgs_agg == "County_Gov"
         | orgs_agg == "Special_District"] <- "Local_Gov"
set.vertex.attribute(online_temp, "OrgType", OrgType)
set.vertex.attribute(online_temp, "OrgType_Agg", orgs_agg)
set.vertex.attribute(net, "OrgType_Agg", orgs_agg)

#Twitter nodal covariate
netT_temp <- online_temp
absentT <- match(network.vertex.names(online_temp), namesT, nomatch=999)
absentT[absentT<999] <- 0
absentT[absentT==999] <- 1
set.vertex.attribute(netT_temp, "absent", absentT)

#Twitter(All) network edges & node covariates
netTAll_temp <- netT_temp
edge_temp <- edgesTAll
TAIL_ID <- match(edge_temp[,1],network.vertex.names(netTAll_temp))
HEAD_ID <- match(edge_temp[,2],network.vertex.names(netTAll_temp))
for (j in 1:length(TAIL_ID)) {
  netTAll_temp[TAIL_ID[j],HEAD_ID[j]]<-1
}
#Add node covariate for number of Tweets+Retweets
NumTweetsAll <- rep(0, length(network.vertex.names(netTAll_temp)))
name_match <- match(countTAll[,1], network.vertex.names(netTAll_temp))
NumTweetsAll[name_match] <- countTAll[, 4]
set.vertex.attribute(netTAll_temp, "NumTweets", NumTweetsAll)
#Create matrix of missing nodes
absentTAll_mat <- as.matrix(online_temp)
absentTAll_mat[absentT==1,] <- 1
absentTAll_mat[,absentT==1] <- 1

###Twitter NoRT edges
netTNRT_temp <- netT_temp
edge_temp <- edgesTNRT
TAIL_ID <- match(edge_temp[,1],network.vertex.names(netTNRT_temp))
HEAD_ID <- match(edge_temp[,2],network.vertex.names(netTNRT_temp))
for (j in 1:length(TAIL_ID)) {
  netTNRT_temp[TAIL_ID[j],HEAD_ID[j]]<-1
}
#Add node covariate for number of Tweets
NumTweetsNRT <- rep(0, length(network.vertex.names(netTNRT_temp)))
name_match <- match(countTNRT[,1], network.vertex.names(netTNRT_temp))
NumTweetsNRT[name_match] <- countTNRT[, 3]
set.vertex.attribute(netTNRT_temp, "NumTweets", NumTweetsNRT)
#Create matrix of missing nodes
absentTNRT_mat <- as.matrix(online_temp)
absentTNRT_mat[absentT==1,] <- 1
absentTNRT_mat[,absentT==1] <- 1

###Hyperlink issuecrawler edges
netIC2_temp <- online_temp
edge_temp <- edgesIC2
TAIL_ID <- match(edge_temp[,1],network.vertex.names(netIC2_temp))
HEAD_ID <- match(edge_temp[,2],network.vertex.names(netIC2_temp))
for (j in 1:length(TAIL_ID)) {
  netIC2_temp[TAIL_ID[j],HEAD_ID[j]]<-1
}
#Add node covariate for number of webpages
NumPagesIC2 <- rep(0, length(network.vertex.names(netIC2_temp)))
name_match <- match(countIC2[,2], network.vertex.names(netIC2_temp))
NumPagesIC2[name_match] <- countIC2[,3]
set.vertex.attribute(netIC2_temp, "NumPages", NumPagesIC2)
absentIC2 <- match(network.vertex.names(netIC2_temp), namesIC2, nomatch=999)
absentIC2[absentIC2<999] <- 0
absentIC2[absentIC2==999] <- 1
set.vertex.attribute(netIC2_temp, "absent", absentIC2)
absentIC2_mat <- as.matrix(online_temp)
absentIC2_mat[absentIC2==1,] <- 1
absentIC2_mat[,absentIC2==1] <- 1

###Hyperlink wget edges
netWget_temp <- online_temp
edge_temp <- edgesWget
TAIL_ID <- match(edge_temp[,1],network.vertex.names(netWget_temp))
HEAD_ID <- match(edge_temp[,2],network.vertex.names(netWget_temp))
for (j in 1:length(TAIL_ID)) {
  netWget_temp[TAIL_ID[j],HEAD_ID[j]]<-1
}
#Add node covariate for number of webpages
NumPagesWget <- rep(0, length(network.vertex.names(netWget_temp)))
name_match <- match(countWget[,2], network.vertex.names(netWget_temp))
NumPagesWget[name_match] <- countWget[,3]
set.vertex.attribute(netWget_temp, "NumPages", NumPagesWget)
#Create matrix of missing nodes
absentWget <- match(network.vertex.names(netWget_temp), namesWget, nomatch=999)
absentWget[absentWget<999] <- 0
absentWget[absentWget==999] <- 1
set.vertex.attribute(netWget_temp, "absent", absentWget)
absentWget_mat <- as.matrix(online_temp)
absentWget_mat[absentWget==1,] <- 1
absentWget_mat[,absentWget==1] <- 1

#Add edge covariates
OVER.PSP<-(as.matrix(psp_group))
OVER.NPSP<-as.matrix(npsp_group)
OVER <- OVER.PSP + OVER.NPSP
edgecov.OVER_sq <- OVER^2

Survey_mat <- as.matrix(net)
save.image(file = "ReadyNetworks.Rdata")
