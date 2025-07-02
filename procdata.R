library(jsonlite)
library(tidyr)
library(ggplot2)

temp<-choose.files()
pt<-choose.dir()

files<-list.files(pt)

sumrt<-data.frame()
sumhit<-data.frame()

for (i in 1:length(files)){
  dat<-jsonlite::read_json(paste0(pt,'\\',files[i]), simplifyVector = TRUE)
  dat2<-dat[!is.na(dat$task),]
  datrt<-dat2[dat2$task=='response',]
  # datrt[1,]$rt<-NA
  
  sumrt[i,1]<-datrt[1,]$condition
  sumhit[i,1]<-datrt[1,]$condition
  sumrt[i,2]<-mean(datrt[datrt$cond==0 & datrt$correct,]$rt, na.rm=T)
  sumhit[i,2]<-length(datrt[datrt$cond==0 & datrt$correct,]$rt)/20
  sumrt[i,3]<-mean(datrt[datrt$cond==1 & datrt$correct,]$rt, na.rm=T)
  sumhit[i,3]<-length(datrt[datrt$cond==1 & datrt$correct,]$rt)/20
}
colnames(sumrt)<-c('condition','rt.consistent','rt.inconsistent')
colnames(sumhit)<-c('condition','hit.consistent','hit.inconsistent')

lrt<-pivot_longer(sumrt,cols=c('rt.consistent','rt.inconsistent'), names_prefix = 'rt.', values_to = 'rt')
lhit<-pivot_longer(sumhit,cols=c('hit.consistent','hit.inconsistent'), names_prefix = 'hit.', values_to = 'hit')

grt<-ggplot(data=lrt, aes(x=condition, y=rt, color=name))+geom_boxplot()+geom_jitter(width=0.1, height=0)
plot(grt)

ghit<-ggplot(data=lhit, aes(x=condition, y=hit, color=name))+geom_boxplot()+geom_jitter(width=0.1, height=0)
plot(ghit)
