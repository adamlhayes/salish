load("ReadyNetworks.Rdata")

library("statnet")

#Set control parameters
seed=24
maxit=20
gridsize=2500
sampsize=10000
nsim=3000


#Modified full network model
Surv_mod_RR <- net ~ edges + mutual + isolates + twopath + gwesp(0.625, fixed=TRUE) + gwidegree(.95, fixed=TRUE) +
  nodecov("NUMRESP") +
  nodematch("ORGTYPE") +
  nodeifactor("OrgType_Agg")

Surv_est_RR <- ergm(Surv_mod_RR,
                    control=control.ergm(Step.MCMC.samplesize=sampsize,
                                         main.method="Stepping",
                                         MCMLE.metric="lognormal",
                                         Step.gridsize=gridsize,
                                         Step.maxit=maxit,
                                         seed=seed))

TNRT_mat <- as.matrix(netTNRT_temp)
IC2_mat <- as.matrix(netIC2_temp)

Surv_mod_RR_plus <- net ~ edges + mutual + isolates + twopath + gwesp(0.625, fixed=TRUE) + gwidegree(0.95, fixed=TRUE) +
  nodecov("NUMRESP") +
  nodematch("ORGTYPE") +
  nodeifactor("OrgType_Agg") + 
  edgecov(TNRT_mat) + 
  edgecov(IC2_mat)

Surv_est_RR_plus <- ergm(Surv_mod_RR_plus,
                    control=control.ergm(Step.MCMC.samplesize=sampsize,
                                         main.method="Stepping",
                                         MCMLE.metric="lognormal",
                                         Step.gridsize=gridsize,
                                         Step.maxit=maxit,
                                         seed=seed))  


save.image("ergms_survey_RR.RData")
