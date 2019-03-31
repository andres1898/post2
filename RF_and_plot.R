library(ape)
library(phytools)
library(phangorn)

#reference trees
term_5.1 <- read.tree("./refe_tree/05term_1.tree")
term_5.2 <- read.tree("./refe_tree/05term_2.tree")
term_5.3 <- read.tree("./refe_tree/05term_3.tree")
term_10.1 <- read.tree("./refe_tree/10term_1.tree")
term_10.2 <- read.tree("./refe_tree/10term_2.tree")
term_10.3 <- read.tree("./refe_tree/10term_3.tree")
term_20.1 <- read.tree("./refe_tree/20term_1.tree")
term_20.2 <- read.tree("./refe_tree/20term_2.tree")
term_20.3 <- read.tree("./refe_tree/20term_3.tree")
term_30.1 <- read.tree("./refe_tree/30term_1.tree")
term_30.2 <- read.tree("./refe_tree/30term_2.tree")
term_30.3 <- read.tree("./refe_tree/30term_3.tree")
term_40.1 <- read.tree("./refe_tree/40term_1.tree")
term_40.2 <- read.tree("./refe_tree/40term_2.tree")
term_40.3 <- read.tree("./refe_tree/40term_3.tree")
# as a multiphylo
referencia <- list(term_5.1,term_5.2,term_5.3,term_10.1,term_10.2,term_10.3,term_20.1,term_20.2,term_20.3,term_30.1,term_30.2,term_30.3,term_40.1,term_40.2,term_40.3)
class(referencia) <- "multiPhylo"

#create list
list_bayes <- list.files(path= "./Bayes/trees", pattern = "con.tre")
list_raxml_defaul <- list.files(path = "./ML_def/", pattern = ".bestTree")
list_raxml_hky <- list.files(path = "./ML_HKY", pattern = ".bestTree")
list_parsi <- list.files(path = "./pars_defa", pattern = ".tree")
list_parsi_wei <- list.files(path = "./pars_wei", pattern = ".tree")


#read trees
bayes <- lapply(list_bayes, read.nexus)
ML_defa <- lapply(list_raxml_defaul, read.tree)
ML_hky <- lapply(list_raxml_hky, read.tree)
Pars <- lapply(list_parsi, read.tree)
Pars_wei <- lapply(list_parsi_wei, read.tree)

#become multiphylo and make it binary
class(bayes) <- "multiPhylo"
bayes <- multi2di(bayes)
class(ML_defa) <- "multiPhylo"
ML_defa <- multi2di(ML_defa)
class(ML_hky) <- "multiPhylo"
ML_hky <- multi2di(ML_hky)
class(Pars) <- "multiPhylo"
Pars <- multi2di(Pars)
class(Pars_wei) <- "multiPhylo"
Pars_wei <- multi2di(Pars_wei)

#RF function
comparar <- function(multiphylo, ref.tre) {
  
  numT <- length(multiphylo)
  dist_RF <- vector("numeric", numT)
  for (i in 1:numT){
    dist_RF[i]<- RF.dist(multiphylo[[i]],
                         ref.tre[[i]])
  }
  return(dist_RF)
}

#######################################################
# calculate distance for each methods against reference topology

dist_pars <- comparar(Pars, referencia)
#
dist_pars_wei <- comparar(Pars_wei, referencia)
#
dist_ML_def <- comparar(ML_defa, referencia)
#
dist_ML_hky <- comparar(ML_hky, referencia)
#
dist_bayes <- comparar(bayes,referencia)
#

##change directory to save the graph
na_dir <- paste("graphics")
dir.create(path = na_dir)
setwd(paste((getwd()),  "/" ,na_dir, sep=""))

### matrix for make plot, 
dista_totales <- data.frame(dist_pars, dist_pars_wei, dist_ML_def, dist_ML_hky, dist_bayes)

terminales <- sort(rep(c("05","10","20","30","40"),3))

distancias <- cbind(terminales,dista_totales)

write.csv(file = "distancias.csv",x = distancias)

### I can't make a matrix so I made by hand, the str is data frame with 
dist_gg <- read.csv("../../arboles/distancias.csv")
dist_gg$terminales <- as.factor(dist_gg$terminales)

