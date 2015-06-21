# Course Projekt for Coursera course Getting and Cleaning Data

In this repository I will show how to get and clean the raw Human Activity Recognition Using Smartphones Dataset found at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
to

* Step 1: a tidy dataset with subject, activities with descriptive names mand measurements on the mean and standard deviations
* Step 2: a tidy dataset with the average of each measurements on the mean and standard deviation for each activity and each subject which was stored in an txt-file

The repository includes the following files:
* README.md:      this file you read
* CodeBook.md:    describes the variables, the data, and the transformations to clean up the data
* run_analysis.R: an R script to read, clean and write the data

*Notes:*
The script expects the Original dataset "UCI HAR dataset" in the working directory.

## What the analysis file did

1. Read the features.txt dataset
  * delete the '-()' chars
  * get all vars with 'mean' and 'std' in her names to extract the required namens and save it in the variable ucivars
  * replace 'mean' and 'std' with 'Mean' and 'Std' for a better varname
2. Read the measurements from `X_test.txt` and `X_train.txt` and extract the required columns with `ucivars`
3. Read the activity data from `y_test.txt`and `y_train.txt`
  * Read the activity labels from `activity_labels.txt` and
  * change the activity numbers into active labels
4. Read the subject numbers from `subject_test.txt` and `subject_train.txt`
5. Bind the activities, subjects and measurements in one table
  * name the columns with the varnames from Step 1
6. Group the data by activity and subject to build the second tidy dataset
  * calculate the average for all measurements
  * write the second tidy dataset to a text file
7. Return the first tidy dataset
