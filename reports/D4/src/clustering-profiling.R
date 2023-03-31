# Set working directory path
parent_dir <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd(parent_dir)

library(dplyr)
dir <- getwd()
dd <- readRDS(paste0(dir,"/data/Preprocessed_data_rds.rds"))


names(dd)
dim(dd)
summary(dd)

attach(dd)


dcon <- select_if(dd, is.numeric)
dim(dcon)


library(cluster)


actives<-c(2:28)
dissimMatrix <- daisy(dd[,actives], metric = "gower", stand=TRUE)

distMatrix<-dissimMatrix^2

h1 <- hclust(distMatrix,method="ward.D2")  

plot(h1)

k<-2

c2 <- cutree(h1,k)


table(c2)



# LETS SEE THE PARTITION VISUALLY

c1<-c2

pairs(dcon[,1:8], col=c1)

plot(age, instance.weight, col=c1)


#Calcula els valor test de la variable Xnum per totes les modalitats del factor P
ValorTestXnum <- function(Xnum,P){
  #freq dis of fac
  nk <- as.vector(table(P)); 
  n <- sum(nk); 
  #mitjanes x grups
  xk <- tapply(Xnum,P,mean);
  #valors test
  txk <- (xk-mean(Xnum))/(sd(Xnum)*sqrt((n-nk)/(n*nk))); 
  #p-values
  pxk <- pt(txk,n-1,lower.tail=F);
  for(c in 1:length(levels(as.factor(P)))){if (pxk[c]>0.5){pxk[c]<-1-pxk[c]}}
  return (pxk)
}

ValorTestXquali <- function(P,Xquali){
  taula <- table(P,Xquali);
  n <- sum(taula); 
  pk <- apply(taula,1,sum)/n;
  pj <- apply(taula,2,sum)/n;
  pf <- taula/(n*pk);
  pjm <- matrix(data=pj,nrow=dim(pf)[1],ncol=dim(pf)[2]);      
  dpf <- pf - pjm; 
  dvt <- sqrt(((1-pk)/(n*pk))%*%t(pj*(1-pj))); 
  #i hi ha divisions iguals a 0 dona NA i no funciona
  zkj <- dpf
  zkj[dpf!=0]<-dpf[dpf!=0]/dvt[dpf!=0]; 
  pzkj <- pnorm(zkj,lower.tail=F);
  for(c in 1:length(levels(as.factor(P)))){for (s in 1:length(levels(Xquali))){if (pzkj[c,s]> 0.5){pzkj[c,s]<-1- pzkj[c,s]}}}
  return (list(rowpf=pf,vtest=zkj,pval=pzkj))
}
# Cal executar codi del clustering i preparació del profiling
#dades contain the dataset
dades<-dd
#dades<-dd[filtro,]
#dades<-df
K<-dim(dades)[2]
par(ask=TRUE)

#P must contain the class variable
P<-c2
#P<-df[,33]

nc<-length(levels(factor(P)))
pvalk <- matrix(data=0,nrow=nc,ncol=K, dimnames=list(levels(P),names(dades)))
nameP<-"Class"
n<-dim(dades)[1]


#SEX
# Variable Sexe
print(paste("Variable", names(dades)[12]))
table<-table(P,dades[,12])
rowperc<-prop.table(table,1)
colperc<-prop.table(table,2)
dades[,12]<-as.factor(dades[,12])
marg <- table(as.factor(P))/n

#with legend
plot(marg,type="n",ylim=c(0,1),main=paste("Prop. of pos & neg by",names(dades)[12]))
paleta<-rainbow(length(levels(dades[,12])))
for(c in 1:length(levels(dades[,12]))){lines(rowperc[,c],col=paleta[c]) }
legend("topright", levels(dades[,12]), col=paleta, lty=2, cex=0.6)



# RACE
table<-table(P,dades[,10])
rowperc<-prop.table(table,1)
colperc<-prop.table(table,2)
dades[,10]<-as.factor(dades[,10])
marg <- table(as.factor(P))/n

paleta<-rainbow(length(levels(dades[,10])))
barplot(table(dades[,10], as.factor(P)), beside=TRUE,col=paleta)
legend("topleft",levels(as.factor(dades[,10])),pch=1,cex=0.5, col=paleta)



# EDUCATION
table<-table(P,dades[,5])
rowperc<-prop.table(table,1)
colperc<-prop.table(table,2)
dades[,5]<-as.factor(dades[,5])
marg <- table(as.factor(P))/n

paleta<-rainbow(length(levels(dades[,5])))
barplot(table(dades[,5], as.factor(P)), beside=TRUE,col=paleta)
legend("topleft",levels(as.factor(dades[,5])),pch=1,cex=0.5, col=paleta, bg="transparent")



#CAPITAL GAINS
j <- grep("capital.gains", colnames(dd))
boxplot(dades[,j]~P, main=paste("Boxplot of", names(dades)[j], "vs", nameP ), horizontal=TRUE)


#CAPITAL LOSSES
j <- grep("capital.losses", colnames(dd))
boxplot(dades[,j]~P, main=paste("Boxplot of", names(dades)[j], "vs", nameP ), horizontal=TRUE)


#AGE
j <- grep("age", colnames(dd))
boxplot(dades[,1]~P, main=paste("Boxplot of", names(dades)[1], "vs", nameP ), horizontal=TRUE)


#DETAILED HOUSEHOLD IN HOUSEHOLD
table<-table(P,dades[,19])
rowperc<-prop.table(table,1)
colperc<-prop.table(table,2)
dades[,19]<-as.factor(dades[,19])
marg <- table(as.factor(P))/n

paleta<-rainbow(length(levels(dades[,19])))
barplot(table(dades[,19], as.factor(P)), beside=TRUE,col=paleta)
legend("top",levels(as.factor(dades[,19])),pch=1,cex=0.5, col=paleta, bg="transparent")




#INCOME
print(paste("Variable", names(dades)[28]))
table<-table(P,dades[,28])
rowperc<-prop.table(table,1)
colperc<-prop.table(table,2)
dades[,28]<-as.factor(dades[,28])
marg <- table(as.factor(P))/n

#with legend
plot(marg,type="n",ylim=c(0,1),main=paste("Prop. of pos & neg by",names(dades)[28]))
paleta<-rainbow(length(levels(dades[,28])))
for(c in 1:length(levels(dades[,28]))){lines(rowperc[,c],col=paleta[c]) }
legend("center", levels(dades[,28]), col=paleta, lty=2, cex=0.6)


#INSTANCE WEIGHT
j <- grep("instance.weight", colnames(dd))
boxplot(dades[,j]~P, main=paste("Boxplot of", names(dades)[j], "vs", nameP ), horizontal=TRUE)


#CITIZENSHIP
print(paste("Variable", names(dades)[25]))
table<-table(P,dades[,25])
rowperc<-prop.table(table,1)
colperc<-prop.table(table,2)
dades[,25]<-as.factor(dades[,25])
marg <- table(as.factor(P))/n

#with legend
plot(marg,type="n",ylim=c(0,1),main=paste("Prop. of pos & neg by",names(dades)[25]))
paleta<-rainbow(length(levels(dades[,25])))
for(c in 1:length(levels(dades[,25]))){lines(rowperc[,c],col=paleta[c]) }
legend("center", levels(dades[,25]), col=paleta, lty=2, cex=0.6)
