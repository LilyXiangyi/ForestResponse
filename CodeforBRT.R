## BRT for all droughts
rm(list=ls())
library(dismo)
library(openxlsx)
mainDir<-"/Zscore/"
mainDir1<-"/BRT/Contribution/Resistance/"
mainDir2<-"/BRT/Contribution/Resilience/"
mainDir3<-"/BRT/Model/"
#mainDir4<-"/BRT/Contribution/ForPlot/Resistance/"
#mainDir5<-"/BRT/Contribution/ForPlot/Resilience/"
setwd(mainDir)
filenames<-dir(mainDir)
filenames1<-filenames[c(1:4)]
filepath<-sapply(filenames1,function(x){
  paste(mainDir,x,sep='')
})
for (i in 1:4){
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
  group<-factor(brttable$Group)
  brttable1[,19]<-group
  TreeRing.resis.lr0001<-gbm.step(data=brttable1, gbm.x=c(4:17,19,22), gbm.y =23,family="gaussian",
                                  tree.complexity =5,learning.rate = 0.001, bag.fraction =0.5,max.trees=100000)
  TreeRing.resili.lr0001<-gbm.step(data=brttable1, gbm.x=c(4:17,19,22), gbm.y =24,family="gaussian",
                                   tree.complexity =5,learning.rate = 0.001, bag.fraction =0.5,max.trees=100000)
  resis_var_contribution<-TreeRing.resis.lr0001$contributions
  resili_var_contribution<-TreeRing.resili.lr0001$contributions
  # write.table(resis_var_contribution, paste(mainDir1, filenamestring,"ResisContri.csv", sep=""), sep=",", col.names=FALSE, row.names= FALSE)
  #write.table(resili_var_contribution, paste(mainDir2, filenamestring,"ResiliContri.csv", sep=""), sep=",", col.names=FALSE, row.names= FALSE)
  #saveRDS(TreeRing.resis.lr0001, file = paste(mainDir3, filenamestring,"ResisContri.gbm", sep=""))
  #saveRDS(TreeRing.resili.lr0001, file = paste(mainDir3, filenamestring,"ResiliContri.gbm", sep=""))
  for (ivar in 1:15){
    plotdata_resis<- plot(TreeRing.resis.lr0001,TreeRing.resis.lr0001$var.names[ivar], return.grid=TRUE)
    plotdata_resili<-plot(TreeRing.resili.lr0001,TreeRing.resili.lr0001$var.names[ivar], return.grid=TRUE)
    # write.table(plotdata_resis,paste(mainDir4, filenamestring,TreeRing.resis.lr0001$var.names[ivar],".csv", sep=""), sep=",", col.names=TRUE, row.names= FALSE)
    #  write.table(plotdata_resis,paste(mainDir5, filenamestring,TreeRing.resis.lr0001$var.names[ivar],".csv", sep=""), sep=",", col.names=TRUE, row.names= FALSE)
  }
  dev.off()
}

## BRT for all droughts-different groups
rm(list=ls())
library(dismo)
library(openxlsx)
mainDir<-"/Zscore/Group/"
mainDir1<-"/BRT/Contribution/Resistance/Group/"
mainDir2<-"/BRT/Contribution/Resilience/Group/"
mainDir3<-"/BRT/Model/Group/"
mainDir4<-"/BRT/Contribution/ForPlot/Resistance/Group/"
mainDir5<-"/BRT/Contribution/ForPlot/Resilience/Group/"
setwd(mainDir)
filenames<-dir(mainDir)
filepath<-sapply(filenames,function(x){
  paste(mainDir,x,sep='')
})
for (i in 1:8){
  filenamesdata<-filenames[i]
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
  group<-factor(brttable$Group)
  brttable1[,19]<-group
  TreeRing.resis.lr0001<-gbm.step(data=brttable1, gbm.x=c(4:17,19,22), gbm.y =23,family="gaussian",
                                  tree.complexity =5,learning.rate = 0.001, bag.fraction =0.5,max.trees=100000)
  TreeRing.resili.lr0001<-gbm.step(data=brttable1, gbm.x=c(4:17,19,22), gbm.y =24,family="gaussian",
                                   tree.complexity =5,learning.rate = 0.001, bag.fraction =0.5,max.trees=100000)
  resis_var_contribution<-TreeRing.resis.lr0001$contributions
  resili_var_contribution<-TreeRing.resili.lr0001$contributions
  write.table(resis_var_contribution, paste(mainDir1, filenamestring,"ResisContri.csv", sep=""), sep=",", col.names=FALSE, row.names= FALSE)
  write.table(resili_var_contribution, paste(mainDir2, filenamestring,"ResiliContri.csv", sep=""), sep=",", col.names=FALSE, row.names=FALSE)
  saveRDS(TreeRing.resis.lr0001, file = paste(mainDir3, filenamestring,"ResisContri.gbm", sep=""))
  saveRDS(TreeRing.resili.lr0001, file = paste(mainDir3, filenamestring,"ResiliContri.gbm", sep=""))
  for (ivar in 1:14){
    plotdata_resis<- plot(TreeRing.resis.lr0001,TreeRing.resis.lr0001$var.names[ivar], return.grid=TRUE)
    plotdata_resili<-plot(TreeRing.resili.lr0001,TreeRing.resili.lr0001$var.names[ivar],return.grid=TRUE)
    write.table(plotdata_resis,paste(mainDir4, filenamestring,TreeRing.resis.lr0001$var.names[ivar],".csv", sep=""), sep=",", col.names=TRUE, row.names= FALSE)
    write.table(plotdata_resili,paste(mainDir5, filenamestring,TreeRing.resili.lr0001$var.names[ivar],".csv", sep=""), sep=",", col.names=TRUE, row.names= FALSE)
  }
  dev.off()
}


## plot
rm(list=ls())
library(dismo)
library(openxlsx)
mainDir<-"/BRT/Model2/Group/"
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

#rm(list=ls())
#library(dismo)
#library(openxlsx)
#mainDir<-"/BRT/Model2/Group/"
#mainDir1<-"/BRT/Model2/Plot/"
#setwd(mainDir)
#filenames<-dir(mainDir)
#filepath<-sapply(filenames,function(x){
#  paste(mainDir,x,sep='')
#})
#filepath1<-filepath[c(8,24,16)]
#filepath2<-filepath[c(4,20,12)]
#filepath3<-filepath[c(6,22,14)]
#filepath4<-filepath[c(2,18,10)]
#filenames1<-filenames[c(8,24,16)]
#filenames2<-filenames[c(4,20,12)]
#filenames3<-filenames[c(6,22,14)]
#filenames4<-filenames[c(2,18,10)]
#for (i in 1:3){
 # filenamei<-filenames1[i]
  #stringlength<-nchar(filenamei)
  #filenamestring<-substring(filenamei,1,stringlength-4)
  #modelfile<-readRDS(filepath1[i])
  #for (ivar in 1:15){
   # plotdata<- plot(modelfile,modelfile$var.names[ivar], return.grid=TRUE)
  #  write.table(plotdata,paste(mainDir1, filenamestring,modelfile$var.names[ivar],".csv", sep=""), sep=",", col.names=TRUE, row.names= FALSE)
  #}
#}

