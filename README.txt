
run_analysis.R

This R script performs the following steps, as per the project assignment instructions:

1) Download and unzip the files for the analysis
2) Merges the training and the test sets to create one data set.
3) Extracts only the measurements on the mean and standard deviation for each measurement.
4) Uses descriptive activity names to name the activities in the data set
5) Appropriately labels the data set with descriptive activity names.
6) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
how to download the original data


To run the code use:
source('Run_analysis.R')


Output
Text file: 'tidy dataset.txt'
in subfolder Rdocuments of current workdirectory

Each row in the final dataset contains subject, activity label, and measurements for all required features
 (mean and std)

