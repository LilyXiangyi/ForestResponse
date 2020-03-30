# Chron
citation("dplR")
library(dplR)
# 1. Africa-
mainDir<-"/itrdb-v713-measurements/Africa/"
mainDir1<-"/chronologies_new/"
setwd(mainDir)
filenames<-dir(mainDir)
filepath<-sapply(filenames,function(x){
  paste(mainDir,x,sep='')
})

for (i in 1:n){
  data<-read.rwl(filepath[i])
  yrs<-rownames(data)
  corename<-colnames(data)
  # detrend zimb001 with spline
  data.rwi<-detrend(data,method='Spline',nyrs=30,f=0.5)
  # build a chronology
  data.crn<-chron(data.rwi,prefix='HUR',biweight = TRUE,prewhiten=TRUE)
  yrsnum<-yrs>=1901
  yrs2 <- yrs[yrsnum]
  nyrs<-length(yrs2)
  if (nyrs>=25){
    sitecode<-filenames[i]
    stringlength<-nchar(sitecode)
    sitestring<-substring(sitecode,1,stringlength-4)
    write.table(data.crn, paste(mainDir1, "africa/", sitestring, ".csv", sep=""), sep=",", col.names=TRUE, row.names= TRUE);
  }
}


# 2. Asia
rm(list=ls())
mainDir<-"/itrdb-v713-measurements/Asia/"
mainDir1<-"/chronologies_new/"
setwd(mainDir)
filenames<-dir(mainDir)
filepath<-sapply(filenames,function(x){
  paste(mainDir,x,sep='')
})

for (i in 1:n){
  data<-read.rwl(filepath[i]);
  yrs<-rownames(data)
  corename<-colnames(data)
  # detrend zimb001 with spline
  data.rwi<-detrend(data,method='Spline',nyrs=30,f=0.5)
  # build a chronology
  data.crn<-chron(data.rwi,prefix='HUR',biweight = TRUE,prewhiten=TRUE)
  # recaculate
  #data.trunc<-chron(detrend(data[data.crn$samp.depth>5,], method="Spline",nyrs=30,f=0.5),biweight = TRUE,prefix="HUR",prewhiten=TRUE)
  yrsnum<-yrs>=1901
  yrs2 <- yrs[yrsnum]
  nyrs<-length(yrs2)
  if (nyrs>=25){
    sitecode<-filenames[i]
    stringlength<-nchar(sitecode)
    sitestring<-substring(sitecode,1,stringlength-4)
    write.table(data.crn, paste(mainDir1, "Asia/", sitestring, ".csv", sep=""), sep=",", col.names=TRUE, row.names= TRUE);
  }
}


# 3. Austra-
rm(list=ls())
mainDir<-"/itrdb-v713-measurements/Australia/"
mainDir1<-"/chronologies_new/"
setwd(mainDir);
filenames<-dir(mainDir)
filepath<-sapply(filenames,function(x){
  paste(mainDir,x,sep='');
})

for (i in 1:n){
  data<-read.rwl(filepath[i]);
  yrs<-rownames(data)
  corename<-colnames(data)
  # detrend zimb001 with spline
  data.rwi<-detrend(data,method='Spline',nyrs=30,f=0.5)
  # build a chronology
  data.crn<-chron(data.rwi,prefix='HUR',biweight = TRUE,prewhiten=TRUE)
  yrsnum<-yrs>=1901
  yrs2 <- yrs[yrsnum]
  nyrs<-length(yrs2)
  if (nyrs>=25){
    sitecode<-filenames[i]
    stringlength<-nchar(sitecode)
    sitestring<-substring(sitecode,1,stringlength-4)
    write.table(data.crn, paste(mainDir1, "Australia/", sitestring, ".csv", sep=""), sep=",", col.names=TRUE, row.names= TRUE);
  }
}

# 4. europe
rm(list=ls())
mainDir<-"/itrdb-v713-measurements/europe/"
mainDir1<-"/chronologies_new/"
setwd(mainDir);
filenames<-dir(mainDir)
filepath<-sapply(filenames,function(x){
  paste(mainDir,x,sep='')
})

for (i in 1:n){
  data<-read.rwl(filepath[i])
  yrs<-rownames(data)
  corename<-colnames(data)
  # detrend zimb001 with spline
  data.rwi<-detrend(data,method='Spline',nyrs=30,f=0.5)
  # build a chronology
  data.crn<-chron(data.rwi,prefix='HUR',biweight = TRUE,prewhiten=TRUE)
  # recaculate
  #data.trunc<-chron(detrend(data[data.crn$samp.depth>5,], method="Spline",nyrs=30,f=0.5),biweight = TRUE,prefix="HUR",prewhiten=TRUE)
  yrsnum<-yrs>=1901
  yrs2 <- yrs[yrsnum]
  nyrss<-length(yrs2)
  if (nyrss>=25){
    sitecode<-filenames[i]
    stringlength<-nchar(sitecode)
    sitestring<-substring(sitecode,1,stringlength-4)
    write.table(data.crn, paste(mainDir1, "Europe/", sitestring, ".csv", sep=""), sep=",", col.names=TRUE, row.names= TRUE);
  }
}

