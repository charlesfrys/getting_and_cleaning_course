# Peer-graded Assignment: Getting and Cleaning Data Course Project

The goal of this project is to prepare tidy data that can be used for later analysis. The R script run_analysis.R :

1. downloads the dataset if it is not present in the working directory
2. loads the features text file and gets the indexes of the columns that we want in the train and test datasets
3. loads the training et test datasets, keeping only the columns relative to the mean and standard deviation of each measurements.
4. merges both datasets
5. renames the columns of the new dataset with descriptive labels found in the features text file
6. converts the activity and subject columns to factors
7. aggregates the dataset in a new independent one to get the average of each variable for each activity and each subject

This last dataset is shown in the text file tidy.txt
