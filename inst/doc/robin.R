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
proc <- robinRobust(graph=graph, graphRandom=graphRandom, method="louvain")

## -----------------------------------------------------------------------------
plot(proc)

## ----message=FALSE, warning=FALSE---------------------------------------------
robinFDATest(proc)

## ----message=FALSE, warning=FALSE---------------------------------------------
robinGPTest(proc)

## -----------------------------------------------------------------------------
robinAUC(proc)

## -----------------------------------------------------------------------------
membersFast <- membershipCommunities(graph=graph, method="fastGreedy")
membersLouv <- membershipCommunities(graph=graph, method="louvain")
plotComm(graph=graph, members=membersFast)
plotComm(graph=graph, members=membersLouv)

## -----------------------------------------------------------------------------
comp <- robinCompare(graph=graph, method1="fastGreedy", method2="louvain")

## -----------------------------------------------------------------------------
plot(comp)

## ----message=FALSE, warning=FALSE---------------------------------------------
robinFDATest(comp)


## ----message=FALSE, warning=FALSE---------------------------------------------
robinGPTest(comp)

## -----------------------------------------------------------------------------
robinAUC(comp)

