library(dplyr)
#------------------------------------#
#Clear environment
#------------------------------------#

rm(list=ls())

#------------------------------------#
#Define paths for Test and Train files
#------------------------------------#

testFiles <- c("./test/X_test.txt","./test/y_test.txt","./test/subject_test.txt")
trainFiles <- c("./train/X_train.txt","./train/y_train.txt","./train/subject_train.txt")

#------------------------------------#
#Read each file 
#1. Features
#2. X_test
#3. X_train
#4. y_test
#5. y_train
#6. subject_test
#7. subject_train
#8. activity_labels
#------------------------------------#

features <- read.csv("./features.txt",header=FALSE,sep="")

testSet <- read.csv(testFiles[1],header=FALSE,sep="")
trainSet <- read.csv(trainFiles[1],header=FALSE,sep="")

testLabels <- read.csv(testFiles[2],header=FALSE,sep="")
trainLabels <- read.csv(trainFiles[2],header=FALSE,sep="")

subTest <- read.csv(testFiles[3],header=FALSE,sep="")
subTrain <- read.csv(trainFiles[3],header=FALSE,sep="")

activity <- read.csv("./activity_labels.txt",header=FALSE,sep="")
names(activity) <- c("ID","activityName")

#------------------------------------#
#Merge Labels and Sets and rename 
#columns, such that they have 
#descriptive names
#------------------------------------#

test <- cbind(subTest,testLabels,testSet)
names(test) <- c("subject","activity",features$V2)

train <- cbind(subTrain,trainLabels,trainSet)
names(train) <- c("subject","activity",features$V2)

#------------------------------------#
#Merge Test and Train sets
#------------------------------------#

merged <- rbind(test,train)

#------------------------------------#
#Remove unnecessary files
#------------------------------------#
rm(list=setdiff(ls(),c("merged","activity")))

#------------------------------------#
#Extract only mean and std columns 
#------------------------------------#

merged <- merged[,c(1:2,grep("mean|std",names(merged)))]

#------------------------------------#
#Assign proper activity names 
#------------------------------------#

activities <- factor(merged$activity)
levels(activities) <- activity$activityName
merged$activity <- activities

#------------------------------------------------------------------------#
#merged is now a tidy data frame, with 10299 obs. and 81 variables.
#The first two columns refer to the subject doing the activity and the 
#second is the activity type. The rest of the columns are a type of data 
#that was measured during the study, such as Body Acceleration, and each 
#column is labeled with the respective name of the measurement
#------------------------------------------------------------------------#

#------------------------------------------------------------------------#
#2nd data set with average of each variable for each activity and for
#each subject
#------------------------------------------------------------------------#
library(reshape2)

melted <- melt(merged,id=c("activity","subject"))
cast <- dcast(melted,activity+subject~variable,mean)

#------------------------------------------------------------------------#
#Create file with the 2nd data set, called "tidy_data_step5.txt" in the
#working directory
#------------------------------------------------------------------------#

write.table(cast,"./tidy_data_step5.txt",row.names = FALSE)
