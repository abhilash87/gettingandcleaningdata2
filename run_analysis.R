trainset<-read.table("C:/Users/Sony/MISSION DATA SCIENTIST/R working directory/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
testset<-read.table("C:/Users/Sony/MISSION DATA SCIENTIST/R working directory/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
trainact<-read.table("C:/Users/Sony/MISSION DATA SCIENTIST/R working directory/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
testact<-read.table("C:/Users/Sony/MISSION DATA SCIENTIST/R working directory/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
trainsub<-read.table("C:/Users/Sony/MISSION DATA SCIENTIST/R working directory/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
testsub<-read.table("C:/Users/Sony/MISSION DATA SCIENTIST/R working directory/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
features<-read.table("C:/Users/Sony/MISSION DATA SCIENTIST/R working directory/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
mergedset<-rbind(trainset,testset)
colnames(mergedset)<-features$V2
mergedsub<-rbind(trainsub,testsub)
names(mergedsub)<-"subject"
mergedact<-rbind(trainact,testact)
names(mergedact)<-"activity"
meancol<-colMeans(mergedset)
sdcol<-apply(mergedset,2,sd)
mergedset1<-cbind(mergedact,mergedset)
mergedset1$activity[mergedset1$activity==1]<-"WALKING"
mergedset1$activity[mergedset1$activity==2]<-"WALKING_UPSTAIRS"
mergedset1$activity[mergedset1$activity==3]<-"WALKING_DOWNSTAIRS"
mergedset1$activity[mergedset1$activity==4]<-"SITTING"
mergedset1$activity[mergedset1$activity==5]<-"STANDING"
mergedset1$activity[mergedset1$activity==6]<-"LAYING"
features<-read.table("C:/Users/Sony/MISSION DATA SCIENTIST/R working directory/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
names(mergedsub)<-"subject"
mergedset2<-cbind(mergedsub,mergedset1)
library(reshape2)
mergedset2melt<-melt(mergedset2,id<-c("subject","activity"))
mergedset2castsubject<-dcast(mergedset2melt,subject ~ variable,mean)
write.table(mergedset2castsubject,file="tidyset.txt",row.names=FALSE)