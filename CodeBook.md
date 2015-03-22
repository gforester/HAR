---
title: "CodeBook"
author: "George F"
date: "March 21, 2015"
 
---
# Code Book

This document described the variables and any transformation performed to the UCI HAR Dataset files to achieve an output tidy dataset. A Tidy dataset is defined as:

* Each variable you measure should be in one column
* Each different observation of that variable should be in a different row
* There should be one table for each "kind" of variable
* If you have multiple tables, they should include a column in the table that allows them to be linked

Some other important tips

* Include a row at the top of each file with variable names.
* Make variable names human readable AgeAtDiagnosis instead of AgeDx
* In general data should be saved in one file per table.

#Initial data files came from UCI HAR Dataset folder

The folder includes the following files:

* 'README.txt'
*  'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Notes: 

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

# Data Transformation and data clean up for each file

**activity_labels.txt**
Created two column variables

* IDAct - identifier field. Type: Integer
* activities - activities variable is included in the final dataset. Type: chr


| IDAct|activity           |
|-----:|:------------------|
|     1|WALKING            |
|     2|WALKING_UPSTAIRS   |
|     3|WALKING_DOWNSTAIRS |
|     4|SITTING            |
|     5|STANDING           |
|     6|LAYING             |

** features.txt file. **
Created two column variable: "id", "featureVariable"
Updated the feature names to be more human readable and replace the characters ()-.  I found that these characters are not valid in column names. In initial debugging they were replaced with "." A character vector, __featureColnames__ is generated and used in the read.file col.names parameter. This eliminated the requirement to rename the default V1 to V561 column names. The following code updated feature names. 

```
featureColnames <- featureV %>%
        gsub(pattern = "[\\-\\,\\()\\()-]", replacement = "_") %>%
        gsub(pattern = "[_]{2,3}", replacement = "_") %>%
        gsub(pattern = "_$", replacement = "") %>%
        gsub(pattern = "Acc", replacement = "Acceleration") %>%
        gsub(pattern = "^f", replacement = "freq") %>%
        gsub(pattern = "^t", replacement = "time") %>%
        gsub(pattern = "Mag", replacement ="Magnitude")
```
Reduced the variables (columns) from test/X_txt.txt and train/X_train.txt from 561 to 66 variables with the following code:

```
trainsetMeanStd <- trainset %>%
        dplyr::select(matches("_mean_|_std_|mean$|std$", ignore.case=FALSE))
        
testsetMeanStd <- testset %>%
        dplyr::select(matches("_mean_|_std_|mean$|std$", ignore.case=FALSE))
```
Table one displays the original feature names and the updated feature names
 


