---
title: README.md
author: Jose A. Buraschi
date: "February 22, 2015"
output:
  md_document: null
...

Human Activity Recognition Using Smartphones Dataset
====================================================

**Jose A. Buraschi**

**February 22, 2015**

README.md
=========

 

Replicating the Source Data Transformations 
--------------------------------------------

To replicate the transformation of this dataset follow the steps outlined below:

 

#### Download Dataset

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

 

#### Extract Files

Extract directories and files from compressed file into the folder in which you
want to set as a working directory.

 

#### Open the run\_analysis.R Script

Open the script titled run\_analysis.R in RStudio or another R environment.

 

#### Set Working Directory

You can set the current working directory to the UCI HAR Dataset directory that
was created when the file was uncompressed.  Then run the script.

 

Alternatively you can edit the first function in the script.  The variable to
update is   “projDataDir” with the full path to parent directory that was
created when the file was uncompressed. Note the name of the directory is UCI
HAR Dataset, but the full path is required as in the sample text in this
function.

 

#### Creating the Output Dataset

Once the full script has been executed then the file tidyDataSet.txt will be
created.

 

List of Required Packages
-------------------------

-   library(dplyr)

 

Project Functions
-----------------

-   setProjectVariables()

-   loadLabels( directory )

-   loadData( directory, sourceLabel, featuresColnames, featureCalcCols,
    activityLabels )

-   run\_analysis()
