# GettingAndCleaningData-CourseProject
This repository contains all of the files for the Coursera "Getting and Cleaning Data" course. The contents are:

- "run_analysis.R" - the R program that loads data from the UCI HAR dataset and acts upon this data to produce two data sets 
- "dataset_UCIHAR_mean_and_sd.txt" - text file that combines data from the UCI HAR datasets. This contains the mean and standard deviations only
- "dataset_UCIHAR_activity_mean_by_subject.txt" - text file that is the submitted tidy data set for the course. it acts upon the mean_and_sd file to get the mean for each measurement by subject and activity.

run_analysis.R - The R program reads data from the UCI HAR datasets, which are the results of the collection of multiple measurements for 30 subjects performing 6 different activities with a Samsung phone attached to their waste which collected measurements. The program does the following:
- Reads in the test and training measurements for the UCI HAR dataset and combines these into one file. 
- Reads in the activity (1-6) information for test and training groups that correspond to the measurements taken
- Reads in the subject information for test and training that correspond to the measurements taken
- Reads in the labels for the activities, 1-6
- Reads in the labels that provide desciptive text of the measurements taken
- Filters the data to extract only the mean and standard deviation measurements
- Combines all of the datasets (measurements, activities, and subjects) into one dataset that can be used for analysis
- Adds the descriptive activity labels
- Outputs the combined dataset to a text file
- Calculates the mean for all measurements by subject and activity and outputs this to a text file.



