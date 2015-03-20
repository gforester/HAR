# Human Activity Recognition HAR
library(dplyr)
library(stringr)

# ----create UCI directory and set working directory
if(!file.exists("~/HAR")){
        dir.create("~/HAR")
        setwd("~/HAR")
}else {
        setwd("~/HAR")
}

# #-----activity & features data ------------------------------------------


# read in 6 activity labels (walking, walking_upstairs...,)
actlabels <- read.table(file="activity_labels.txt" ,stringsAsFactors= FALSE)
names(actlabels) <- c("IDAct", "activity" )
# features.txt contains 561 variables names.
# convert to character vector and reformat for column names for training and
# test files 
features <- read.table("features.txt", stringsAsFactors = FALSE)
names(features) <- c("id", "featureVariable")
featureV <- features[["featureVariable"]]  
featureColnames <- featureV %>%
        gsub(pattern = "[\\-\\,\\()\\()-]", replacement = "_") %>%
        gsub(pattern = "[_]{2,3}", replacement = "_") %>%
        gsub(pattern = "_$", replacement = "")

# Test File Loads ---------------------------------------------------------
# Load the Test files: 
# Load test/X_test.txt: Test set.
testset <- read.table(file= "./test/X_test.txt", stringsAsFactors= FALSE,
                      col.names = featureColnames)
 
# Include signals with Mean Value and Standard Deviation
testsetMeanStd <- testset %>%
        select(matches("_mean_|_std_|mean$|std$", ignore.case=FALSE))
         
# Load test/y_test.txt: Test activities file
testActivities <- read.table(file= "./test/y_test.txt", stringsAsFactors= FALSE,
                             col.names = "IDAct")
# test/subject_test.txt
testSubject <- read.table(file="./test/subject_test.txt", stringsAsFactors= FALSE,
                          col.names = "IDSub")
# testSubject <- tbl_df(testSubject)

# combine activities and subject 
testSubAct <- dplyr::bind_cols(testSubject,testActivities)
testSubActLab <- dplyr::full_join(testSubAct,actlabels, by="IDAct")
# combine testset
testsetmerge <- dplyr::bind_cols(testSubActLab,testsetMeanStd)
# expect 54 observations 6 activities x 9 subjects
testsetmerge %>%
        select(IDSub,activity) %>%
        distinct() %>%
        nrow()
 

# TrainingSetLoad ---------------------------------------------------------
# Load the Training files: 
# train/X_train.txt: training set.
trainset <- read.table(file= "./train/X_train.txt", stringsAsFactors= FALSE,
                       col.names = featureColnames)
# Include signals with Mean Value and Standard Deviation
trainsetMeanStd <- trainset %>%
        select(matches("_mean_|_std_|mean$|std$", ignore.case=FALSE))

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

# expect 126 distinct observations (6 activities x 21 subjects)
trainsetmerge %>%
        select(IDSub,activity) %>%
        distinct() %>%
        nrow() 

# join test and training set
test_training_set <- dplyr::union(testsetmerge,trainsetmerge) 

# expect 180 distinct observations (6 activities x 30 subjects)
test_training_set %>%
        select(IDSub,activity) %>%
        distinct() %>%
        nrow() 
 
# add subject variable "train_subject_id
test_training_set <- test_training_set  %>% 
        mutate(subject = paste("subject_", IDSub, sep=""))  %>%  
        select(IDSub,subject,activity,-IDAct,matches("_mean_|_std_|mean$|std$", 
                                      ignore.case=FALSE))
         
 
         
#----Calculate mean  
 
  
activitystats <- test_training_set %>%
        group_by(IDSub,subject,activity) %>%
        dplyr::summarise_each(funs(mean))
library(tidyr)
library(ggplot2)
zz <- test_training_set %>%
        gather("signals", "value",4:69) %>%
        group_by(IDSub,subject,activity,signals) %>%
        dplyr::summarise_each(funs(mean))

plot(value ~ signal)


        
         
  
        
# helper scripts
library(knitr)
# compares original features variable names to R column formatted names
featurescompare <- cbind(featureV, featureColnames)
write.table(x= featurescompare, file= "featuresTransform.txt", row.name=FALSE)

sink("FeaturesFormat.txt")
kable(featurescompare, format = "markdown", col.names = c("Original Feature Name", 
                                                          "R reformatted Name"))
sink()

# Final list of filter variables
FeaturesFinal <- as.data.frame(names(test_training_set))
kable(FeaturesFinal, format = "markdown")

