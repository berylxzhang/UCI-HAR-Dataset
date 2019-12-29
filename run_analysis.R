
## Data download and unzip the folder
fileName <- "UCIdata.zip"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"

# File download verification. If file does not exist, download the file to working directory.
if(!file.exists(fileName)){
        download.file(url,fileName) 
}

# File unzip verification. If the directory does not exist, unzip the downloaded file.
if(!file.exists(dir)){
	unzip("UCIdata.zip", files = NULL, exdir=".")
}


## Read all the Data from the extracted file
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_testset <- read.table("UCI HAR Dataset/test/X_test.txt")
X_trainset <- read.table("UCI HAR Dataset/train/X_train.txt")
y_testset <- read.table("UCI HAR Dataset/test/y_test.txt")
y_trainset <- read.table("UCI HAR Dataset/train/y_train.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")  

## Analysis
#Step 1. Merges the training set and the test set to one data set.
dataSet <- rbind(X_trainset,X_testset)
# combine test and train of subject data and activity data, give descriptive lables
subject <- rbind(subject_train, subject_test)
names(subject) <- 'subjects'
activity <- rbind(y_trainset, y_testset)
names(activity) <- 'activities'

# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement in the dataset by subsetting only mean and std from data 
dataSet <- dataSet[,grep("mean()|std()", features[, 2])]


#Step 4. Appropriately labelling the dataset
CleanFeatureNames <- sapply(features[, 2], function(x) {gsub("[()]", "",x)}) # Create vector of "Clean" feature names by getting rid of "()".
names(dataSet) <- CleanFeatureNames[grep("mean()|std()", features[, 2])]
dataSet <- cbind(subject,activity, dataSet) # combine subject, activity, and mean and std only data set to create final data set.


#Step 3. Uses descriptive activity names to name the dataset activities
activity_group <- factor(dataSet$activities)
levels(activity_group) <- activity_labels[,2]
dataSet$activities <- activity_group


# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
if (!"reshape2" %in% installed.packages())  {   ####to check the existence of the package 
	install.packages("reshape2")
}
library("reshape2")

# Finally write the tidy data to the working directory in the name of "tidy_data"
primaryDataset <- melt(dataSet,(id.vars=c("subjects","activities")))
second_Dataset <- dcast(primaryDataset, subjects + activities ~ variable, mean)
names(second_Dataset)[-c(1:2)] <- paste("[mean of]" , names(second_Dataset)[-c(1:2)] )
write.table(second_Dataset, "tidy_data.txt", sep = ",",row.names=FALSE)
