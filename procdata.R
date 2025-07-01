library(jsonlite)

pt<-choose.dir(default="")

files<-list.files(pt)

sumdata<-data.frame()

for (i in 1:length(files)){
  dat<-jsonlite::read_json(paste0(pt,'\\',files[i]), simplifyVector = TRUE)
  dat2<-dat[!is.na(dat$task),]
  datrt<-dat2[dat2$task=='response',]
  
  sumdat[i,1]<-datrt[1,]$condition
  sumdat[i,2]<-mean(datrt[datrt$cond==0 & datrt$correct,]$rt)
  sumdat[i,3]<-length(datrt[datrt$cond==0 & datrt$correct,]$rt)/20
  sumdat[i,4]<-mean(datrt[datrt$cond==1 & datrt$correct,]$rt)
  print(length(datrt[datrt$cond==1 & datrt$correct,]$rt)/20)
  print()
}
