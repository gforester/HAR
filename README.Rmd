---
title: "README"
author: "George F"
date: "March 21, 2015"
 
---

# How to execute the run_analysis.R script

Summary: run_analysis writes a tidy file, TidyHAR.txt to your working directory. The steps to execute run_analysis.R and methodology is included below and details of the variables, the data, and clean up is described in the 
[CodeBook.md](https://github.com/gforester/HAR/blob/master/CodeBook.md)

**Environment:**

* RStudio - Version 0.98.1103
* R version 3.1.2 (2014-10-31)
* MacBook Pro - x86_64-apple-darwin10.8.0 

**Setup & requirements to run run_analysis script**

* Ensure these library are install in your R environment
        + library(dplyr)
	+ library(tidyr)
	+ library(knitr)
* Set the working directory to setwd("~/UCI HAR Dataset").  The folder UCI HAR Dataset must be located in the home directory.
* download the run_analysis.R from GITHUB
``` 
Script to download run_analysis.R
fileurl <- "https://github.com/gforester/HAR/blob/master/run_analysis.R"
download.file(fileurl,destfile="run_analysis.R",method="curl")
```
        
**Steps to run run_analysis script**
* open RStudio application
* open run_analysis.R -- to view the code
* click the source code icon or click on Code > Source. Code should execute, and will run around 30 secs. While running the following will be displayed:
        
```
[1] "features.txt loaded"
[1] "completed loading merge test subject/activities/test \n        set: 2947 observations"
[1] "completed loading merge Training subject/activities/test \n        set: 7352 observations"
[1] "Training & Test data merged: 10299 observations"
[1] "TidyHAR.txt written to working directory\n        180 observations and 69 variables"
```
**Output files generated**
* TidyHAR.txt - (write.table(x= activityMeans, file="TidyHAR.txt", row.name= FALSE))
* featuresVariables.txt - markdown formatted table 
* TidyVariables.txt - markdown formatted table.
```
sink("TidyVariables.txt") # R command to write console output to a file
TidyVariables <- as.data.frame(names(activityMeans))
kable(TidyVariables, format = "markdown")
sink() # close output file
```
**Code Details**

This section describes the major steps to generate the final Tidy dataset. The code is group into 6 sections. 

**Setup Section:**

Loads the required libraries, and set the working directory

**Load Activity labels and Features text files:**
This section of the code loads the activity labels and features text files. 
The default activity labels columns are renamed to "IDAct", "activity". The default features column names are renamed to "id", "featureVariable". Updated the feature names to be more human readable and replace the characters ()-.  I found that these characters are not valid in column names. In initial debugging they were replaced with "." A character vector, __featureColnames__ is generated and used in the read.file col.names parameter. This eliminated the requirement to rename the default V1 to V561 column names.

**Load Test Files**
This section merges the activity labels with test activities, subject, and features measurement data. In addition the code extracts a subset of the signal measurement data __mean(): Mean value__  and __std(): Standard deviation__  

**Load Training files**
The same logic is used to merge the training data as outlined in the Load Test Files.  

**Join the Test & Training Data**

In this section the test and training set data are joined, and prefix subject is added to the subject Id field. I also tidy up the organization of the column names.

**Create the Independent Tidy dataset**
Mean statistic is calculated for each IDSub,subject, activiy and measurement group. I added mean_ prefix to each of the measurement variables. The tidy data is presented in long format (180 rows by 69 variables ). and TidyHAR.txt file is written to the working directory. The following R-code can be used to view the text data.

```
tidyData <- read.table(file="TidyHAR.txt" ,stringsAsFactors= FALSE, header=TRUE)
View(tidyData)
```

** helper scripts **
This portion of the code generates two markdown formatted table
* featuresVariables.txt - markdown formatted table 
* TidyVariables.txt - markdown formatted table.

__featuresVariables.txt__ list the original filter variable name to reformatted column name
__TidyVariables.txt__ list the columns in the final tidy dataset.

 