# 5. southamerica
rm(list=ls())
mainDir<-"/itrdb-v713-measurements/southamerica/"
mainDir1<-"/chronologies_new/"
setwd(mainDir)
filenames<-dir(mainDir)
filepath<-sapply(filenames,function(x){
  paste(mainDir,x,sep='')
})

for (i in 1:n){
  data<-read.rwl(filepath[i])
  yrs<-rownames(data)
  corename<-colnames(data)
  # detrend zimb001 with spline
  data.rwi<-detrend(data,method='Spline',nyrs=30,f=0.5)
  # build a chronology
  data.crn<-chron(data.rwi,prefix='HUR',biweight = TRUE,prewhiten=TRUE)
  yrsnum<-yrs>=1901
  yrs2 <- yrs[yrsnum]
  nyrss<-length(yrs2)
  if (nyrss>=25){
    sitecode<-filenames[i]
    stringlength<-nchar(sitecode)
    sitestring<-substring(sitecode,1,stringlength-4)
    write.table(data.crn, paste(mainDir1, "Southamerica/", sitestring, ".csv", sep=""), sep=",", col.names=TRUE, row.names= TRUE);
  }
}

# 6. northamerica-canada
rm(list=ls())
mainDir<-"/itrdb-v713-measurements/northamerica/canada/"
mainDir1<-"/chronologies_new/"
setwd(mainDir);
filenames<-dir(mainDir)
filepath<-sapply(filenames,function(x){
  paste(mainDir,x,sep='');
})

for (i in 1:n){
  data<-read.rwl(filepath[i]);
  yrs<-rownames(data)
  corename<-colnames(data)
  # detrend zimb001 with spline
  data.rwi<-detrend(data,method='Spline',nyrs=30,f=0.5)
  # build a chronology
  data.crn<-chron(data.rwi,prefix='HUR',biweight = TRUE,prewhiten=TRUE)
  yrsnum<-yrs>=1901
  yrs2 <- yrs[yrsnum]
  nyrss<-length(yrs2)
  if (nyrss>=25){
    sitecode<-filenames[i]
    stringlength<-nchar(sitecode)
    sitestring<-substring(sitecode,1,stringlength-4)
    write.table(data.crn, paste(mainDir1, "northamerica/Canada/", sitestring, ".csv", sep=""), sep=",", col.names=TRUE, row.names= TRUE);
  }
}

# 7. northamerica-usa
rm(list=ls())
mainDir<-"/itrdb-v713-measurements/northamerica/usa/"
mainDir1<-"/chronologies_new/"
setwd(mainDir)
filenames<-dir(mainDir)
filepath<-sapply(filenames,function(x){
  paste(mainDir,x,sep='')
})

for (i in 1:n){
  data<-read.rwl(filepath[i])
  yrs<-rownames(data)
  corename<-colnames(data)
  # detrend zimb001 with spline
  data.rwi<-detrend(data,method='Spline',nyrs=30,f=0.5)
  # build a chronology
  data.crn<-chron(data.rwi,prefix='HUR',biweight = TRUE,prewhiten=TRUE)
  yrsnum<-yrs>=1901
  yrs2 <- yrs[yrsnum]
  nyrss<-length(yrs2)
  if (nyrss>=25){
    sitecode<-filenames[i]
    stringlength<-nchar(sitecode)
    sitestring<-substring(sitecode,1,stringlength-4)
    write.table(data.crn, paste(mainDir1, "northamerica/usa/", sitestring, ".csv", sep=""), sep=",", col.names=TRUE, row.names= TRUE);
  }
}

# 8. northamerica-mexico
rm(list=ls())
mainDir<-"/itrdb-v713-measurements/northamerica/mexico/"
mainDir1<-"/chronologies_new/"
setwd(mainDir)
filenames<-dir(mainDir)
filepath<-sapply(filenames,function(x){
  paste(mainDir,x,sep='')
})

for (i in 1:n){
  data<-read.rwl(filepath[i])
  yrs<-rownames(data)
  corename<-colnames(data)
  # detrend zimb001 with spline
  data.rwi<-detrend(data,method='Spline',nyrs=30,f=0.5)
  # build a chronology
  data.crn<-chron(data.rwi,prefix='HUR',biweight = TRUE,prewhiten=TRUE)
  yrsnum<-yrs>=1901
  yrs2 <- yrs[yrsnum]
  nyrss<-length(yrs2)
  if (nyrss>=25){
    sitecode<-filenames[i]
    stringlength<-nchar(sitecode)
    sitestring<-substring(sitecode,1,stringlength-4)
    write.table(data.crn, paste(mainDir1, "northamerica/mexico/", sitestring, ".csv", sep=""), sep=",", col.names=TRUE, row.names= TRUE);
  }
}


