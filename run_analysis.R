
# File name: run_analysis.R Getting and Cleaning Data Course Project datasets 
# Summary: Combines & manipulates test and training set data, and creates a tidy
# output data frame and output file TidyHAR.txt  

# Setup -------------------------------------------------------------------
library(dplyr)
library(tidyr)
library(stringr)
library(knitr)

# ----set working directory
# UCI HAR Dataset folder must in your home directory path.
        setwd("~/UCI HAR Dataset")
 


#-----Load Activity labels and Features text files------------------------------------------
# Loads activity_labels.txt and features.txt files. Reformats the features
# variables to be R compatible column names 
#  

# Load the 6 activity labels (walking, walking_upstairs...,)
actlabels <- read.table(file="activity_labels.txt" ,stringsAsFactors= FALSE)
names(actlabels) <- c("IDAct", "activity" ) # update column headers
# features.txt contains 561 variables names.
# convert to character vector and reformatted for column names for training and
# test files 
features <- read.table("features.txt", stringsAsFactors = FALSE)
print("features.txt loaded")
names(features) <- c("id", "featureVariable")
featureV <- features[["featureVariable"]]  
featureColnames <- featureV %>%
        gsub(pattern = "[\\-\\,\\()\\()-]", replacement = "_") %>%
        gsub(pattern = "[_]{2,3}", replacement = "_") %>%
        gsub(pattern = "_$", replacement = "")


# ---Load Test Files  ---------------------------------------------------------
# Load the Test files: 
# Load test/X_test.txt: Test set.
testset <- read.table(file= "./test/X_test.txt", stringsAsFactors= FALSE,
                      col.names = featureColnames)

 
# Include subset sensor signals variables with mean(): Mean value and 
# std():Standard Deviation
testsetMeanStd <- testset %>%
        dplyr::select(matches("_mean_|_std_|mean$|std$", ignore.case=FALSE))
         
# Load test/y_test.txt: Test activities file
testActivities <- read.table(file= "./test/y_test.txt", stringsAsFactors= FALSE,
                             col.names = "IDAct")
# Load test/subject_test.txt
testSubject <- read.table(file="./test/subject_test.txt", stringsAsFactors= FALSE,
                          col.names = "IDSub")
 
# combine activities and subject 
testSubAct <- dplyr::bind_cols(testSubject,testActivities)
testSubActLab <- dplyr::full_join(testSubAct,actlabels, by="IDAct")
# combine testset with activities and subject
testsetmerge <- dplyr::bind_cols(testSubActLab,testsetMeanStd)
print(sprintf("completed loading merge test subject/activities/test 
        set: %d observations", nrow(testsetmerge)))
 

# Load Training files---------------------------------------------------------
# Load train/X_train.txt: training set.
trainset <- read.table(file= "./train/X_train.txt", stringsAsFactors= FALSE,
                       col.names = featureColnames)

# Include subset sensor signals variables with mean(): Mean value and 
# std():Standard Deviation
trainsetMeanStd <- trainset %>%
        dplyr::select(matches("_mean_|_std_|mean$|std$", ignore.case=FALSE))

# train/y_train.txt: training set labels identifier
trainActivities <- read.table(file= "./train/y_train.txt", stringsAsFactors= FALSE,
                             col.names = "IDAct")
# train/subject_train.txt
trainSubject <- read.table(file="./train/subject_train.txt", stringsAsFactors= FALSE,
                          col.names = "IDSub")
 
# combine activities and subject 
trainSubAct <- dplyr::bind_cols(trainSubject,trainActivities)
trainSubActLab <- dplyr::full_join(trainSubAct,actlabels, by="IDAct")
# combine trainset
trainsetmerge <- dplyr::bind_cols(trainSubActLab,trainsetMeanStd)
print(sprintf("completed loading merge Training subject/activities/test 
        set: %d observations", nrow(trainsetmerge)))

# Join the Test & Training Data --------------------------------------------------------------

# Merge test and training set.
test_training_set <- dplyr::union(testsetmerge,trainsetmerge) 
print(sprintf("Training & Test data merged: %d observations", nrow(test_training_set)))

 
# add subject prefix (subject_10, subject_12...)
# reorder columns to be more Tidy
test_training_set <- test_training_set  %>% 
        dplyr::mutate(subject = paste("subject_", IDSub, sep=""))  %>%  
        dplyr::select(IDSub,subject,activity,-IDAct,matches("_mean_|_std_|mean$|std$", 
                                      ignore.case=FALSE))
         
 
# Create the Independent Tidy dataset -------------------------------------------------------
 
# Create the Tidy Dataset 
# Calculate the mean for each variable group by subject and activity 
# Prefix feature variable names with "mean_" so its clear the values in these
# columns are means of means and means of standard deviation values
activityMeans <- test_training_set %>%
        dplyr::group_by(IDSub,subject,activity) %>%
        dplyr::summarise_each(funs(mean)) %>%
        tidyr::gather("signal","mean", 4:69) %>%
        dplyr::mutate(signal=paste("mean_",signal, sep="")) %>%
        tidyr::spread(signal,mean) 

write.table(x= activityMeans, file="TidyHAR.txt", row.name= FALSE)

print(sprintf("TidyHAR.txt written to working directory
        %d observations and %d variables", nrow(activityMeans)
        , length(activityMeans)))
        

# helper scripts ----------------------------------------------------------

# compares original features variable names to R column formatted names

featureMS <- featureV[grepl(featureV, pattern= "mean\\()|std\\()")]
FeatureVariablesFormat <- names(trainsetMeanStd)
featurescompare <- cbind(featureMS, FeatureVariablesFormat)

colnames(featurescompare) <- c("OriginalFeatureVariables","TransformFeatureVariables")
 
sink("featuresVariables.txt") # R command to write console output to a file
kable(featurescompare, format = "markdown")
sink()

# Final list of filter variables
sink("TidyVariables.txt") # R command to write console output to a file
TidyVariables <- as.data.frame(names(activityMeans))
knitr::kable(TidyVariables, format = "markdown")
sink() # close output file

