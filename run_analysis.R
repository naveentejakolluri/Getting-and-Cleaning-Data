
#You should create one R script called run_analysis.R that does the following. 
#1)Merges the training and the test sets to create one data set.
#2)Extracts only the measurements on the mean and standard deviation for each measurement. 
#3)Uses descriptive activity names to name the activities in the data set
#4)Appropriately labels the data set with descriptive variable names. 
#5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.




dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, "Dataset.zip")
unzip("Dataset.zip", exdir="Dataset")

Filepath<- file.path("./Dataset" , "UCI HAR Dataset")

# Raading the test and the train files

Data_Features_Test<-read.table(file.path(Filepath,"test","X_test.txt"),header=FALSE)
Data_Features_Train<-read.table(file.path(Filepath,"train","X_train.txt"),header=FALSE)


Data_Activity_Test<-read.table(file.path(Filepath,"test","Y_test.txt"),header=FALSE)
Data_Activity_Train<-read.table(file.path(Filepath,"train","Y_train.txt"),header=FALSE)

Data_Subject_Test<-read.table(file.path(Filepath,"test","subject_test.txt"),header=FALSE)
Data_Subjct_Train<-read.table(file.path(Filepath,"train","subject_train.txt"),header=FALSE)

head(Data_Features_Test)
head(Data_Features_Train)
head(Data_Activity_Test)
head(Data_Activity_Train)
head(Data_Subject_Test)
head(Data_Subjct_Train)



# Merging the test and training data

Data_Features<-rbind(Data_Features_Train,Data_Features_Test)

Data_Activity<-rbind(Data_Activity_Train,Data_Activity_Test)

Data_Subject<-rbind(Data_Subjct_Train,Data_Subject_Test)

str(Data_Features)

str(Data_Activity)

str(Data_Subject)

#Assigning descriptive label names

names(Data_Subject)<-"Subject"
names(Data_Activity)<-"Activity"

dataFeaturesNames <- read.table(file.path(Filepath, "features.txt"),head=FALSE)

str(dataFeaturesNames)
dataFeaturesNames$V2

#Assigning the appropriate name

names(Data_Features)<-dataFeaturesNames$V2

#Merging the three datasets Activity,Subject and the Features into a single set


testdata<-cbind(Data_Subject,Data_Activity)

Merged_Data<-cbind(Data_Features,testdata)

names(Merged_Data)

str(Merged_Data)

# Creating a subset based on the column names like std() and mean()

Subset_DF_Names<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

Subset_DF_Names

names(Merged_Data)

#Appending the columns subject and activity to the list of columns.

Appended_list<-c(as.character(Subset_DF_Names), "Subject", "Activity" )
Appended_list

# Subsetting the data based on the columns above

Data<-Merged_Data[,Appended_list]

str(Data)

#Replacing Feature columns appropriately
# t--> Time
# f--> Frequency
# Acc --> Accelerometer
# Gyro --> Gyroscope
# Mag --> Magnitude
# BodyBody --> Body

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

names(Data)


# Creating an independent tidy data set with averaage of each variable.

#?aggregate

library(plyr)
Data2<-aggregate(. ~Subject + Activity, Data, mean)
Data2<-Data2[order(Data2$Subject,Data2$Activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)




