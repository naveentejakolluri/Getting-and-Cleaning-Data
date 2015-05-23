The purpose of this project is to demonstrate a candidate's ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis.

Transformations Performed.

1) Downloading the files from the url mentioned below.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2) Reading the test and the training data sets.
 
  Variable Name	                    Files/Variables Used
Data_Features_Test                	X_test.txt
Data_Features_Train	                X_train.txt
Data_Activity_Test	                Y_test.txt
Data_Activity_Train	                Y_train.txt
Data_Subject_Test	                  subject_test.txt
Data_Subjct_Train	                  subject_train.txt

3) Merging the test and training data

 Variable Name                       Files/Variables Used
 Data_Features                      Data_Features_Train,Data_Features_Test
 Data_Activity                      Data_Activity_Train,Data_Activity_Test
 Data_Subject                       Data_Subjct_Train,Data_Subject_Test
 
 4) Merging the  Activity, Subject and the Features datasets into a single set.
 
 Variable Name                      Files/Variables Used
 testdata                           Data_Subject,Data_Activity
 Merged_Data                        Data_Features,testdata
 
 5) Creating a subset of the dataset based on Column Names like std() and mean()
 
 Variable Name                      Files/Variables Used
 Appended_list                      Subset_DF_Names
 Data                               Merged_Data
 
 6) Creating an independent tidy dataset with average of each variable
 
 Variable Name                      Files/Variables Used
 Data2                              Data

