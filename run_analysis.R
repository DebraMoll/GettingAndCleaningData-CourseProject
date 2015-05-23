run_analysis <- function() {
  #to use this function set your working directory to the location of the UCI HAR Dataset
  #you must also have the data.table libray downloaded and accessible in R
  
  #set the library for data.table 
  library(data.table)
  
  #retrieve test and train test results
  dat_test_x <- read.table("./UCI HAR Dataset/test/x_test.txt") 
  dat_train_x <- read.table("./UCI HAR Dataset/train/x_train.txt") 
  dat_combined_x <- rbind(dat_test_x, dat_train_x)
  
  #retrieve the tests that were performed, 1-6
  dat_test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
  dat_train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
  dat_combined_y <- rbind(dat_test_y, dat_train_y)
  
  #retrieve the test subjects
  dat_test_sub <-read.table("./UCI HAR Dataset/test/subject_test.txt")
  dat_train_sub <-read.table("./UCI HAR Dataset/train/subject_train.txt")
  dat_combined_sub <- rbind(dat_test_sub, dat_train_sub)
  
  activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
  
  #get the name of the measurement representing each column in the combined_x dataset
  features <- read.table("./UCI HAR Dataset/features.txt")
  
  #filter to get feature position for mean and std deviation only
  features_mean_std <- rbind(features[grep("mean()", features[,2],fixed=TRUE),],features[grep("std()", features[,2],fixed=TRUE),])
  cols <- features_mean_std[order(as.numeric(features_mean_std[,1])),] #this orders the number and names of columns
  
  for(n in 1:nrow(cols)) {
    colnames(dat_combined_x)[as.numeric(cols[n,1])] <- as.character(cols[n,2])
  }
  dat_final_x <- dat_combined_x[ , which(colnames(dat_combined_x) %in% as.character(cols[,2]))]
  
  dat_final <- cbind(dat_combined_sub, dat_combined_y, dat_final_x)
  colnames(dat_final)[1:2] <- c("subject","activity")
  
  #replace "activity" values with ones that are descriptive, i.e. in the activities matrix
  for(n in 1:nrow(activities)){
    dat_final[,2] <- replace(dat_final[,2], as.character(dat_final[,2]) == as.character(activities[n,1]), as.character(activities[n,2]))
  }
  write.table(dat_final, file="dataset_UCIHAR_mean_and_sd.txt", row.names=FALSE)
  
  #get the mean of all the measurements by subject
  dat_output <- aggregate(dat_final[,3:68],by=list(subject=dat_final[,1],activity=dat_final[,2]), FUN=mean)
  write.csv(dat_output, file="dataset_UCIHAR_activity_mean_by_subject.txt", row.names=FALSE)
}
