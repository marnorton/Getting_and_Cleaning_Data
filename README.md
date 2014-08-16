Getting_and_Cleaning_Data
=========================

Assignment for Getting and Cleaning Data subject, for peer review.

README

This repository is for the assignment for Getting and Cleaning Data, a subject from the Coursera specialisation Data Science. 

The R run_analysis.R script meets the requirments set out in the assignment text in the file "Assignment.docx".

This repository stores the inputs, script, outputs, and the assignment requirements. 

The R script "run_analysis.r" takes in the following .txt files from the working directory:
UCI HAR Dataset/test/X_test.txt
UCI HAR Dataset/train/X_train.txt
UCI HAR Dataset/test/y_test.txt
UCI HAR Dataset/train/y_train.txt

The data is first combined into a single data frame for each of X and y datasets. 

Similarly, the subject datasets below are combined:
UCI HAR Dataset/test/subject_test.txt
UCI HAR Dataset/train/subject_train.txt

Finally, the features and activity datasets below are read in:
UCI HAR Dataset/features.txt
UCI HAR Dataset/activity_labels.txt

The data is given appropriate column names and name codes are replaced with useful descriptions in the dataset.

The mean and std deviation fields of interest are extracted and appropriately renamed and reordered.

The resulting data is written into the file "meanStdDevFeatures.txt".

The mean of each feature is taken by activity and by subject and written into the file "featureMeanSubjectActivity.txt".

All elements of the assignment were completed. 







.
