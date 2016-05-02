### Source
Takes data from 'http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones' about accelerometer use on Samsung Galaxy S smartphone. 

### Purpose
Cleans the data and creates a summary data frame. Completed as part of a class probject for the "Getting and Cleaning Data" course on Coursera.

### Files
The run_analysis.R script:
1. Combines a training and test set
2. Extracts mean and standard deviation for each measurement
3. Gives new names to the variables
4. Creates a independent data frame with the average of each variable for each activity and subject
5. Writes out the summary data to the file 'tidy_data.txt'

The features_info.txt is an updated codebook for the 'tidy_data.txt' output.
