## Getting and Cleaning Data Coursera Project

### Data Desription and Source

The data provided for the project is about wearable computing. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

**Original Data Source** - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

**Data provided for the project** - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Methodology for the Data Analysis.

The Data analysis was done while adhering to the principles of reproducible research. The entire analysis is done using R script and is automated, starting from downloading data to extracting the archive file to executing all the analysis steps and finally creating a tidy dataset file. All the code is in _**run_analysis.R**_ script file.

Having said that, not everything in R is similar across different operating systems. Things like path and filename conventions, supported downloading schemes different with different operating systems. Steps have been taken to overcome those issues like using relative path schemes etc. However, due to unavailability of environments, these steps have been tested only on Ubuntu 13.10 linux system. In order to truly reproduce this research, some minor modifications might be required to the code. Another caveat is that the file download, due to the size of the file sometimes times out. This step might need to be repeated as well. 

This analysis also uses plyr package.

### System Details :
* Ubuntu Linux- version 13.10
* R - Version 3.1.0
* RStudio - Version 0.98.501 

### Script and Output files
* **run_analysis.R** - This R script contains all the analysis code. As mentioned earlier, the entire analysis can be reproduced by running this script starting from downloading the files getting the tidy data file as output.
* **average-measurement-data.txt** - This file contains the groupwise average data for each activity by subject. This is a tidy dataset.

### Data Analysis Process
Data Analysis was done following though these steps.

#### Step 0 - Download the data.
Data was downloaded. The downloaded archive was then programatically unzipped. The directory structure of the extracted files is as show below.

**BASE DIR** - UCI HAR Dataset/ - This directory stores all the meta files that describle the data. Important files besides the Readme, that were considered for analysis were

* activity_labels.txt - This file consistes of all the activities for which measurements were taken and its description.

* features.txt - This file lists all the different types of measurements that were taken for the activities. These measurement variables are called features.

* feature_info.txt - This file describes all the features mentioned in the features files.

The entire dataset was split into test dataset and training dataset. Hence their file structures are similar, except training set has higher number of observations. Hence only the training dataset will be described. Test data set is similar.

**TRAIN DIR** -  UCI HAR Dataset/train - This directory consists of all the training data oinbservations. Following files have been considered for analysis

* X_train - This file contains the measurements that were taken. Each columns in the file corresponds to a feature as described earlier. Thus the number of columns in this data file is same as the number of features descibed in the features file.

* y_train - This files consists of all the activities against which measurements were taken. Thus number of observations in this file is same as number of observtions in the data file.
 
* subject_train - This file consists of all the subjects who were involved in the experiment. Thus number of rows in this file is same as number of rows in y_train file and also in the data file.

#### Step 1 : Read and merge the test and training datasets.

The structure of the data in training and test datasets is as described in the image:

![Data Structure](https://github.com/iarrup/gettingcleaningdata/blob/master/images/data-structure.png?raw=true)


The first column is subject, then activity that the subjects performed and then followed by all the measurements for each combination.
In order to get a consolidate set of data, first subject_xxxx.txt, y_xxxx.txt and X_xxxx.txt are stacked columnwise using cbind function for both test and training sets

Then both the training and test sets are stacked rowwise using rbind.

Following were the dimensions of each of the datasets

|Dataset              | rows | columns | Details                            |
|---------------------|------|---------|------------------------------------|
| activity_labels.txt |  6   | 2       | Activities and desriptions         |
| features.txt        | 561  | 2       | Features names                     |
| X_test.txt          | 2947 | 561     | Test Measurement Data              |
| y_test.txt          | 2947 | 1       | Test Activity Data                 |
| subject_test.txt    | 2947 | 1       | Test Subject data                  |
| testdata.raw        | 2947 | 563     | Consolidated test data             |
| X_train.txt         | 7352 | 561     |Test Measurement Data               |
| y_train.txt         | 7352 | 1       |Test Activity Data                  |
| subject_train.txt   | 7352 | 1       |Test Subject data                   |
| traindata.raw       | 7352 | 563     |Consolidated test data              |
| data.raw            | 10299| 563     | Consolidated test and training data|


#### Step 2 - Get mean and standard deviation columns
Some of the features consist of mean and standard deviation calculations. These features have mean() and std() in them. The columns having these descriptions have been retained.

Vectors with MeanFreq have been dropped as they are weighted averages.

Vectors with GravityMean, tBodyAccMean etc are dropped as these are created by directly averaging the signals and are not true mean calculations.

The data in features files has been used to create the columnnames for for the data variables. First column is subject and second is activity_id. grep function has been used to filter all the mean and std columns

|Dataset              | rows | columns | Details                               |
|---------------------|------|---------|---------------------------------------|
| data.filter         | 10299| 68      | Columns filtered for mean() and std() |


#### Step 3 - Descriptive labels for activities
Currently the dataset consists only of activity code. In order to clearly descibe the activities, this table was merged with activity table to pull in the activity descriptions.

activity_id column was dropped since activity descriptions are already there now.

|Dataset              | rows | columns | Details                               |
|---------------------|------|---------|---------------------------------------|
| data.final          | 10299| 68      | Activity description included         |


#### Step 4 - give proper labels to the columns
Since the columns are not descriptive and some of them not valid R column names, column names were altered to make them more desciptive. make.names() function was used to check the validity of the names and gsub was used to automate the alterations. Following changes were made -

* t - Time ( Time based measurements )
* f - Frequency ( Frequency based measurements)
* Acc - Acceleration (measured by accelerometer)
* Gyro - Gyroscopic (measured by Gyroscope)
* Mag - Magnitude
* Remove duplicate Body in the label names, most likey typo in earlier dataset
* Remove () - This is invalid character for column name, might cause problems if summaries are run
* Remove "-" - This is invalid character for column name, might cause problems if summaries are run.
* mean - Mean (Capitalize to make it consistent with Camel Case)
* std - StandardDeviation ( std might be open to intepretation, so changed it to make it fully descriptive)


#### Step 5 - Create a tidy dataset which has feature averages for each subject by each activity.
Groupwise average was done using ddply function in the plyr package. After that the column names were altered to better describe the measurement, in this case, since all features were averaged, Average was added in front of all the column names.

ddply function was used as it is a tidy data function. It takes in a data frame as input and produces a data frame as output. 

This data produced is a tidy dataset. Along with activity and subject, each of the feature measurements is in one column. Each of the observation ( for each subject by activity ) is in a single row. The data also deals with the single subject. This then follows all the tidy dataset principles.

|Dataset              | rows | columns | Details                                  |
|---------------------|------|---------|------------------------------------------|
| data.group          | 180  | 68      | Groupwise average by activity by subject |


After this, a data file 'average-measurement-data.txt' consisting of tidy dataset was created. This file is a comma separated file ( csv format ) with a txt extensions.

The **Codebook** for the dataset can be found [here](https://github.com/iarrup/gettingcleaningdata/blob/master/Codebook.md)
