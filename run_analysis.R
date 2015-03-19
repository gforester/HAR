# 
library(dplyr)
testset1 <- read_table(file="./test/X_test.txt", col_names=FALSE)

testset <- read.table(file= "./test/X_test.txt", stringsAsFactors= FALSE )

testlabelid <- read.table(file= "./test/y_test.txt", stringsAsFactors= FALSE )
testlabelid <- tbl_df(testlabelid)
testlabelid %>%
        distinct() %>%
        arrange(V1)
actlabels <- read.table(file="activity_labels.txt" ,stringsAsFactors= FALSE)
subjecttest <- read.table(file="./test/subject_test.txt")
subjecttest <- tbl_df(subjecttest)
subjecttest %>%
        group_by(V1) %>%
        count(V1)
features <- read.table("features.txt", stringsAsFactors = FALSE)
names(features) <- c("id", "parameter_stat_coordinate")
# convert to character vector
featureV <- features[["parameter_stat_coordinate"]]  

testset <- read.table(file= "./test/X_test.txt", stringsAsFactors= FALSE, 
                      col.names = featureV)

testset <- tbl_df(testset)
