run_analysis <- function()
{
  # Assignment for Getting and Cleaning Data
  # Creates a tidy data set which may be used in downstream analysis.
  
  # Ensure that required packages are loaded
  library(plyr)
  library(reshape2)
  
  #Section 1: Merges the training and the test sets to create one data set.
  
  # Read in data from raw text files from the working directory folder
  rawXTest <- read.table("UCI HAR Dataset//test//X_test.txt", comment.char = "", colClasses = c("numeric")) #nrows = 2950,
  rawXTrain <- read.table("UCI HAR Dataset//train//X_train.txt", comment.char = "", colClasses = c("numeric")) #nrows = 7355, 
  rawyTest <- read.table("UCI HAR Dataset//test//y_test.txt", colClasses = c("factor"))
  rawyTrain <- read.table("UCI HAR Dataset//train//y_train.txt", colClasses = c("factor"))
  rawsubjectTest <- read.table("UCI HAR Dataset//test//subject_test.txt")
  rawsubjectTrain <- read.table("UCI HAR Dataset//train//subject_train.txt")
  
  # Combine the X Test and X Train datasets, and y Test and y Train datasets
  X <- rbind(rawXTrain,rawXTest)
  y <- rbind(rawyTrain,rawyTest) 
  
  # Combine the subject datasets
  subject <- rbind(subjectTrain,subjectTest)
  
  # Remove all raw datasets which have already been combined above from memory
  rm(subjectTest, subjectTrain, yTest, yTrain, XTest, XTrain)
  
  
  # Read in the features and activity names
  features <- read.table("UCI HAR Dataset//features.txt")
  activities <- read.table("UCI HAR Dataset//activity_labels.txt",stringsAsFactor=FALSE)
  
  # Assign useful names to the columns in features and activities
  names(features) <- c("featureNumber","featureName")
  names(activities) <- c("activityNumber","activityName")
  
  # Translate the y dataset values from codes to activity names 
  y <- revalue(y$V1, c("1"=activities$activityName[1], 
                       "2"=activities$activityName[2],
                       "3"=activities$activityName[3],
                       "4"=activities$activityName[4],
                       "5"=activities$activityName[5],
                       "6"=activities$activityName[6]))
  
  
  
  
  
  # write.table( row.name=FALSE)
  
}