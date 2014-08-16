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
  rawSubjectTest <- read.table("UCI HAR Dataset//test//subject_test.txt")
  rawSubjectTrain <- read.table("UCI HAR Dataset//train//subject_train.txt")
  
  # Combine the X Test and X Train datasets, and y Test and y Train datasets
  X <- rbind(rawXTrain,rawXTest)
  y <- rbind(rawyTrain,rawyTest) 
  
  # Combine the subject datasets
  subject <- rbind(rawSubjectTrain,rawSubjectTest)
  
  # Remove all raw datasets which have already been combined above from memory
  rm(rawSubjectTest, rawSubjectTrain, rawyTest, rawyTrain, rawXTest, rawXTrain)
  
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
  
  # Search for feature names which contain mean or std text
  featuresToKeep <- grep("mean|std()",features$featureName)
    
  # Create vector of feature names from the selected feature names
  namesVector <- c("subject.id","activity", as.character(features$featureName[featuresToKeep])) 
  
  # These steps are to separate the individual words in the feature names with full stops "." to ensure consistency:
  # A. Where there is a change from lower case to upper case (which indicates a new word), place a full stop "." inbetween
  namesVector <- gsub("([a-z])([A-Z])", "\\1.\\2", namesVector, perl = TRUE)
  # B. Replace dashes "-" with fullstops "."
  namesVector <- gsub("-",".", namesVector, perl=TRUE)
  # C. Replace double brackets "()" with fullstops "."
  namesVector <- gsub("()","", namesVector, fixed=TRUE)
  # D. Make all letters lower case
  namesVector <- tolower(namesVector)
  
  # Bind columns of subject ID, the activity and the mean and standard deviation features 
  # and write it out to the file meanStdDevFeatures.txt
  meanStdDevFeatures <- cbind(subject,y,X[,featuresToKeep])
  
  # Assign namesVector to columns dataset meanStdDevFeatures
  names(meanStdDevFeatures) <- namesVector
  
  # Sort the meanStdDevFeatures dataset by its columns
  meanStdDevFeatures <- arrange(meanStdDevFeatures, 
                                meanStdDevFeatures$subject.id)
  
  # Write the dataset created
  write.table(meanStdDevFeatures,"meanStdDevFeatures.txt",row.names=FALSE)
  
  # Create a tidy names vector
  tidyNamesVector <- paste("average(",namesVector,")",sep="")
  tidyNamesVector[1:2] <- c("subject.id","activity")
  
  # Create a dataset of the average for each feature by activity and by subject
  # and write it to the file featureMeanSubjectActivity.txt
  meltedData <- melt(meanStdDevFeatures, id = c("subject.id","activity"))
  meanTable <- dcast(meltedData, subject.id + activity ~ variable, mean)
  names(meanTable) <- tidyNamesVector
  write.table(meanTable,"featureMeanSubjectActivity.txt",row.names=FALSE)
  
  
  
}