## -----------------------------------------------------------------------------
#install.packages("robin")

## -----------------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("gprege")
# 
# install.packages("robin")

## ----message=FALSE, warning=FALSE, paged.print=TRUE---------------------------
library("robin")

## -----------------------------------------------------------------------------
my_network <- system.file("example/football.gml", package="robin")
# downloaded from: http://www-personal.umich.edu/~mejn/netdata/
graph <- prepGraph(file=my_network, file.format="gml")
graph

## -----------------------------------------------------------------------------
plotGraph(graph)

## -----------------------------------------------------------------------------
methodCommunity(graph=graph, method="fastGreedy") 

## -----------------------------------------------------------------------------
membershipCommunities(graph=graph, method="fastGreedy") 

## -----------------------------------------------------------------------------
members <- membershipCommunities(graph=graph, method="fastGreedy")
plotComm(graph=graph, members=members)

## -----------------------------------------------------------------------------
graphRandom <- random(graph=graph)
graphRandom

## -----------------------------------------------------------------------------
proc <- robinRobust(graph=graph, graphRandom=graphRandom, measure="vi", 
                  method="louvain", type="independent")

## -----------------------------------------------------------------------------
plotRobin(graph=graph, model1=proc$Mean, model2=proc$MeanRandom,
legend=c("real data", "null model"))

## ----message=FALSE, warning=FALSE---------------------------------------------
robinFDATest(graph=graph, model1=proc$Mean, model2=proc$MeanRandom, 
            legend=c("real graph", "random graph"))

## ----message=FALSE, warning=FALSE---------------------------------------------
robinGPTest(model1=proc$Mean, model2=proc$MeanRandom)

## -----------------------------------------------------------------------------
robinAUC(graph=graph, model1=proc$Mean, model2=proc$MeanRandom)

## -----------------------------------------------------------------------------
membersFast <- membershipCommunities(graph=graph, method="fastGreedy")
membersLouv <- membershipCommunities(graph=graph, method="louvain")
plotComm(graph=graph, members=membersFast)
plotComm(graph=graph, members=membersLouv)

## -----------------------------------------------------------------------------
comp <- robinCompare(graph=graph, method1="fastGreedy",
                method2="louvain", measure="vi")

## -----------------------------------------------------------------------------
plotRobin(graph=graph, model1=comp$Mean1, model2=comp$Mean2, 
legend=c("fastGreedy", "louvain"), title="FastGreedy vs Louvain")

## ----message=FALSE, warning=FALSE---------------------------------------------
robinFDATest(graph=graph, model1=comp$Mean1, model2=comp$Mean2)


## ----message=FALSE, warning=FALSE---------------------------------------------
robinGPTest(model1=comp$Mean1, model2=comp$Mean2)

## -----------------------------------------------------------------------------
robinAUC(graph=graph, model1=comp$Mean1, model2=comp$Mean2)

