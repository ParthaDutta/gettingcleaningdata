
## Data description

### Feature Set
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern: 
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

_**As a part of this project, data was transformed to inlude the average of all the mean and standard deviation statistics.**_

### Subjects:
There were 30 subjects in all who were inluded in the experiment. The subjects are numbered from 1 to 30

### Activities:
There were 6 activities that each of the subjects were measured for. The values are 

* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

### Data Structure
This image describes the data structure

![Data Structure](https://github.com/iarrup/gettingcleaningdata/blob/master/images/data-structure.png?raw=true)

## Transformations
Following transformations were done to the data.
* column wise stack y_xxxx.txt, x_xxxx.txt and subject_xxx.txt using cbind for both training and test dataset ( xxxx = test / train). This gives consolidated data for both training and test dataset.
* row wise stack test and training data using rbind. This gives complete dataset.
* Extract out mean and strandard deviation features ( with mean() and std() ).
* merge data in activity_labels.txt to the previously created dataset go get desciptive activities
* Do a groupwise average of the features by activity by subject using ddply.

Complete details of transformations along with the code is given in run_analysis.R

## Variable description

Columns were named to as descriptive as possible. In general, the variable names denoting the features follow the following convention and as an example AverageTimeBodyAccelerationJerk.Mean.X expands to :

|Summary | Domain        | Signal Types | Sensor                  | velocity type       |   Statistics            | Axis     |
|--------|---------------|--------------|-------------------------|---------------------|-------------------------|----------|
|Average |Time/Frequency | Body/Gravity | Acceleration/Gyroscopic | Jerk / Magnitude    | Mean/Standard Deviation | X/Y/Z    |
|Average | Time          | Body         | Acceleration            | Jerk                | Mean                    | X        |

There is the complete list of all the variables. Measurements are normalized by dividing them by their range, they are all between -1 and 1 and do not have units ( units got cancelled by dividing)

| Variables  | Description and Values |
|------------|------------------------|
|activity                                                       | Described in activity section| 
|subject                                                        | 1 to 30 |
|AverageTimeBodyAcceleration.Mean.X                             | -1 to 1 |
|AverageTimeBodyAcceleration.Mean.Y                             | -1 to 1 | 
|AverageTimeBodyAcceleration.Mean.Z                             | -1 to 1 |
|AverageTimeBodyAcceleration.StandardDeviation.X                | -1 to 1 | 
|AverageTimeBodyAcceleration.StandardDeviation.Y                | -1 to 1 | 
|AverageTimeBodyAcceleration.StandardDeviation.Z                | -1 to 1 | 
|AverageTimeGravityAcceleration.Mean.X                          | -1 to 1 | 
|AverageTimeGravityAcceleration.Mean.Y                          | -1 to 1 | 
|AverageTimeGravityAcceleration.Mean.Z                          | -1 to 1 | 
|AverageTimeGravityAcceleration.StandardDeviation.X             | -1 to 1 |
|AverageTimeGravityAcceleration.StandardDeviation.Y             | -1 to 1 |
|AverageTimeGravityAcceleration.StandardDeviation.Z             | -1 to 1 |
|AverageTimeBodyAccelerationJerk.Mean.X                         | -1 to 1 |
|AverageTimeBodyAccelerationJerk.Mean.Y                         | -1 to 1 |
|AverageTimeBodyAccelerationJerk.Mean.Z                         | -1 to 1 | 
|AverageTimeBodyAccelerationJerk.StandardDeviation.X            | -1 to 1 |
|AverageTimeBodyAccelerationJerk.StandardDeviation.Y            | -1 to 1 |
|AverageTimeBodyAccelerationJerk.StandardDeviation.Z            | -1 to 1 |
|AverageTimeBodyGyroscopic.Mean.X                               | -1 to 1 | 
|AverageTimeBodyGyroscopic.Mean.Y                               | -1 to 1 | 
|AverageTimeBodyGyroscopic.Mean.Z                               | -1 to 1 | 
|AverageTimeBodyGyroscopic.StandardDeviation.X                  | -1 to 1 | 
|AverageTimeBodyGyroscopic.StandardDeviation.Y                  | -1 to 1 | 
|AverageTimeBodyGyroscopic.StandardDeviation.Z                  | -1 to 1 | 
|AverageTimeBodyGyroscopicJerk.Mean.X                           | -1 to 1 | 
|AverageTimeBodyGyroscopicJerk.Mean.Y                           | -1 to 1 | 
|AverageTimeBodyGyroscopicJerk.Mean.Z                           | -1 to 1 | 
|AverageTimeBodyGyroscopicJerk.StandardDeviation.X              | -1 to 1 |
|AverageTimeBodyGyroscopicJerk.StandardDeviation.Y              | -1 to 1 |
|AverageTimeBodyGyroscopicJerk.StandardDeviation.Z              | -1 to 1 |
|AverageTimeBodyAccelerationMagnitude.Mean                      | -1 to 1 |
|AverageTimeBodyAccelerationMagnitude.StandardDeviation         | -1 to 1 |
|AverageTimeGravityAccelerationMagnitude.Mean                   | -1 to 1 |
|AverageTimeGravityAccelerationMagnitude.StandardDeviation      | -1 to 1 |
|AverageTimeBodyAccelerationJerkMagnitude.Mean                  | -1 to 1 |
|AverageTimeBodyAccelerationJerkMagnitude.StandardDeviation     | -1 to 1 |
|AverageTimeBodyGyroscopicMagnitude.Mean                        | -1 to 1 |
|AverageTimeBodyGyroscopicMagnitude.StandardDeviation           | -1 to 1 |
|AverageTimeBodyGyroscopicJerkMagnitude.Mean                    | -1 to 1 |
|AverageTimeBodyGyroscopicJerkMagnitude.StandardDeviation       | -1 to 1 |
|AverageFrequencyBodyAcceleration.Mean.X                        | -1 to 1 |
|AverageFrequencyBodyAcceleration.Mean.Y                        | -1 to 1 |
|AverageFrequencyBodyAcceleration.Mean.Z                        | -1 to 1 |
|AverageFrequencyBodyAcceleration.StandardDeviation.X           | -1 to 1 |
|AverageFrequencyBodyAcceleration.StandardDeviation.Y           | -1 to 1 |
|AverageFrequencyBodyAcceleration.StandardDeviation.Z           | -1 to 1 |
|AverageFrequencyBodyAccelerationJerk.Mean.X                    | -1 to 1 |
|AverageFrequencyBodyAccelerationJerk.Mean.Y                    | -1 to 1 |
|AverageFrequencyBodyAccelerationJerk.Mean.Z                    | -1 to 1 |
|AverageFrequencyBodyAccelerationJerk.StandardDeviation.X       | -1 to 1 |
|AverageFrequencyBodyAccelerationJerk.StandardDeviation.Y       | -1 to 1 |
|AverageFrequencyBodyAccelerationJerk.StandardDeviation.Z       | -1 to 1 |
|AverageFrequencyBodyGyroscopic.Mean.X                          | -1 to 1 |
|AverageFrequencyBodyGyroscopic.Mean.Y                          | -1 to 1 |
|AverageFrequencyBodyGyroscopic.Mean.Z                          | -1 to 1 |
|AverageFrequencyBodyGyroscopic.StandardDeviation.X             | -1 to 1 |
|AverageFrequencyBodyGyroscopic.StandardDeviation.Y             | -1 to 1 |
|AverageFrequencyBodyGyroscopic.StandardDeviation.Z             | -1 to 1 |
|AverageFrequencyBodyAccelerationMagnitude.Mean                 | -1 to 1 |
|AverageFrequencyBodyAccelerationMagnitude.StandardDeviation    | -1 to 1 |
|AverageFrequencyBodyAccelerationJerkMagnitude.Mean             | -1 to 1 |
|AverageFrequencyBodyAccelerationJerkMagnitude.StandardDeviation| -1 to 1 |
|AverageFrequencyBodyGyroscopicMagnitude.Mean                   | -1 to 1 |
|AverageFrequencyBodyGyroscopicMagnitude.StandardDeviation      | -1 to 1 |
|AverageFrequencyBodyGyroscopicJerkMagnitude.Mean               | -1 to 1 |
|AverageFrequencyBodyGyroscopicJerkMagnitude.StandardDeviation  | -1 to 1 |