|OriginalFeatureVariables    |TransformFeatureVariables                  |
|:---------------------------|:------------------------------------------|
|tBodyAcc-mean()-X           |timeBodyAcceleration_mean_X                |
|tBodyAcc-mean()-Y           |timeBodyAcceleration_mean_Y                |
|tBodyAcc-mean()-Z           |timeBodyAcceleration_mean_Z                |
|tBodyAcc-std()-X            |timeBodyAcceleration_std_X                 |
|tBodyAcc-std()-Y            |timeBodyAcceleration_std_Y                 |
|tBodyAcc-std()-Z            |timeBodyAcceleration_std_Z                 |
|tGravityAcc-mean()-X        |timeGravityAcceleration_mean_X             |
|tGravityAcc-mean()-Y        |timeGravityAcceleration_mean_Y             |
|tGravityAcc-mean()-Z        |timeGravityAcceleration_mean_Z             |
|tGravityAcc-std()-X         |timeGravityAcceleration_std_X              |
|tGravityAcc-std()-Y         |timeGravityAcceleration_std_Y              |
|tGravityAcc-std()-Z         |timeGravityAcceleration_std_Z              |
|tBodyAccJerk-mean()-X       |timeBodyAccelerationJerk_mean_X            |
|tBodyAccJerk-mean()-Y       |timeBodyAccelerationJerk_mean_Y            |
|tBodyAccJerk-mean()-Z       |timeBodyAccelerationJerk_mean_Z            |
|tBodyAccJerk-std()-X        |timeBodyAccelerationJerk_std_X             |
|tBodyAccJerk-std()-Y        |timeBodyAccelerationJerk_std_Y             |
|tBodyAccJerk-std()-Z        |timeBodyAccelerationJerk_std_Z             |
|tBodyGyro-mean()-X          |timeBodyGyro_mean_X                        |
|tBodyGyro-mean()-Y          |timeBodyGyro_mean_Y                        |
|tBodyGyro-mean()-Z          |timeBodyGyro_mean_Z                        |
|tBodyGyro-std()-X           |timeBodyGyro_std_X                         |
|tBodyGyro-std()-Y           |timeBodyGyro_std_Y                         |
|tBodyGyro-std()-Z           |timeBodyGyro_std_Z                         |
|tBodyGyroJerk-mean()-X      |timeBodyGyroJerk_mean_X                    |
|tBodyGyroJerk-mean()-Y      |timeBodyGyroJerk_mean_Y                    |
|tBodyGyroJerk-mean()-Z      |timeBodyGyroJerk_mean_Z                    |
|tBodyGyroJerk-std()-X       |timeBodyGyroJerk_std_X                     |
|tBodyGyroJerk-std()-Y       |timeBodyGyroJerk_std_Y                     |
|tBodyGyroJerk-std()-Z       |timeBodyGyroJerk_std_Z                     |
|tBodyAccMag-mean()          |timeBodyAccelerationMagnitude_mean         |
|tBodyAccMag-std()           |timeBodyAccelerationMagnitude_std          |
|tGravityAccMag-mean()       |timeGravityAccelerationMagnitude_mean      |
|tGravityAccMag-std()        |timeGravityAccelerationMagnitude_std       |
|tBodyAccJerkMag-mean()      |timeBodyAccelerationJerkMagnitude_mean     |
|tBodyAccJerkMag-std()       |timeBodyAccelerationJerkMagnitude_std      |
|tBodyGyroMag-mean()         |timeBodyGyroMagnitude_mean                 |
|tBodyGyroMag-std()          |timeBodyGyroMagnitude_std                  |
|tBodyGyroJerkMag-mean()     |timeBodyGyroJerkMagnitude_mean             |
|tBodyGyroJerkMag-std()      |timeBodyGyroJerkMagnitude_std              |
|fBodyAcc-mean()-X           |freqBodyAcceleration_mean_X                |
|fBodyAcc-mean()-Y           |freqBodyAcceleration_mean_Y                |
|fBodyAcc-mean()-Z           |freqBodyAcceleration_mean_Z                |
|fBodyAcc-std()-X            |freqBodyAcceleration_std_X                 |
|fBodyAcc-std()-Y            |freqBodyAcceleration_std_Y                 |
|fBodyAcc-std()-Z            |freqBodyAcceleration_std_Z                 |
|fBodyAccJerk-mean()-X       |freqBodyAccelerationJerk_mean_X            |
|fBodyAccJerk-mean()-Y       |freqBodyAccelerationJerk_mean_Y            |
|fBodyAccJerk-mean()-Z       |freqBodyAccelerationJerk_mean_Z            |
|fBodyAccJerk-std()-X        |freqBodyAccelerationJerk_std_X             |
|fBodyAccJerk-std()-Y        |freqBodyAccelerationJerk_std_Y             |
|fBodyAccJerk-std()-Z        |freqBodyAccelerationJerk_std_Z             |
|fBodyGyro-mean()-X          |freqBodyGyro_mean_X                        |
|fBodyGyro-mean()-Y          |freqBodyGyro_mean_Y                        |
|fBodyGyro-mean()-Z          |freqBodyGyro_mean_Z                        |
|fBodyGyro-std()-X           |freqBodyGyro_std_X                         |
|fBodyGyro-std()-Y           |freqBodyGyro_std_Y                         |
|fBodyGyro-std()-Z           |freqBodyGyro_std_Z                         |
|fBodyAccMag-mean()          |freqBodyAccelerationMagnitude_mean         |
|fBodyAccMag-std()           |freqBodyAccelerationMagnitude_std          |
|fBodyBodyAccJerkMag-mean()  |freqBodyBodyAccelerationJerkMagnitude_mean |
|fBodyBodyAccJerkMag-std()   |freqBodyBodyAccelerationJerkMagnitude_std  |
|fBodyBodyGyroMag-mean()     |freqBodyBodyGyroMagnitude_mean             |
|fBodyBodyGyroMag-std()      |freqBodyBodyGyroMagnitude_std              |
|fBodyBodyGyroJerkMag-mean() |freqBodyBodyGyroJerkMagnitude_mean         |
|fBodyBodyGyroJerkMag-std()  |freqBodyBodyGyroJerkMagnitude_std          |

Each training file below has 7352 observations and each test file has 2947 observations. The training subject file has 21 subjects and the test subject file has 9 subjects.

-  train/X_train.txt': Training set.
-  train/y_train.txt': Training labels.
-  train/subject_train.txt
-  test/X_test.txt': Test set.
-  test/y_test.txt': Test labels.
-  test/subject_train.txt

**Subject files**
 
train/subject_train.txt - single column table. Created column variable IDSub

**train/X_train.txt': Training set, and test/X_test.txt': Test set.**
The column names for these files are generated when the data is read using the 
col.name parameter. 
```
testset <- read.table(file= "./test/X_test.txt", stringsAsFactors= FALSE,
                      col.names = featureColnames)

trainset <- read.table(file= "./test/X_test.txt", stringsAsFactors= FALSE,
                      col.names = featureColnames)
```
**train/y_train.txt': Training labels and test/y_test.txt': Training labels**
Created column variable IDAct. Join test and train labels id tables with the activity label table.

**Merge datasets**