# 9. updates
rm(list=ls())
mainDir<-"/itrdb-v713-measurements/updates/rwl/"
mainDir1<-"/chronologies_new/"
setwd(mainDir)
filenames<-dir(mainDir)
filepath<-sapply(filenames,function(x){
  paste(mainDir,x,sep='')
})

for (i in 1:8){
  data<-read.rwl(filepath[i]);
  yrs<-rownames(data)
  corename<-colnames(data)
  # detrend zimb001 with spline
  data.rwi<-detrend(data,method='Spline',nyrs=30,f=0.5)
  # build a chronology
  data.crn<-chron(data.rwi,prefix='HUR',biweight = TRUE,prewhiten=TRUE)
  yrsnum<-yrs>=1901
  yrs2 <- yrs[yrsnum]
  nyrss<-length(yrs2)
  if (nyrss>=25){
    sitecode<-filenames[i]
    stringlength<-nchar(sitecode)
    sitestring<-substring(sitecode,1,stringlength-4)
    write.table(data.crn, paste(mainDir, sitestring, ".csv", sep=""), sep=",", col.names=TRUE, row.names= TRUE);
  }
}

#############################################################################################################################
rm(list=ls())
mainDir<-"/chronologies_new/Europe/"
setwd(mainDir)
filenames<-dir(mainDir)
num1<-length(filenames)
sitename<-array(NA,dim=c(num1,1))
for (i in 1:num1){
  sitecode<-filenames[i]
  stringlength<-nchar(sitecode)
  sitestring<-substring(sitecode,1,stringlength-4)
  sitename[i]<-sitestring
}
mainDir1<-"/chronologies_new/Basic information/";
write.table(sitename, paste(mainDir1, "Europe.csv", sep=""), sep=",", col.names=TRUE, row.names= TRUE);


rm(list=ls())
mainDir<-"/chronologies_new/northamerica/mexico/"
setwd(mainDir)
filenames<-dir(mainDir)
num1<-length(filenames)
sitename<-array(NA,dim=c(num1,1))
for (i in 1:num1){
  sitecode<-filenames[i]
  stringlength<-nchar(sitecode)
  sitestring<-substring(sitecode,1,stringlength-4)
  sitename[i]<-sitestring
}
mainDir1<-"/chronologies_new/Basic information/"
write.table(sitename, paste(mainDir1, "mexico.csv", sep=""), sep=",", col.names=TRUE, row.names= TRUE)

rm(list=ls())
mainDir<-"/chronologies_new/northamerica/usa/"
setwd(mainDir)
filenames<-dir(mainDir)
num1<-length(filenames)
sitename<-array(NA,dim=c(num1,1))
for (i in 1:num1){
  sitecode<-filenames[i]
  stringlength<-nchar(sitecode)
  sitestring<-substring(sitecode,1,stringlength-4)
  sitename[i]<-sitestring
}
mainDir<-"/chronologies_new/Basic information/"
write.table(sitename, paste(mainDir1, "usa.csv", sep=""), sep=",", col.names=TRUE, row.names= TRUE)
###########################################################################################################
## Metadata
library(openxlsx)
rm(list=ls())
mainDir<-"/chronologies_new/Basic information/"
setwd(mainDir)
filenames<-dir(mainDir)
num1<-length(filenames)
filepath<-sapply(filenames,function(x){
  paste(mainDir,x,sep='');
})

mainDir1<-"/chronologies_new/"
setwd(mainDir1)
filenames1<-dir(mainDir1)
filenames2<-filenames1[-4]
num2<-length(filenames2)
filepath1<-sapply(filenames2,function(x){
  paste(mainDir1,x,'/',sep='')
})
for (i in 1:num1){
  data<-read.xlsx(filepath[i])
  num3<-nrow(data)
  siteinfo<-data.frame(array(NA,dim=c(num3,5)))
  siteinfo[,1:3]<-data[,1:3]
  filenames3<-dir(filepath1[i])
  filepath2<-sapply(filenames3,function(x){
    paste(filepath1[i],x,sep='')
  })
  yrst<-array(NA,dim=c(num3,1))
  yred<-array(NA,dim=c(num3,1))
  for (i1 in 1:num3){
    data1<-read.csv(filepath2[i1])
    years<-row.names(data1)
    year1<-lapply(years,as.numeric)
    year2<-unlist(year1)
    year3<-c(as.matrix(year2))
    yrst[i1]<-year3[1]
    yred[i1]<-year3[length(year1)]
  }
  siteinfo[,4]<-yrst
  siteinfo[,5]<-yred
  colnames(siteinfo)<-c("Sitename","Latitude","Longitude","Start year","End year")
  sitecode<-filenames[i]
  stringlength<-nchar(sitecode)
  sitestring<-substring(sitecode,1,stringlength-5)
  write.table(siteinfo, paste("/TreeRing/SiteInfo/", sitestring,".csv", sep=""), sep=",", col.names=TRUE, row.names= TRUE)
}


###################################################################################################################################

