library(dplyr)

if(!file.exists("./data")) {dir.create("./data")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./data/UCIData.zip")
unzip("./data/UCIData.zip", exdir = "./data")


activityname <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
feature <- read.table("./data/UCI HAR Dataset/features.txt")
xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
sub_tr <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
sub_tes <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

names(xtrain) <- feature$V2
names(sub_tr) <- "Subject"
names(ytrain) <- "Activity"
xtrain <- cbind(sub_tr, xtrain)
xtrain <- cbind(ytrain, xtrain)

names(xtest) <- feature$V2
names(ytest) <- "Activity"
names(sub_tes) <- "Subject"
xtest <- cbind(sub_tes, xtest)
xtest <- cbind(ytest, xtest)

xmarged <- rbind(xtrain, xtest)

meanstd <- xmarged[grep("Activity|Subject|mean\\(\\)|std\\(\\)", colnames(xmarged))]

meanstd <- arrange(meanstd, Activity)
meanstd <- mutate(meanstd, Activity = as.character(factor(Activity, levels = 1:6, labels = activityname$V2)))

names(meanstd) <- gsub("\\(\\)","", names(meanstd))
names(meanstd) <- gsub("^t","Time", names(meanstd))
names(meanstd) <- gsub("-","", names(meanstd))
names(meanstd) <- gsub("std","Std", names(meanstd))
names(meanstd) <- gsub("mean","Mean", names(meanstd))
names(meanstd) <- gsub("^f","FFT", names(meanstd))

meanstd <- meanstd %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))

if(!file.exists("./data")) {dir.create("./data")}
write.table(meanstd, file = "./data/tidydataout.txt", row.names = FALSE)