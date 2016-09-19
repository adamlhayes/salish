load("ReadyNetworks.Rdata")

library("statnet")

netIC2 <- netIC2_temp

#Set ergm simulation parameters
seed=24
maxit=20
gridsize=2500
sampsize=10000
nsim=3000

#Bernoulli Graph with node, edge terms
IC_modR <- netIC2 ~ edges + 
  nodecov("NumPages") + 
  nodematch("OrgType") + 
  nodeifactor("OrgType_Agg") + 
  offset(edgecov(absentIC2_mat))
IC_estR <- ergm(IC_modR, offset.coef=-Inf,
                    control=control.ergm(Step.MCMC.samplesize=sampsize,
                                         main.method="Stepping",
                                         MCMLE.metric="lognormal",
                                         Step.gridsize=gridsize, 
                                         Step.maxit=maxit,
                                         seed=seed))

H1_IC_modR <- netIC2 ~ edges + 
  nodecov("NumPages") + 
  nodematch("OrgType") + 
  nodeifactor("OrgType_Agg") + 
  edgecov(Survey_mat) + 
  offset(edgecov(absentIC2_mat))
H1_IC_estR <- ergm(H1_IC_modR, offset.coef=-Inf,
                    control=control.ergm(Step.MCMC.samplesize=sampsize,
                                         main.method="Stepping",
                                         MCMLE.metric="lognormal",
                                         Step.gridsize=gridsize, 
                                         Step.maxit=maxit,
                                         seed=seed))

H2_IC_modR <- netIC2 ~ edges + 
  nodecov("NumPages") + 
  nodematch("OrgType") + 
  nodeifactor("OrgType_Agg") + 
  edgecov(OVER) + 
  edgecov(edgecov.OVER_sq) +
  offset(edgecov(absentIC2_mat))
H2_IC_estR <- ergm(H2_IC_modR, offset.coef=-Inf,
                       control=control.ergm(Step.MCMC.samplesize=sampsize,
                                            main.method="Stepping",
                                            MCMLE.metric="lognormal",
                                            Step.gridsize=gridsize, 
                                            Step.maxit=maxit,
                                            seed=seed))


#Hyperlink Full Model
IC_modFull <- netIC2 ~ edges + mutual + isolates + twopath + gwesp(0.55, fixed=TRUE) + gwidegree(0.8, fixed=TRUE) +
  nodecov("NumPages") + 
  nodematch("OrgType") + 
  nodeifactor("OrgType_Agg") + 
  offset(edgecov(absentIC2_mat))

IC_estFull <- ergm(IC_modFull, offset.coef=-Inf,
                   control=control.ergm(Step.MCMC.samplesize=sampsize,
                                        main.method="Stepping",
                                        MCMLE.metric="lognormal",
                                        Step.gridsize=gridsize, 
                                        Step.maxit=maxit,
                                        seed=seed))

H1_IC_modFull <- netIC2 ~ edges + mutual + isolates + twopath + gwesp(0.55, fixed=TRUE) + gwidegree(0.8, fixed=TRUE) +
  nodecov("NumPages") + 
  nodematch("OrgType") + 
  nodeifactor("OrgType_Agg") + 
  edgecov(Survey_mat) + 
  offset(edgecov(absentIC2_mat))

H1_IC_estFull <- ergm(H1_IC_modFull, offset.coef=-Inf,
                   control=control.ergm(Step.MCMC.samplesize=sampsize,
                                        main.method="Stepping",
                                        MCMLE.metric="lognormal",
                                        Step.gridsize=gridsize, 
                                        Step.maxit=maxit,
                                        seed=seed))

H2_IC_modFull <- netIC2 ~ edges + mutual + isolates + twopath + gwesp(0.55, fixed=TRUE) + gwidegree(0.8, fixed=TRUE) +
  nodecov("NumPages") + 
  nodematch("OrgType") + 
  nodeifactor("OrgType_Agg") +  
  edgecov(OVER) + 
  edgecov(edgecov.OVER_sq) + 
  offset(edgecov(absentIC2_mat))

H2_IC_estFull <- ergm(H2_IC_modFull, offset.coef=-Inf,
                      control=control.ergm(Step.MCMC.samplesize=sampsize,
                                           main.method="Stepping",
                                           MCMLE.metric="lognormal",
                                           Step.gridsize=gridsize, 
                                           Step.maxit=maxit,
                                           seed=seed))



save.image("ergms_hyper.RData")
