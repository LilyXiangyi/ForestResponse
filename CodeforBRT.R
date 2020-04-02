## BRT for different classess: drought timingsxforest groups
rm(list=ls())
library(dismo)
library(openxlsx)
library(gbm)
mainDir<-"/Zscore/"
mainDir1<-"/BRT/Contribution/Resistance/"
mainDir2<-"/BRT/Contribution/Resilience/"
mainDir3<-"/BRT/Model/"
mainDir4<-"/BRT/Contribution/ForPlot/Resistance/"
mainDir5<-"/BRT/Contribution/ForPlot/Resilience/"

setwd(mainDir1)
filenames<-dir(mainDir1)
filenames1<-filenames[c(3,2,8,7,5,4)]
filepath<-sapply(filenames1,function(x){
  paste(mainDir1,x,sep='')
})

for (i in 1:6){
  filenamesdata<-filenames1[i]
  stringlength<-nchar(filenamesdata)
  filenamestring<-substring(filenamesdata,1,stringlength-5)
  brttable<-read.xlsx(filepath[i])
  cname<-names(brttable)
  linebrttable<-nrow(brttable)
  colbrttable<-ncol(brttable)
  brttable1<-array(NA,dim=c(linebrttable,colbrttable))
  brttable1<-brttable
  brttable1<-data.frame(brttable1)
  names(brttable1)<-cname
  AWC<-factor(brttable$AWC)
  brttable1[,21]<-AWC
  
  TreeRing.resis.lr001<-gbm.step(data=brttable, gbm.x=c(4:18,21),gbm.y =22,family="gaussian",
                                 tree.complexity =5,learning.rate = 0.001, bag.fraction =0.5)
  TreeRing.resili.lr001<-gbm.step(data=brttable, gbm.x=c(4:18,21), gbm.y =23,family="gaussian",
                                  tree.complexity =5,learning.rate = 0.001, bag.fraction =0.5)
  
  TreeRing.resis.simp<-gbm.simplify(TreeRing.resis.lr001,n.drops=5)
  TreeRing.resis.lr001.simp<-TreeRing.resis.lr001
  TreeRing.resis.lr001.simp <-gbm.step(brttable, gbm.x=TreeRing.resis.simp$pred.list[[2]], gbm.y =22, tree.complexity = 5, learning.rate = 0.001,family="gaussian",bag.fraction =0.5)
  
  TreeRing.resili.simp<-gbm.simplify(TreeRing.resili.lr001,n.drops=5)
  TreeRing.resili.lr001.simp<-TreeRing.resili.lr001
  TreeRing.resili.lr001.simp <-gbm.step(brttable, gbm.x=TreeRing.resili.simp$pred.list[[5]], gbm.y =23, tree.complexity = 5, learning.rate = 0.001,family="gaussian",bag.fraction =0.5)
  
  
  resis_var_contribution<-TreeRing.resis.lr001.simp$contributions
  resili_var_contribution<-TreeRing.resili.lr001.simp$contributions
  
  write.table(resis_var_contribution, paste(mainDir3, filenamestring,"ResisContri.csv", sep=""), sep=",", col.names=FALSE, row.names= FALSE)
  write.table(resili_var_contribution, paste(mainDir4, filenamestring,"ResiliContri.csv", sep=""), sep=",", col.names=FALSE, row.names=FALSE)
  
  saveRDS(TreeRing.resis.lr001, file = paste(mainDir5, filenamestring,"ResisContri.gbm", sep=""))
  saveRDS(TreeRing.resili.lr001, file = paste(mainDir5, filenamestring,"ResiliContri.gbm", sep=""))
  saveRDS(TreeRing.resis.lr001.simp, file = paste(mainDir5, filenamestring,"ResisContrisimp.gbm", sep=""))
  saveRDS(TreeRing.resili.lr001.simp, file = paste(mainDir5, filenamestring,"ResiliContrisimp.gbm", sep=""))
  
  dev.off()
  #preds_resis<-predict.gbm(TreeRing.resis.lr001.simp,brttable,n.trees=TreeRing.resis.lr001.simp$gbm.call$best.trees,type="response")
  #preds_resis1<-data.frame(preds_resis)
  #preds_resili<-predict.gbm(TreeRing.resili.lr001.simp,brttable,n.trees=TreeRing.resili.lr001.simp$gbm.call$best.trees,type="response")
  #preds_resili1<-data.frame(preds_resili)
  #write.table(preds_resis1, paste(mainDir2, filenamestring,"Resis.csv", sep=""), sep=",", col.names=FALSE, row.names=FALSE)
  #write.table(preds_resili1, paste(mainDir2, filenamestring,"Resili.csv", sep=""), sep=",", col.names=FALSE, row.names=FALSE)
}


## plot
rm(list=ls())
library(dismo)
library(openxlsx)
mainDir<-"/BRT/Model/Group/"
setwd(mainDir)
filenames<-dir(mainDir)
#filenames1<-filenames[c(6,4,16,14,10,8)]
#filenames2<-filenames[c(5,3,15,13,9,7)]
#filepath1<-sapply(filenames1,function(x){
# paste(mainDir,x,sep='')
#})
#filepath2<-sapply(filenames2,function(x){
# paste(mainDir,x,sep='')
#})
filenames1<-filenames[c(23)]
filepath<-sapply(filenames1,function(x){
  paste(mainDir,x,sep='')
})
for (i in 1:8){
  modelfile<-readRDS(filepath)
  gplot<-gbm.plot(modelfile,n.plots=5,plot.layout = c(3,5),x.label=modelfile$var.names,y.label="Resistance",smooth=T,col="white",show.contrib =T)
  
}

