#Downloading and unzipping dataset

if(!file.exists("C:/Users/Toshiba/Desktop/Getting And Cleaning Data")){dir.create("C:/Users/Toshiba/Desktop/Getting And Cleaning Data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="C:/Users/Toshiba/Desktop/Getting And Cleaning Data/Dataset.zip")
unzip(zipfile="C:/Users/Toshiba/Desktop/Getting And Cleaning Data/Dataset.zip", exdir="C:/Users/Toshiba/Desktop/Getting And Cleaning Data")

#Step-1 Merges the training and the test sets to create one data set

x_train <- read.table("C:/Users/Toshiba/Desktop/Getting And Cleaning Data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("C:/Users/Toshiba/Desktop/Getting And Cleaning Data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("C:/Users/Toshiba/Desktop/Getting And Cleaning Data/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("C:/Users/Toshiba/Desktop/Getting And Cleaning Data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("C:/Users/Toshiba/Desktop/Getting And Cleaning Data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("C:/Users/Toshiba/Desktop/Getting And Cleaning Data/UCI HAR Dataset/test/subject_test.txt")

features <- read.table('C:/Users/Toshiba/Desktop/Getting And Cleaning Data/UCI HAR Dataset/features.txt')

activity_labels<-read.table('C:/Users/Toshiba/Desktop/Getting And Cleaning Data/UCI HAR Dataset/activity_labels.txt')

colnames(x_train) <- features[,2]
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"
colnames(x_test) <- features[,2]
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"
colnames(activity_labels) <- c('activityId','activityType')
merge_train<-cbind(subject_train, y_train,  x_train)
View(merge_train)
merge_test<-cbind(subject_test, y_test,  x_test)
mergeAll<-rbind(merge_train, merge_test)
colnames(mergeAll) <- c("Subject","Activity", features[, 2] )

#Step-2 Extracts only the measurements on the mean and standard deviation for each measurement

colNames <- colnames(mergeAll)
mean_and_std <- (grepl("Subject" , colNames) |
                   grepl("Activity" , colNames) |
                   grepl("mean.." , colNames) |
                   grepl("std.." , colNames) )
MeanAndStd<-mergeAll[ , mean_and_std == TRUE]

#Step-3 Uses descriptive activity names to name the activities in the data set

MeanAndStd$Activity<-factor(MeanAndStd$Activity, levels=activity_labels[,1], labels=activity_labels[,2])

#Step-4 Appropriately labels the data set with descriptive variable names

MeanAndStdCols<-colnames(MeanAndStd)
MeanAndStdCols<-gsub("^f","FrequencyDomain",MeanAndStdCols)
MeanAndStdCols<-gsub("^t","TimeDomain",MeanAndStdCols)
MeanAndStdCols<-gsub("Acc","Accelerometer",MeanAndStdCols)
MeanAndStdCols<-gsub("Gyro","Gyroscope",MeanAndStdCols)
MeanAndStdCols<-gsub("Mag","Magnitude",MeanAndStdCols)
MeanAndStdCols<-gsub("Freq","Frequency",MeanAndStdCols)
MeanAndStdCols<-gsub("mean","Mean",MeanAndStdCols)
MeanAndStdCols<-gsub("std","StandardDeviation",MeanAndStdCols)
MeanAndStdCols<-gsub("-","",MeanAndStdCols)
colnames(MeanAndStd)<-MeanAndStdCols

library(dplyr)

MeanAndStdAverage<-MeanAndStd%>%group_by(Subject,Activity)%>%summarise_each(funs(mean))

write.table(MeanAndStdAverage,"C:/Users/Toshiba/Desktop/Getting And Cleaning Data/MeanAndStdAverage.txt",row.names= FALSE)

