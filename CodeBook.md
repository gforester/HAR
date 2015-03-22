---
title: "CodeBook"
author: "George F"
date: "March 21, 2015"
 
---
This document described the variable and transformation performed to achieve an output tidy dataset to the 

Initial data files came from UCI HAR Dataset folder

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws



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

|OriginalFeatureVariables    |TransformFeatureVariables |
|:---------------------------|:-------------------------|
|tBodyAcc-mean()-X           |tBodyAcc_mean_X           |
|tBodyAcc-mean()-Y           |tBodyAcc_mean_Y           |
|tBodyAcc-mean()-Z           |tBodyAcc_mean_Z           |
|tBodyAcc-std()-X            |tBodyAcc_std_X            |
|tBodyAcc-std()-Y            |tBodyAcc_std_Y            |
|tBodyAcc-std()-Z            |tBodyAcc_std_Z            |
|tGravityAcc-mean()-X        |tGravityAcc_mean_X        |
|tGravityAcc-mean()-Y        |tGravityAcc_mean_Y        |
|tGravityAcc-mean()-Z        |tGravityAcc_mean_Z        |
|tGravityAcc-std()-X         |tGravityAcc_std_X         |
|tGravityAcc-std()-Y         |tGravityAcc_std_Y         |
|tGravityAcc-std()-Z         |tGravityAcc_std_Z         |
|tBodyAccJerk-mean()-X       |tBodyAccJerk_mean_X       |
|tBodyAccJerk-mean()-Y       |tBodyAccJerk_mean_Y       |
|tBodyAccJerk-mean()-Z       |tBodyAccJerk_mean_Z       |
|tBodyAccJerk-std()-X        |tBodyAccJerk_std_X        |
|tBodyAccJerk-std()-Y        |tBodyAccJerk_std_Y        |
|tBodyAccJerk-std()-Z        |tBodyAccJerk_std_Z        |
|tBodyGyro-mean()-X          |tBodyGyro_mean_X          |
|tBodyGyro-mean()-Y          |tBodyGyro_mean_Y          |
|tBodyGyro-mean()-Z          |tBodyGyro_mean_Z          |
|tBodyGyro-std()-X           |tBodyGyro_std_X           |
|tBodyGyro-std()-Y           |tBodyGyro_std_Y           |
|tBodyGyro-std()-Z           |tBodyGyro_std_Z           |
|tBodyGyroJerk-mean()-X      |tBodyGyroJerk_mean_X      |
|tBodyGyroJerk-mean()-Y      |tBodyGyroJerk_mean_Y      |
|tBodyGyroJerk-mean()-Z      |tBodyGyroJerk_mean_Z      |
|tBodyGyroJerk-std()-X       |tBodyGyroJerk_std_X       |
|tBodyGyroJerk-std()-Y       |tBodyGyroJerk_std_Y       |
|tBodyGyroJerk-std()-Z       |tBodyGyroJerk_std_Z       |
|tBodyAccMag-mean()          |tBodyAccMag_mean          |
|tBodyAccMag-std()           |tBodyAccMag_std           |
|tGravityAccMag-mean()       |tGravityAccMag_mean       |
|tGravityAccMag-std()        |tGravityAccMag_std        |
|tBodyAccJerkMag-mean()      |tBodyAccJerkMag_mean      |
|tBodyAccJerkMag-std()       |tBodyAccJerkMag_std       |
|tBodyGyroMag-mean()         |tBodyGyroMag_mean         |
|tBodyGyroMag-std()          |tBodyGyroMag_std          |
|tBodyGyroJerkMag-mean()     |tBodyGyroJerkMag_mean     |
|tBodyGyroJerkMag-std()      |tBodyGyroJerkMag_std      |
|fBodyAcc-mean()-X           |fBodyAcc_mean_X           |
|fBodyAcc-mean()-Y           |fBodyAcc_mean_Y           |
|fBodyAcc-mean()-Z           |fBodyAcc_mean_Z           |
|fBodyAcc-std()-X            |fBodyAcc_std_X            |
|fBodyAcc-std()-Y            |fBodyAcc_std_Y            |
|fBodyAcc-std()-Z            |fBodyAcc_std_Z            |
|fBodyAccJerk-mean()-X       |fBodyAccJerk_mean_X       |
|fBodyAccJerk-mean()-Y       |fBodyAccJerk_mean_Y       |
|fBodyAccJerk-mean()-Z       |fBodyAccJerk_mean_Z       |
|fBodyAccJerk-std()-X        |fBodyAccJerk_std_X        |
|fBodyAccJerk-std()-Y        |fBodyAccJerk_std_Y        |
|fBodyAccJerk-std()-Z        |fBodyAccJerk_std_Z        |
|fBodyGyro-mean()-X          |fBodyGyro_mean_X          |
|fBodyGyro-mean()-Y          |fBodyGyro_mean_Y          |
|fBodyGyro-mean()-Z          |fBodyGyro_mean_Z          |
|fBodyGyro-std()-X           |fBodyGyro_std_X           |
|fBodyGyro-std()-Y           |fBodyGyro_std_Y           |
|fBodyGyro-std()-Z           |fBodyGyro_std_Z           |
|fBodyAccMag-mean()          |fBodyAccMag_mean          |
|fBodyAccMag-std()           |fBodyAccMag_std           |
|fBodyBodyAccJerkMag-mean()  |fBodyBodyAccJerkMag_mean  |
|fBodyBodyAccJerkMag-std()   |fBodyBodyAccJerkMag_std   |
|fBodyBodyGyroMag-mean()     |fBodyBodyGyroMag_mean     |
|fBodyBodyGyroMag-std()      |fBodyBodyGyroMag_std      |
|fBodyBodyGyroJerkMag-mean() |fBodyBodyGyroJerkMag_mean |
|fBodyBodyGyroJerkMag-std()  |fBodyBodyGyroJerkMag_std  |


Activites:

| IDAct|activity           |
|-----:|:------------------|
|     1|WALKING            |
|     2|WALKING_UPSTAIRS   |
|     3|WALKING_DOWNSTAIRS |
|     4|SITTING            |
|     5|STANDING           |
|     6|LAYING             |


* Final Tidy Dataset

The final clean up involved adding the prefix mean_ to the measured variables, since the mean was taken for each subject, activity and measurement.  

```
activityMeans <- test_training_set %>%
        dplyr::group_by(IDSub,subject,activity) %>%
        dplyr::summarise_each(funs(mean)) %>%
        tidyr::gather("signal","mean", 4:69) %>%
        dplyr::mutate(signal=paste("mean_",signal, sep="")) %>%
        tidyr::spread(signal,mean) 
```

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

 
