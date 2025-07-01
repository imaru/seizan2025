library(ggplot2)
library(tidyr)

df<-file.choose()
dat<-read.csv(df, header = T)
dat<-dat[3:nrow(dat),]
cdat<-dat[,c(18,19,20)]
rtdat<-dat[,c(18,21,22)]
colnames(cdat)<-c('cnd','consist','inconsist')
colnames(rtdat)<-c('cnd','consist','inconsist')
cdat[cdat==0]<-'NA'
rtdat[rtdat==0]<-'NA'

lcdat<-pivot_longer(cdat, cols=c('consist','inconsist'))
lrtdat<-pivot_longer(rtdat, cols=c('consist','inconsist'))
lcdat$value<-as.numeric(lcdat$value)
lrtdat$value<-as.numeric(lrtdat$value)

hitg<-ggplot(data=lcdat, aes(x=cnd,y=value, color=name))+geom_boxplot(na.rm=T)+geom_jitter(na.rm=T, height=0, width=0.1)
plot(hitg)

rtg<-ggplot(data=lrtdat, aes(x=cnd,y=value, color=name))+geom_boxplot(na.rm=T)+geom_jitter(na.rm=T,height=0, width=0.1)
plot(rtg)