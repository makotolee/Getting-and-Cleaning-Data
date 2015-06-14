# Source of data for this project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# This R script does the following:

# 1. Merges the training and the test sets to create one data set.
rm(list=ls())
setwd("C:\\Users\\Brandon\\Desktop\\myproc\\Module 3\\UCI HAR Dataset")

temp1 <- read.table("train\\X_train.txt")
temp2 <- read.table("test\\X_test.txt")
X <- rbind(temp1, temp2)

temp1 <- read.table("train\\subject_train.txt")
temp2 <- read.table("test\\subject_test.txt")
S <- rbind(temp1, temp2)

temp1 <- read.table("train\\y_train.txt")
temp2 <- read.table("test\\y_test.txt")
Y <- rbind(temp1, temp2)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[,good_features]
names(X) <- features[good_features, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(S) <- "subject"
cleaned_data <- cbind(S, Y, X)
write.table(cleaned_data, "merged_clean_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(S)[,1]
numSubjects = length(unique(S)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned_data)[2]
result = cleaned_data[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
    for (a in 1:numActivities) {
        result[row, 1] = uniqueSubjects[s]
        result[row, 2] = activities[a, 2]
        tmp <- cleaned_data[cleaned_data$subject==s & cleaned_data$activity==activities[a, 2], ]
        result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
        row = row+1
    }
}
write.table(result, "data_set_with_the_averages_final.txt",row.names=FALSE)