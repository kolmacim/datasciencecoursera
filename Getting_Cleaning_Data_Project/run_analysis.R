######Getting and cleaning data COURSE PROJECT
library(dplyr)
rm(list=ls())

#Data were downloaded and extracted
setwd("C:/Users/KOLMACIM/Desktop/FTS/COURSERA_DATA_SCIENCE/3_Getting_and_Cleaning_Data/project")

#Loading data
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE, col.names = c("ActivityId", "Activity"))
features <- read.table("./UCI HAR Dataset/features.txt", colClasses = c("character"), header = FALSE)

subjectTrain <- read.table('./UCI HAR Dataset/train/subject_train.txt',header = FALSE)
xTrain       <- read.table('./UCI HAR Dataset/train/x_train.txt',header = FALSE)
yTrain       <- read.table('./UCI HAR Dataset/train/y_train.txt',header = FALSE)

subjectTest <- read.table('./UCI HAR Dataset/test/subject_test.txt',header = FALSE)
xTest       <- read.table('./UCI HAR Dataset/test/x_test.txt',header = FALSE)
yTest       <- read.table('./UCI HAR Dataset/test/y_test.txt',header = FALSE)


## 1. Merges the training and the test sets to create one data set.
dataTrain <- cbind(cbind(xTrain, subjectTrain), yTrain)
dataTest <- cbind(cbind(xTest, subjectTest), yTest)

dataAll <- rbind(dataTrain, dataTest)

#Put labels on dataAll
labels_dataAll <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))
names(dataAll) <- labels_dataAll[,2]


## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
dataAll_mean_std <- dataAll[,grepl("mean|std|Subject|ActivityId", names(dataAll))]


## 3. Uses descriptive activity names to name the activities in the data set
dataAll_mean_std <- merge(dataAll_mean_std,activityLabels,by='ActivityId',all.x=TRUE)


## 4. Appropriately labels the data set with descriptive variable names.
names(dataAll_mean_std) <- gsub('Acc',"Acceleration",names(dataAll_mean_std))
names(dataAll_mean_std) <- gsub('Mag',"Magnitude",names(dataAll_mean_std))

names(dataAll_mean_std) <- gsub('\\(|\\)',"",names(dataAll_mean_std))
names(dataAll_mean_std) <- gsub('mean',"_Mean",names(dataAll_mean_std))
names(dataAll_mean_std) <- gsub('std',"_StandardDeviation",names(dataAll_mean_std))
names(dataAll_mean_std) <- gsub('-',"",names(dataAll_mean_std))

names(dataAll_mean_std) <- gsub("^t","Time_",names(dataAll_mean_std))
names(dataAll_mean_std) <- gsub("^f","Frequency_",names(dataAll_mean_std))

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
dataAll_tidy_mean <- dataAll_mean_std %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))

write.table(dataAll_tidy_mean, file = "Sensor_data_tidy.txt", row.name=FALSE)
