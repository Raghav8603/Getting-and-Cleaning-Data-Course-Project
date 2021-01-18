# Getting And Cleaning Data Course Project

# Data Source

Data for this project was obtain from the Coursera assignment instructions. Data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]

Data for the project:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

# The data was transformed according to the five step as desired for this assisgnment.
The steps are as follows-

1.Merging the training and the test sets to create one data set.
2.Extracting only the measurements on the mean and standard deviation for each measurement.
3.Using descriptive activity names to name the activities in the data set
4.Appropriately labeling the data set with descriptive activity names.
5.Creating a second, independent tidy data set with the average of each variable for each activity and each subject.

# About Variables:

1.x_train, y_train, x_test, y_test, subject_train, subject_test, features and activity_lables contain the data from the downloaded files.
2.merge_train, merge_test and mergeAll are used to merge data for analysis.
3.MeanAndStd contains the tidy data and MeanAndStdAverage contains the tidy dataset with the average of each variable for each activity and each subject.

