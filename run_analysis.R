library('dplyr')

## See if data is already in directory
if (file.exists('UCI HAR Dataset')) {
    tmpdir <- getwd()
} else {
    ## Create a temporary file and download the data into it
    tmpfile <- tempfile()[1]
    download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',tmpfile)

    ## Load the tmpfile and extract the data
    tmpdir <- tempdir()[1]
    files <- unzip(tmpfile, exdir = tmpdir)
}

## Load the labels
features <- read.table(paste0(tmpdir, '\\UCI HAR Dataset\\features.txt'))$V2
features <- sub(',', '.', sub('\\)', '', sub('\\(', '', features)))
activities <- read.table(paste0(tmpdir, '\\UCI HAR Dataset\\activity_labels.txt'))

## Load the training set
traindat <- read.table(paste0(tmpdir,'\\UCI HAR Dataset\\train\\X_train.txt'),col.names=features)

## Load the training subject ids
trainsbj <- read.table(paste0(tmpdir,'\\UCI HAR Dataset\\train\\subject_train.txt'))
names(trainsbj) <- 'subject'

## Load the training activity label ids
trainact <- read.table(paste0(tmpdir,'\\UCI HAR Dataset\\train\\y_train.txt'))

## Combine training data
train <- as.data.frame(cbind(trainsbj, trainact, traindat))
names(train)[2] <- 'actid'

## Load the test set
testdat <- read.table(paste0(tmpdir,'\\UCI HAR Dataset\\test\\X_test.txt'),col.names=features)

## Load the test subject ids
testsbj <- read.table(paste0(tmpdir,'\\UCI HAR Dataset\\test\\subject_test.txt'))
names(testsbj) <- 'subject'

## Load the test activity label ids
testact <- read.table(paste0(tmpdir,'\\UCI HAR Dataset\\test\\y_test.txt'))

## Combine test data
test <- as.data.frame(cbind(testsbj, testact, testdat))
names(test)[2] <- 'actid'

## Combine training and test data
data <- as.data.frame(rbind(train, test))

## Add activity labels
data <- merge(data, activities, by.x = 'actid', by.y = 'V1')
names(data)[dim(data)[2]]<-'activity'

## Extract only the subject, activity, and mean/standard deviation of measurements
findNames <- function(x) {
  return((grepl('mean', x) | grepl('std', x) | grepl('subject', x) | grepl('activity', x)) & !grepl('meanFreq',x))
}

mean.std.data <- data[, sapply(names(data), findNames)]

## Create summary data frame (summary.data) with average mean and std for each measurement
## by subject and activity

summary.data <- group_by(mean.std.data, subject, activity) %>% summarise_each(funs(mean))

## Write out summary.data to the file 'tidy_data.txt'
write.table(summary.data, file='tidy_data.txt', row.names = FALSE)
