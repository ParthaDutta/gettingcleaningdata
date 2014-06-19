options(stringsAsFactors = FALSE)
library(plyr)

# Part 0 - Download and store the file
# Download the file, unzip it
# create basedir, traindir and testdir variables to be used later
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "./dataset.zip", method = "curl")
unzip("./dataset.zip")
basedir <- paste("./", "UCI HAR Dataset", "/", sep = "")
traindir <- paste(basedir, "train/", sep = "")
testdir <- paste(basedir, "test/", sep = "")


# Part 1 - merge test and training datasets
# Get the metadata for the dataset
# Read all the activities and the feature sets
activity <- read.table( paste( basedir, "activity_labels.txt", sep = ""))
features <- read.table(paste(basedir,"features.txt", sep = "" ))
colnames(activity) <- c("id", "activity")

# Load the test data
# Read the data
# Data resides in mainly 3 files, activities and subjects in y_test and subject_test
# and measured data in x_test
xdata.test <- read.table(paste(testdir, "X_test.txt", sep = "" ))
ydata.test <- read.table(paste(testdir, "y_test.txt", sep = "" ))
subjects.test <- read.table(paste(testdir, "subject_test.txt", sep = "" ))

# combine the data to get all the variable in a single dataframe.
# combine the activity, subject and measured features data
# this is in the format subject, activity_id, features
testdata.raw <- cbind(subjects.test, ydata.test, xdata.test )

# Load the training dataset
# Read the data
# Data resides in mainly 3 files, activities and subjects in y_train and subject_train
# and measured data in x_train
xdata.train <- read.table(paste(traindir, "X_train.txt", sep = "" ) )
ydata.train <- read.table(paste(traindir, "y_train.txt", sep = "" ))
subjects.train <- read.table(paste(traindir, "subject_train.txt", sep = "" ))

# combine the data to get all the variable in a single dataframe.
# combine the activity, subject and measured features data
# this is in the format subject, activity_id, features
traindata.raw <- cbind(subjects.train, ydata.train, xdata.train )

# Merge both test and training raw datasets to form a consolidated raw dataset
data.raw <- rbind(testdata.raw, traindata.raw)


# Part 2 - get mean and standard deviation columns
# add the columns so that data is easy to play with
# keep only those columns that end with mean() or std()
names(data.raw) <- c("subject", "activity_id", features[, 2]) 
data.filter <- data.raw[, c(1, 2, grep("mean\\(\\)|std\\(\\)", names(data.raw)))]


# Part 3 - descriptive activity names to describe the activities in dataset
# merge the data with Activity data to get in the activity labels.
# dropping the activity column ( since activity name is there in the data)
data.final <- merge(activity, data.filter, by.x = "id", by.y = "activity_id", all = TRUE)
data.final$id <- NULL


# Part 4 - give proper labels to the columns
# t - Time (measurements )
# f - Frequency (measurements)
# Acc - Acceleration (measured by accelerometer)
# Gyro - Gyroscopic (measured by Gyroscope)
# Mag - Magnitude
# Remove duplicate Body in the label names, most likey typo in earlier dataset
# Remove () - This might cause problems if summaries are run
# Remove - - This might cause problems if summaries are run.
# mean - Mean (Capitalize to make it consistent)
# std - StandardDeviation ( std might be open to intepretation, so change it)
names(data.final) <- gsub("^t", "Time", names(data.final))
names(data.final) <- gsub("^f", "Frequency", names(data.final))
names(data.final) <- gsub("Acc", "Acceleration", names(data.final))
names(data.final) <- gsub("Gyro", "Gyroscopic", names(data.final))
names(data.final) <- gsub("Mag", "Magnitude", names(data.final))
names(data.final) <- gsub("BodyBody", "Body", names(data.final))
names(data.final) <- gsub("\\(\\)", "", names(data.final))
names(data.final) <- gsub("-", "\\.", names(data.final))
names(data.final) <- gsub("mean", "Mean", names(data.final))
names(data.final) <- gsub("std", "StandardDeviation", names(data.final))

# Part 5 - Average by activity by subject
# Do a groupwise average using the plyr package
# Change the column names to better describe the variables
data.group <- ddply(data.final, .(activity, subject), numcolwise(mean))
names(data.group)[c(-1, -2)] <- sapply(names(data.group)[c(-1, -2)], function(x) paste("Average", x, sep=""))

# Write the tidy dataset to the file.
write.table(data.group, "average-measurement-data.txt", sep = "," , row.names = FALSE, quote = FALSE)