Merged the Test and training set data and order the columns. See Tidy table below. Also added a new variable subject: subject_IDSub (subject_1,...subject_30). 


**Final Tidy Dataset**

The final clean up involved adding the prefix mean_ to the measured variables, since the mean was taken for each subject, activity and measurement.  

```
activityMeans <- test_training_set %>%
        dplyr::group_by(IDSub,subject,activity) %>%
        dplyr::summarise_each(funs(mean)) %>%
        tidyr::gather("signal","mean", 4:69) %>%
        dplyr::mutate(signal=paste("mean_",signal, sep="")) %>%
        tidyr::spread(signal,mean) 
```
All measured variables are type=double with no units (data received from UCI HAR Dataset was normalized.)

**Tidy Table Variable list:**


|VariableNames                                   |
|:-----------------------------------------------|
|IDSub                                           |
|subject                                         |
|activity                                        |
|mean_freqBodyAcceleration_mean_X                |
|mean_freqBodyAcceleration_mean_Y                |
|mean_freqBodyAcceleration_mean_Z                |
|mean_freqBodyAcceleration_std_X                 |
|mean_freqBodyAcceleration_std_Y                 |
|mean_freqBodyAcceleration_std_Z                 |
|mean_freqBodyAccelerationJerk_mean_X            |
|mean_freqBodyAccelerationJerk_mean_Y            |
|mean_freqBodyAccelerationJerk_mean_Z            |
|mean_freqBodyAccelerationJerk_std_X             |
|mean_freqBodyAccelerationJerk_std_Y             |
|mean_freqBodyAccelerationJerk_std_Z             |
|mean_freqBodyAccelerationMagnitude_mean         |
|mean_freqBodyAccelerationMagnitude_std          |
|mean_freqBodyBodyAccelerationJerkMagnitude_mean |
|mean_freqBodyBodyAccelerationJerkMagnitude_std  |
|mean_freqBodyBodyGyroJerkMagnitude_mean         |
|mean_freqBodyBodyGyroJerkMagnitude_std          |
|mean_freqBodyBodyGyroMagnitude_mean             |
|mean_freqBodyBodyGyroMagnitude_std              |
|mean_freqBodyGyro_mean_X                        |
|mean_freqBodyGyro_mean_Y                        |
|mean_freqBodyGyro_mean_Z                        |
|mean_freqBodyGyro_std_X                         |
|mean_freqBodyGyro_std_Y                         |
|mean_freqBodyGyro_std_Z                         |
|mean_timeBodyAcceleration_mean_X                |
|mean_timeBodyAcceleration_mean_Y                |
|mean_timeBodyAcceleration_mean_Z                |
|mean_timeBodyAcceleration_std_X                 |
|mean_timeBodyAcceleration_std_Y                 |
|mean_timeBodyAcceleration_std_Z                 |
|mean_timeBodyAccelerationJerk_mean_X            |
|mean_timeBodyAccelerationJerk_mean_Y            |
|mean_timeBodyAccelerationJerk_mean_Z            |
|mean_timeBodyAccelerationJerk_std_X             |
|mean_timeBodyAccelerationJerk_std_Y             |
|mean_timeBodyAccelerationJerk_std_Z             |
|mean_timeBodyAccelerationJerkMagnitude_mean     |
|mean_timeBodyAccelerationJerkMagnitude_std      |
|mean_timeBodyAccelerationMagnitude_mean         |
|mean_timeBodyAccelerationMagnitude_std          |
|mean_timeBodyGyro_mean_X                        |
|mean_timeBodyGyro_mean_Y                        |
|mean_timeBodyGyro_mean_Z                        |
|mean_timeBodyGyro_std_X                         |
|mean_timeBodyGyro_std_Y                         |
|mean_timeBodyGyro_std_Z                         |
|mean_timeBodyGyroJerk_mean_X                    |
|mean_timeBodyGyroJerk_mean_Y                    |
|mean_timeBodyGyroJerk_mean_Z                    |
|mean_timeBodyGyroJerk_std_X                     |
|mean_timeBodyGyroJerk_std_Y                     |
|mean_timeBodyGyroJerk_std_Z                     |
|mean_timeBodyGyroJerkMagnitude_mean             |
|mean_timeBodyGyroJerkMagnitude_std              |
|mean_timeBodyGyroMagnitude_mean                 |
|mean_timeBodyGyroMagnitude_std                  |
|mean_timeGravityAcceleration_mean_X             |
|mean_timeGravityAcceleration_mean_Y             |
|mean_timeGravityAcceleration_mean_Z             |
|mean_timeGravityAcceleration_std_X              |
|mean_timeGravityAcceleration_std_Y              |
|mean_timeGravityAcceleration_std_Z              |
|mean_timeGravityAccelerationMagnitude_mean      |
|mean_timeGravityAccelerationMagnitude_std       |

Reference: 
[datasharing](https://github.com/jtleek/datasharing)
[Tidy Data](http://vita.had.co.nz/papers/tidy-data.pdf)

 
