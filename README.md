---
title: "README"
author: "George F"
date: "March 21, 2015"
 
---

# How execute the run_analysis.R script

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

* R script requires a folder name __HAR__ folder in your home directory.
```
if(!file.exists("~/HAR")){
        dir.create("~/HAR")
        setwd("~/HAR")
}else {
        setwd("~/HAR")
}
```
* Ensure your unzip UCI HAR Dataset folder is in this path ~/HAR/UCI HAR Dataset
* down run_analysis.R from GITHUB

``` # Script to download run_analysis.R
fileurl <- "https://github.com/gforester/HAR/blob/master/run_analysis.R"
download.file(fileurl,destfile="~/HAR/run_analysis.R",method="curl")
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
** Output files generated **
* TidyHAR.txt - (write.table(x= activityMeans, file="TidyHAR.txt", row.name= FALSE))
* featuresVariables.txt - markdown formatted table 
** Code Details **

 
 

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
