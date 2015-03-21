
# File name: run_analysis.R
# Getting and Cleaning Data Course Project
# datasets downloaded from: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# Summary: Creates a tidy output data frame and output file a combines test and training data sets extracted Human Activity Recognition HAR
# For more detail read the README.md at
library(dplyr)
library(tidyr)
library(stringr)
library(knitr)


# ----create HAR directory and set working directory
if(!file.exists("~/HAR")){
        dir.create("~/HAR")
        setwd("~/HAR")
}else {
        setwd("~/HAR")
}


# #-----activity & features data ------------------------------------------
# Loads activity_labels.txt and features.txt files. Reformats the features
# variables to be R compatible column names 
#  

# Load the 6 activity labels (walking, walking_upstairs...,)
actlabels <- read.table(file="./UCI HAR Dataset/activity_labels.txt" ,stringsAsFactors= FALSE)
names(actlabels) <- c("IDAct", "activity" ) # update column headers
# features.txt contains 561 variables names.
# convert to character vector and reformatted for column names for training and
# test files 
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
print("features.txt loaded")
names(features) <- c("id", "featureVariable")
featureV <- features[["featureVariable"]]  
featureColnames <- featureV %>%
        gsub(pattern = "[\\-\\,\\()\\()-]", replacement = "_") %>%
        gsub(pattern = "[_]{2,3}", replacement = "_") %>%
        gsub(pattern = "_$", replacement = "")


# Test set File Loads ---------------------------------------------------------
# Load the Test files: 
# Load test/X_test.txt: Test set.
testset <- read.table(file= "./UCI HAR Dataset/test/X_test.txt", stringsAsFactors= FALSE,
                      col.names = featureColnames)

 
# Include subset sensor signals variables with mean(): Mean value and 
# std():Standard Deviation
testsetMeanStd <- testset %>%
        select(matches("_mean_|_std_|mean$|std$", ignore.case=FALSE))
         
# Load test/y_test.txt: Test activities file
testActivities <- read.table(file= "./UCI HAR Dataset/test/y_test.txt", stringsAsFactors= FALSE,
                             col.names = "IDAct")
# Load test/subject_test.txt
testSubject <- read.table(file="./UCI HAR Dataset/test/subject_test.txt", stringsAsFactors= FALSE,
                          col.names = "IDSub")
 
# combine activities and subject 
testSubAct <- dplyr::bind_cols(testSubject,testActivities)
testSubActLab <- dplyr::full_join(testSubAct,actlabels, by="IDAct")
# combine testset with activities and subject
testsetmerge <- dplyr::bind_cols(testSubActLab,testsetMeanStd)
print(sprintf("completed loading merge test subject/activities/test 
        set: %d observations", nrow(testsetmerge)))
 

# TrainingSetLoad ---------------------------------------------------------
# Load train/X_train.txt: training set.
trainset <- read.table(file= "./UCI HAR Dataset/train/X_train.txt", stringsAsFactors= FALSE,
                       col.names = featureColnames)

# Include subset sensor signals variables with mean(): Mean value and 
# std():Standard Deviation
trainsetMeanStd <- trainset %>%
        select(matches("_mean_|_std_|mean$|std$", ignore.case=FALSE))

# train/y_train.txt: training set labels identifier
trainActivities <- read.table(file= "./UCI HAR Dataset/train/y_train.txt", stringsAsFactors= FALSE,
                             col.names = "IDAct")
# train/subject_train.txt
trainSubject <- read.table(file="./UCI HAR Dataset/train/subject_train.txt", stringsAsFactors= FALSE,
                          col.names = "IDSub")
 
# combine activities and subject 
trainSubAct <- dplyr::bind_cols(trainSubject,trainActivities)
trainSubActLab <- dplyr::full_join(trainSubAct,actlabels, by="IDAct")
# combine trainset
trainsetmerge <- dplyr::bind_cols(trainSubActLab,trainsetMeanStd)
print(sprintf("completed loading merge Training subject/activities/test 
        set: %d observations", nrow(trainsetmerge)))

# Merge Test & Training Data --------------------------------------------------------------

# Merge test and training set.
test_training_set <- dplyr::union(testsetmerge,trainsetmerge) 
print(sprintf("Training & Test data merged: %d observations", nrow(test_training_set)))

 
# add subject prefix (subject_10, subject_12...)
# reorder columns to be more Tidy
test_training_set <- test_training_set  %>% 
        mutate(subject = paste("subject_", IDSub, sep=""))  %>%  
        select(IDSub,subject,activity,-IDAct,matches("_mean_|_std_|mean$|std$", 
                                      ignore.case=FALSE))
         
 
# Tidy Mean dataset -------------------------------------------------------


 


# Create the Tidy Dataset 
# Calculate the mean for each variable group by subject and activity 
# Prefix feature variable names with "mean_" so its clear the values in these
# columns are means of means and means of standard deviation values
activityMeans <- test_training_set %>%
        group_by(IDSub,subject,activity) %>%
        dplyr::summarise_each(funs(mean)) %>%
        gather("signal","mean", 4:69) %>%
        mutate(signal=paste("mean_",signal, sep="")) %>%
        spread(signal,mean) 

write.table(x= activityMeans, file="TidyHAR.txt", row.name= FALSE)

print(sprintf("TidyHAR.txt written to working directory
        %d observations and %d variables", nrow(activityMeans)
        , length(activityMeans)))
        
# helper scripts
library(knitr)
# compares original features variable names to R column formatted names

featureMS <- featureV[grepl(featureV, pattern= "mean\\()|std\\()")]
FeatureVariablesFormat <- names(trainsetMeanStd)
featurescompare <- cbind(featureMS, FeatureVariablesFormat)
write.table(x= featurescompare, file= "featuresTransform.txt", row.name=FALSE)

sink("FeaturesFormat.txt")
kable(featurescompare, format = "markdown", col.names = c("Original Feature Name", 
                                                          "R reformatted Name"))
sink()

# Final list of filter variables
FeaturesFinal <- as.data.frame(names(activityMeans))
kable(FeaturesFinal, format = "markdown")

