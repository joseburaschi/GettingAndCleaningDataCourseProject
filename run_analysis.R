setProjectVariables <- function(){
  projDataDir <<- "/Users/jaburaschi/DataScience/Coursera/Rpractice/GetCleanDataProject/UCI HAR Dataset"
}

loadLabels <- function( pDirectory ) {
  # Confirm that directory passed into this function is a valid directory
  if (pDirectory!="" && 
    (!file.exists(pDirectory) || (file.exists(pDirectory) && !file.info(pDirectory)["isdir"][1,1]))) {
    cat('Usage: complete(directory = "" (blank string = current directory), id=0 (0=ALL)\n')
    cat(paste("ERROR: Directory [",pDirectory,"] does not exist. Please review the directory specified and provide a valid path and directory.\n"))
  }
  
  # Save the current working directory to restore it after the function has completed execution
   curDir <- getwd()
   if (pDirectory != "") {
     setwd(pDirectory)
   }

  ## Load feature column names for the X dataset
  feature_colnames <<- read.table("features.txt", stringsAsFactors=FALSE)
  colnames(feature_colnames) <<- c("feature_id","feature")

  ## Create list of columns containing str() and mean()
  feature_calc_cols <<- feature_colnames[(apply(sapply(c("std()","mean()"),grepl,feature_colnames$feature,fixed=TRUE),1,any)),"feature"]

  ## Load activity labels (activity_labels.txt) and add column name
  activity_labels <<- read.table("activity_labels.txt", sep=" ", header = FALSE, stringsAsFactors=FALSE)
  colnames(activity_labels) <<- c("activity_id", "activity")

  # Change the working directory back to the working directory set before the program started execution
  setwd(curDir)
}

loadData <- function( pDirectory, pSourceLabel, pFeaturesColnames, pFeatureCalcCols, pActivityLabels ) {

  # Confirm that directory passed into this function is a valid directory
  if (pDirectory!="" && 
    (!file.exists(pDirectory) || (file.exists(pDirectory) && !file.info(pDirectory)["isdir"][1,1]))) {
    cat('Usage: complete(directory = "" (blank string = current directory), id=0 (0=ALL)\n')
    cat(paste("ERROR: Directory [",pDirectory,"] does not exist. Please review the directory specified and provide a valid path and directory.\n"))
  }
  
  # Save the current working directory to restore it after the function has completed execution
  curDir <- getwd()
  if (pDirectory != "") {
    setwd(pDirectory)
  }
  ## Load subject dataset (subject_'purposeLabel'.txt) and add column name
  subjects <- read.table(paste("subject_",pSourceLabel,".txt",sep=""), header=FALSE, stringsAsFactors=FALSE)
  colnames(subjects) <- c("subject")

  ## Load X dataset (X_'pSourceLabel'.txt) and add column names
  X <- read.table(paste("X_",pSourceLabel,".txt",sep=""), colClasses="numeric", header = FALSE, fill=TRUE, strip.white=TRUE)
  colnames(X) <- pFeaturesColnames$feature

  ## Filter columns to include only columns with std() and mean() 
  X <- X[, pFeatureCalcCols]
  
  ## Load y dataset (y_'purposeLabel'.txt) and add column names
  y <- read.table(paste("y_",pSourceLabel,".txt",sep=""), colClasses="numeric", header = FALSE)
  colnames(y) <- c("activity_id")
  
  ## Add the activity_label column and add column names
  y["activity"] <- vector()
  y$activity<-pActivityLabels$activity[y$activity_id]
  
  # Change the working directory back to the working directory set before the program started execution
  setwd(curDir)
  
  cbind(y,subjects,X)
}

run_analysis <- function(){
  library(dplyr)
  
  setProjectVariables()
  
  print("Loading column headers and activity descriptions...")
  loadLabels(projDataDir)
  
  print("Loading training data set...")
  trainData <- loadData("train", "train", feature_colnames, feature_calc_cols, activity_labels)
  
  print("Loading training data set...")
  testData <- loadData("test", "test", feature_colnames, feature_calc_cols, activity_labels)
  
  print("")
  tidyDF <- rbind(trainData, testData)
  #str(tidyDF)
  #dim(tidyDF)
  
  # create DF of means grouped by activity and subject
  # The following command uses the aggregate function to create the summarized view of the tidyDF
  #    meanBySubjectActivity = aggregate(tidyDF[,feature_calc_cols],by=list(tidyDF$activity,tidyDF$subject),mean)
  #
  # Using the dplyr package it is possible to make a more readable transformation to summarize the data
  tbl_df(tidyDF[c("subject", "activity",feature_calc_cols)]) %>% 
    group_by (activity, subject) %>%
      summarise_each(funs(mean)) %>%
        write.table("tidyDataSet.txt")
}

run_analysis()