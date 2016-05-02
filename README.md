### Source
Takes data from 'http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones' about accelerometer use on Samsung Galaxy S smartphone. 

### Purpose
Cleans the data and creates a summary data frame. Completed as part of a class probject for the "Getting and Cleaning Data" course on Coursera.

### Usage
Run the run_analysis.R script to generate a tidy summary of the UCI HAR data. If the UCI HAR Dataset folder is already in your working directory, then R will use that data. Otherwise, R will download the data into a temporary directory for use while the script is running.

### Files
The run_analysis.R script:
  1. Gives the train and test data meaningful column names (based on codebook described below)
  1. Adds subject and activity data to train and test set 
  1. Combines the training and test set
  2. Subsets out only the mean and standard deviation for each measurement
  4. Creates a summary data frame with the average of each variable for each activity and subject
  5. Writes out the summary data to the file 'tidy_data.txt'


The features_info.txt is an updated codebook for the 'tidy_data.txt' output.
