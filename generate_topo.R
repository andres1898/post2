# define directory
na_dir <- paste("refe_tree")
dir.create(path = na_dir)
setwd(paste((getwd()),  "/" ,na_dir, sep=""))

##Generate topologies with different terminal size
library(ape)
set.seed(123)
#

for (i in c(1,2,3)){
  j <- sprintf('05term_%d.tree', i)
  h <- rtree(5)
  write.tree(file = j, phy = h)
}

for (i in c(1,2,3)){
  j <- sprintf('10term_%d.tree', i)
  h <- rtree(10)
  write.tree(file = j, phy = h)
}

for (i in c(1,2,3)){
  j <- sprintf('20term_%d.tree', i)
  h <- rtree(20)
  write.tree(file = j, phy = h)
}

for (i in c(1,2,3)){
  j <- sprintf('30term_%d.tree', i)
  h <- rtree(30)
  write.tree(file = j, phy = h)
}

for (i in c(1,2,3)){
  j <- sprintf('40term_%d.tree', i)
  h <- rtree(40)
  write.tree(file = j, phy = h)
}


