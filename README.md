---
title: "README.md"
author: Jose A. Buraschi
date: February 22, 2015
output: 
  md_document:
---

#Human Activity Recognition Using Smartphones Dataset

To replicate the transformation of this dataset follow the steps outlined below:

1. Download the dataset from the following URL.
  a. https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Extract directories and files from compressed file on to a folder.

3. Open the script titled run_analysis.R in RStudio or another R environment.

4. Update the first function in the script and set the variable projDataDir with the full path to parent directory that was created in step 2 above. Note the name of the directory is UCI HAR Dataset, but the full path is required as in the sample text in this function.

5. Run the full script and the file tidyDataSet.txt will have been created.


###List of Required Packages

* library(dplyr)

###Project Functions
* setProjectVariables()
* loadLabels( directory )
* loadData( directory, sourceLabel, featuresColnames, featureCalcCols, activityLabels )
* run_analysis()
