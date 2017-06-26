
## Load dplyr package
library(dplyr)

## Download and unzip the data file
if(!file.exists("./data")) {dir.create("./data")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./data/UCIData.zip")
unzip("./data/UCIData.zip", exdir = "./data")

## Read data files
activityname <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
feature <- read.table("./data/UCI HAR Dataset/features.txt")
xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
sub_tr <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
sub_tes <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

## Add Column names in training data set 
names(xtrain) <- feature$V2
names(sub_tr) <- "Subject"
names(ytrain) <- "Activity"

## Combine the training data set
xtrain <- cbind(sub_tr, xtrain)
xtrain <- cbind(ytrain, xtrain)

## Add Column names in test data set
names(xtest) <- feature$V2
names(ytest) <- "Activity"
names(sub_tes) <- "Subject"

## Combine the test data set
xtest <- cbind(sub_tes, xtest)
xtest <- cbind(ytest, xtest)

## Marge training and test data sets
xmarged <- rbind(xtrain, xtest)

## Only select columns with mean() and std()
meanstd <- xmarged[grep("Activity|Subject|mean\\(\\)|std\\(\\)", colnames(xmarged))]

## Arrange data.frame according to Activity column
meanstd <- arrange(meanstd, Activity)

## Factor the Activity column and put labels from activityname 
meanstd <- mutate(meanstd, Activity = as.character(factor(Activity, levels = 1:6, labels = activityname$V2)))

## Descriptive variables
names(meanstd) <- gsub("\\(\\)","", names(meanstd))
names(meanstd) <- gsub("^t","Time", names(meanstd))
names(meanstd) <- gsub("-","", names(meanstd))
names(meanstd) <- gsub("std","Std", names(meanstd))
names(meanstd) <- gsub("mean","Mean", names(meanstd))
names(meanstd) <- gsub("^f","FFT", names(meanstd))

## Group the data.frame by Activity and Subject column and take mean
meanstd <- meanstd %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))

## Save text file
if(!file.exists("./data")) {dir.create("./data")}
write.table(meanstd, file = "./data/tidydataout.txt", row.names = FALSE)