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

reference: [datasharing](https://github.com/jtleek/datasharing)

Initial data files came from UCI HAR Dataset folder

**The folder includes the following files:**

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

For more information about this dataset contact: activityrecognition@smartlab.ws

Each training file below has 7352 observations and each test file has 2947 observations. The training subject file has 21 subjects and the test subject file has 9 subjects.

-  train/X_train.txt': Training set.
-  train/y_train.txt': Training labels.
-  train/subject_train.txt
-  test/X_test.txt': Test set.
-  test/y_test.txt': Test labels.
-  test/subject_train.txt
 
Activites:


| IDAct|activity           |
|-----:|:------------------|
|     1|WALKING            |
|     2|WALKING_UPSTAIRS   |
|     3|WALKING_DOWNSTAIRS |
|     4|SITTING            |
|     5|STANDING           |
|     6|LAYING             |

** Variable transformation of features.txt file. **
The following script code removed -() and replaced with _   
These characters were replaced, because these invalid column name characters, and R replaces these characters with . (period). I decided on the _ (underscore). I also removed any underscore at the end of the variable name. See table 1.

```
featureColnames <- featureV %>%
        gsub(pattern = "[\\-\\,\\()\\()-]", replacement = "_") %>%
        gsub(pattern = "[_]{2,3}", replacement = "_") %>%
        gsub(pattern = "_$", replacement = "")
```
Reduced the variables (columns) from test/X_txt.txt and train/X_train.txt from 561 to 66 variables. 
```
trainsetMeanStd <- trainset %>%
        dplyr::select(matches("_mean_|_std_|mean$|std$", ignore.case=FALSE))
        
testsetMeanStd <- testset %>%
        dplyr::select(matches("_mean_|_std_|mean$|std$", ignore.case=FALSE))
```

** Table 1: Initial Feature.txt variable transformation.


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

**activity_labels.txt**
Created to column variables

* IDAct - identifier field.  
* activities - activities variable is included in the final dataset.

 
**Subject files**
 

train/subject_train.txt - single column table with number observations equal to train/
* test/subject_test.txt
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

|names(activityMeans)                            |
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


|Variable Names                 |
|:------------------------------|
|IDSub                          |
|subject                        |
|activity                       |
|mean_fBodyAcc_mean_X           |
|mean_fBodyAcc_mean_Y           |
|mean_fBodyAcc_mean_Z           |
|mean_fBodyAcc_std_X            |
|mean_fBodyAcc_std_Y            |
|mean_fBodyAcc_std_Z            |
|mean_fBodyAccJerk_mean_X       |
|mean_fBodyAccJerk_mean_Y       |
|mean_fBodyAccJerk_mean_Z       |
|mean_fBodyAccJerk_std_X        |
|mean_fBodyAccJerk_std_Y        |
|mean_fBodyAccJerk_std_Z        |
|mean_fBodyAccMag_mean          |
|mean_fBodyAccMag_std           |
|mean_fBodyBodyAccJerkMag_mean  |
|mean_fBodyBodyAccJerkMag_std   |
|mean_fBodyBodyGyroJerkMag_mean |
|mean_fBodyBodyGyroJerkMag_std  |
|mean_fBodyBodyGyroMag_mean     |
|mean_fBodyBodyGyroMag_std      |
|mean_fBodyGyro_mean_X          |
|mean_fBodyGyro_mean_Y          |
|mean_fBodyGyro_mean_Z          |
|mean_fBodyGyro_std_X           |
|mean_fBodyGyro_std_Y           |
|mean_fBodyGyro_std_Z           |
|mean_tBodyAcc_mean_X           |
|mean_tBodyAcc_mean_Y           |
|mean_tBodyAcc_mean_Z           |
|mean_tBodyAcc_std_X            |
|mean_tBodyAcc_std_Y            |
|mean_tBodyAcc_std_Z            |
|mean_tBodyAccJerk_mean_X       |
|mean_tBodyAccJerk_mean_Y       |
|mean_tBodyAccJerk_mean_Z       |
|mean_tBodyAccJerk_std_X        |
|mean_tBodyAccJerk_std_Y        |
|mean_tBodyAccJerk_std_Z        |
|mean_tBodyAccJerkMag_mean      |
|mean_tBodyAccJerkMag_std       |
|mean_tBodyAccMag_mean          |
|mean_tBodyAccMag_std           |
|mean_tBodyGyro_mean_X          |
|mean_tBodyGyro_mean_Y          |
|mean_tBodyGyro_mean_Z          |
|mean_tBodyGyro_std_X           |
|mean_tBodyGyro_std_Y           |
|mean_tBodyGyro_std_Z           |
|mean_tBodyGyroJerk_mean_X      |
|mean_tBodyGyroJerk_mean_Y      |
|mean_tBodyGyroJerk_mean_Z      |
|mean_tBodyGyroJerk_std_X       |
|mean_tBodyGyroJerk_std_Y       |
|mean_tBodyGyroJerk_std_Z       |
|mean_tBodyGyroJerkMag_mean     |
|mean_tBodyGyroJerkMag_std      |
|mean_tBodyGyroMag_mean         |
|mean_tBodyGyroMag_std          |
|mean_tGravityAcc_mean_X        |
|mean_tGravityAcc_mean_Y        |
|mean_tGravityAcc_mean_Z        |
|mean_tGravityAcc_std_X         |
|mean_tGravityAcc_std_Y         |
|mean_tGravityAcc_std_Z         |
|mean_tGravityAccMag_mean       |
|mean_tGravityAccMag_std        |

 
