## ----message=FALSE, warning=FALSE, paged.print=TRUE---------------------------
library("robin")

## -----------------------------------------------------------------------------
my_network <- system.file("example/football.gml", package="robin")
# downloaded from: http://www-personal.umich.edu/~mejn/netdata/
graph <- prepGraph(file=my_network, file.format="gml")
graph

## -----------------------------------------------------------------------------
graphRandom <- random(graph=graph)
graphRandom

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
proc <- robinRobust(graph=graph, graphRandom=graphRandom, measure="vi", 
                  method="louvain", type="independent")

## -----------------------------------------------------------------------------
plotRobin(graph=graph, model1=proc$Mean, model2=proc$MeanRandom, 
legend=c("real data", "null model"), measure="vi")

## -----------------------------------------------------------------------------
robinFDATest(graph=graph, model1=proc$Mean, model2=proc$MeanRandom, 
             measure="vi")

## -----------------------------------------------------------------------------
robinGPTest(ratio=proc$ratios)

## -----------------------------------------------------------------------------
robinAUC(graph=graph, model1=proc$Mean, model2=proc$MeanRandom, 
             measure="vi")

## -----------------------------------------------------------------------------
membersFast <- membershipCommunities(graph=graph, method="fastGreedy")
membersLouv <- membershipCommunities(graph=graph, method="louvain")
plotComm(graph=graph, members=membersFast)
plotComm(graph=graph, members=membersLouv)

## -----------------------------------------------------------------------------
comp <- robinCompare(graph=graph, method1="fastGreedy",
                method2="louvain", measure="vi", type="independent")

## -----------------------------------------------------------------------------
plotRobin(graph=graph, model1=comp$Mean1, model2=comp$Mean2, measure="vi", 
legend=c("fastGreedy", "louvain"), title="FastGreedy vs Louvain")

## -----------------------------------------------------------------------------
robinFDATest(graph=graph, model1=comp$Mean1, model2=comp$Mean2, measure="vi")
robinGPTest(ratio=comp$ratios1vs2)

## -----------------------------------------------------------------------------
robinAUC(graph=graph, model1=comp$Mean1, model2=comp$Mean2, measure="vi")

