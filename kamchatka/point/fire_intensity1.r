#bp解析用
library(doBy)
library(dplyr)
library(spatstat)

motofire<-read.csv("fire_maiboku.csv", fileEncoding = "UTF-8-BOM")
fire_sprout1<-read.csv("fire_bp_sprout.csv", fileEncoding = "UTF-8-BOM")
fire1<-motofire
fire1$xx<-as.numeric(fire1$grid..x.)+as.numeric(as.character(fire1$x))
fire1$yy<-as.numeric(fire1$grid..y.)+as.numeric(as.character(fire1$y))
fire1$DBH00cm[is.na(fire1$DBH00cm)]<-0
fire1$GBH00cmn[is.na(fire1$GBH00cmn)]<-0
fire1$dbh0<-as.numeric(fire1$DBH00cm)+as.numeric(fire1$GBH00cmn)/acos(-1)
fire1$da<-0
fire1$da[fire1$D.A..2000.=="A"]<-1
#fire1<-subset(fire1,fire1$sp.=="La")
#fire1<-subset(fire1,fire1$dbh0>20)
fire1<-subset(fire1,fire1$dbh0<=10)

fire2<-subset(fire1,fire1$da==0)

pppfire1<-ppp(fire1$xx,fire1$yy,window=owin(c(0,90),c(0,100)),marks=fire1$D.A..2000.)
denfire1<-density(pppfire1)
pppfire2<-ppp(fire2$xx,fire2$yy,window=owin(c(0,90),c(0,100)),marks=fire2$D.A..2000.)
denfire2<-density(pppfire2)
#denfire2/denfire1
plot(denfire1)
plot(denfire2)
plot(denfire2/denfire1)
