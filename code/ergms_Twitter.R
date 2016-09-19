load("ReadyNetworks.Rdata")

library("statnet")

netTNRT <- netTNRT_temp

#Set control parameters
seed=24
maxit=20
gridsize=2500
sampsize=10000
nsim=3000

#Bernoulli Graph with node, edge terms
NRT_modR <- netTNRT ~ edges + 
  nodecov("NumTweets") + 
  nodematch("OrgType") + 
  nodeifactor("OrgType_Agg") + 
  offset(edgecov(absentTNRT_mat))
NRT_estR <- ergm(NRT_modR, offset.coef=-Inf,
                     control=control.ergm(Step.MCMC.samplesize=sampsize,
                                          main.method="Stepping",
                                          MCMLE.metric="lognormal",
                                          Step.gridsize=gridsize, 
                                          Step.maxit=maxit,
                                          seed=seed))

H1_NRT_modR <- netTNRT ~ edges + 
  nodecov("NumTweets") + 
  nodematch("OrgType") + 
  nodeifactor("OrgType_Agg") + 
  edgecov(Survey_mat) + 
  offset(edgecov(absentTNRT_mat))
H1_NRT_estR <- ergm(H1_NRT_modR, offset.coef=-Inf,
                     control=control.ergm(Step.MCMC.samplesize=sampsize,
                                          main.method="Stepping",
                                          MCMLE.metric="lognormal",
                                          Step.gridsize=gridsize, 
                                          Step.maxit=maxit,
                                          seed=seed))

H2_NRT_modR <- netTNRT ~ edges + 
  nodecov("NumTweets") + 
  nodematch("OrgType") + 
  nodeifactor("OrgType_Agg") + 
  edgecov(OVER) + 
  edgecov(edgecov.OVER_sq) +
  offset(edgecov(absentTNRT_mat))
H2_NRT_estR <- ergm(H2_NRT_modR, offset.coef=-Inf,
                    control=control.ergm(Step.MCMC.samplesize=sampsize,
                                         main.method="Stepping",
                                         MCMLE.metric="lognormal",
                                         Step.gridsize=gridsize, 
                                         Step.maxit=maxit,
                                         seed=seed))



#Candidates for full model
NRT_modFull <- netTNRT ~ edges + mutual + isolates + twopath + gwesp(0.55, fixed=TRUE) + gwidegree(0.85, fixed=TRUE) +
  nodecov("NumTweets") + 
  nodematch("OrgType") + 
  nodeifactor("OrgType_Agg") + 
  offset(edgecov(absentTNRT_mat))

NRT_estFull <- ergm(NRT_modFull, offset.coef=-Inf,
                    control=control.ergm(Step.MCMC.samplesize=sampsize,
                                         main.method="Stepping",
                                         MCMLE.metric="lognormal",
                                         Step.gridsize=gridsize, 
                                         Step.maxit=maxit,
                                         seed=seed))
NRT_modFull <- netTNRT ~ edges + mutual + isolates + twopath + gwesp(0.7, fixed=TRUE) + gwidegree(1.1, fixed=TRUE) +
  nodecov("NumTweets") + 
  nodematch("OrgType") + 
  nodeifactor("OrgType_Agg") + 
  offset(edgecov(absentTNRT_mat))

NRT_estFull <- ergm(NRT_modFull, offset.coef=-Inf,
                    control=control.ergm(Step.MCMC.samplesize=sampsize,
                                         main.method="Stepping",
                                         MCMLE.metric="lognormal",
                                         Step.gridsize=gridsize, 
                                         Step.maxit=maxit,
                                         seed=seed))
H1_NRT_modFull <- netTNRT ~ edges + mutual + isolates + twopath + gwesp(0.7, fixed=TRUE) + gwidegree(1.1, fixed=TRUE) +
  nodecov("NumTweets") + 
  nodematch("OrgType") + 
  nodeifactor("OrgType_Agg") + 
  edgecov(Survey_mat) + 
  offset(edgecov(absentTNRT_mat))

H1_NRT_estFull <- ergm(H1_NRT_modFull, offset.coef=-Inf,
                    control=control.ergm(Step.MCMC.samplesize=sampsize,
                                         main.method="Stepping",
                                         MCMLE.metric="lognormal",
                                         Step.gridsize=gridsize, 
                                         Step.maxit=maxit,
                                         seed=seed))

H2_NRT_modFull <- netTNRT ~ edges + mutual + isolates + twopath + gwesp(0.7, fixed=TRUE) + gwidegree(1.1, fixed=TRUE) +
  nodecov("NumTweets") + 
  nodematch("OrgType") + 
  nodeifactor("OrgType_Agg") + 
  edgecov(OVER) + 
  edgecov(edgecov.OVER_sq) + 
  offset(edgecov(absentTNRT_mat))

H2_NRT_estFull <- ergm(H2_NRT_modFull, offset.coef=-Inf,
                       control=control.ergm(Step.MCMC.samplesize=sampsize,
                                            main.method="Stepping",
                                            MCMLE.metric="lognormal",
                                            Step.gridsize=gridsize, 
                                            Step.maxit=maxit,
                                            seed=seed))


save.image("ergms_twitter.RData")