dist_gg$Metodo <- as.factor(dist_gg$Metodo)
str(dist_gg)

####### Plots
library(ggplot2)
#boxplot for methods
RFmethod <- ggplot(dist_gg, aes(x=dist_gg$Metodo, y=dist_gg$RF)) + 
  geom_boxplot(outlier.colour="red") + stat_summary(fun.y=mean, colour="blue", geom="point") + ylab("RF distance") + xlab("Method")
svg(filename = "RFmethod")
plot(RFmethod)
dev.off()
#boxplot for terminals
term_box <- ggplot(dist_gg, aes(x=as.character(dist_gg$terminales), y=dist_gg$RF)) + 
  geom_boxplot(outlier.colour="red") + stat_summary(fun.y=mean, colour="blue", geom="point") + ylab("RF distance") + xlab("Number of terminals")
svg("term_box.svg")
plot(term_box)
dev.off()
#all methods regression
p <- ggplot(dist_gg, aes(x=as.numeric(dist_gg$terminales), y=dist_gg$RF, color=dist_gg$Metodo)) + geom_point() + geom_smooth(method = lm, se=F) + ylab("RF distance") + xlab("Number of terminals")
p <- p + labs(color="Method") + scale_color_manual(values = c("brown1", "blue4", "chartreuse4", "darkorange", "darkmagenta"))
plot(p)
svg("all_regression.svg")
plot(p)
dev.off()
### regression for each method
#matrix
parsi <- rbind(dist_gg[dist_gg$Metodo=="Parsimonia",], dist_gg[dist_gg$Metodo=="Parsi Weight",])

#
ML <- rbind(dist_gg[dist_gg$Metodo=="ML default",], dist_gg[dist_gg$Metodo=="ML HKY",])

#
Bayes <- rbind(dist_gg[dist_gg$Metodo=="Bayes",])

#Plots
p_pars <- ggplot(parsi, aes(x= as.numeric(parsi$terminales), y=parsi$RF, color=parsi$Metodo)) + 
  geom_point() + 
  geom_smooth(method = lm, se=T) + 
  ylab("RF distance") + 
  xlab("Number of terminals") + 
  labs(color="Method") + 
  scale_color_manual(values = c("darkorange", "darkmagenta"))
plot(p_pars)
svg("pars_regre.svg")
plot(parsi)
dev.off()
#
p_ML <- ggplot(ML, aes(x= as.numeric(ML$terminales), y=ML$RF, color=ML$Metodo)) + 
  geom_point() + 
  geom_smooth(method = lm, se=T) + 
  ylab("RF distance") + 
  xlab("Number of terminals") + 
  labs(color="Method") + 
  scale_color_manual(values = c("blue4", "chartreuse4"))
plot(p_ML)
svg("ML_regre.svg")
plot(ML)
dev.off()
#
p_bayes <- ggplot(Bayes, aes(x= as.numeric(Bayes$terminales), y=Bayes$RF, color=Bayes$Metodo)) + 
  geom_point() + 
  geom_smooth(method = lm, se=T) + 
  ylab("RF distance") + 
  xlab("Number of terminals") + 
  labs(color="Method") + 
  scale_color_manual(values = c("brown1"))
plot(p_bayes)
svg("bay_regre.svg")
plot(Bayes)
dev.off()

###########################################
# calculate regression parameters for each method

terminales <- as.numeric(terminales)

plot(dist_pars~terminales)
abline(lm(dist_pars~terminales))
summary(lm(dist_pars~terminales))
#
plot(dist_pars_wei~terminales)
abline(lm(dist_pars_wei~terminales))
summary(lm(dist_pars_wei~terminales))
#
plot(dist_ML_def~terminales)
abline(lm(dist_ML_def~terminales))
summary(lm(dist_ML_def~terminales))
#
plot(dist_ML_hky~terminales)
abline(lm(dist_ML_hky~terminales))
summary(lm(dist_ML_hky~terminales))
#
plot(dist_bayes~terminales)
abline(lm(dist_bayes~terminales))
summary(lm(dist_bayes~terminales))

## for add R2 and make more beautiful the graphs I save plot in SVG format and modified in Inkscape program
