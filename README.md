# getting-and-cleaning-data-project
Course Project getting and cleaning data
This project uses data from the project 
All the data is available at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The dataset from this project comes from:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The project requirements are available at:

https://class.coursera.org/getdata-013/human_grading/view/courses/973500/assessments/3/submissions

Output:

In the repository https://github.com/tigretoncio/getting-and-cleaning-data-project there are 3 files available as solution for this project:

Readme.md: (this file)
Codebook.md : Contains the code book information of the variables used
run_analysis.R: The script code that cleans the data and performs the required activities

# How to run the script run_analysis.R
Unzip the data of the project, and copy the file run_analysis.R in the "UCI HAR Dataset" folder. 
Set the working directory on this "UCI HAR Dataset" folder too.
Execute the script using source("run_analysis.R").

The script will create the tidy data output "av_data.txt".  That result was added to the submission page.  

run_analysis.R uses the package dplyr. If not installed you can use the command > install.packages("dplyr") if the package is not available.

# To read the output in "av_data.txt"

The way of reading the file with tidy output is as follows:

  data <- read.table(file_path, header = TRUE) 
  View(data)

(as per https://class.coursera.org/getdata-013/forum/thread?thread_id=30)

Please note that if open in notepad there won´t be a clean way of viewing all data.

This output is a table of 180 rows and 68 columns.  180 rows because there are 30 individuals performing 6 different activities.  68 columns because they are 66 the variables related with mean and standard deviation as required in the project, plus 2 more columns for the activity and the subject ID.

# Structure of the input data

The data is being provided in different folders and files, mainly there are two sets of data: test and train.  The result comes from the original data and performing the following cleaning up activities as per the project requirements.  The activities that the 30 individuals perform are found in file "activity_labels.txt" with the following codes:

1	WALKING
2	WALKING_UPSTAIRS
3	WALKING_DOWNSTAIRS
4	SITTING
5	STANDING
6	LAYING

The variables measured are available in X_train and X_test, and contain raw data of 561 variables.  Script cleans data to reduce variable to 68 columns, which are the only ones with mean() and std() elements. Other variables such as gravityMean have been conciously left out of the solution, because the variable is not an explicit mean calculation.  This strategic decision is supported by https://class.coursera.org/getdata-013/forum/thread?thread_id=30



The script performs the following activities:
0.- Reads all the data files

1.- Merges the training and the test sets to create one data set.
For that it adds columns Activity and Subject ID to the train and test datasets, and then merges both datasets together using rbind, removing from memory temporary elements not used anymore

2.- Extracts only the measurements on the mean and standard deviation for each measurement. 
As above, 68 columns are extracted.  See Codebook for further information, and "features_info.txt" in the "UCI HAR Dataset" folder for further info about these variables.
3.- Uses descriptive activity names to name the activities in the data set (68 columns)
Changes the codes available in "activity_labels.txt" into the descriptive name.


4.- Appropriately labels the data set with descriptive variable names. 
The following transformations have been applied:
temp <- gsub("^t","time-",temp)   : A variable that starts with t is changed to start with "time"
temp <- gsub("^f","frequency-",temp) A variable that starts with f is changed to start with "frequency"
temp <- gsub("Acc","_Acceleration",temp) If variable contains "Acc" it is changed to "Acceleration"
temp <- gsub("Gyro","_Gyroscope-",temp) If variable containins "Gyro" it is changed to "Gyroscope"
temp <- gsub("Mag","-Magnitude-",temp) If variable containins "Mag" it is changed to "Magnitude"
temp <- gsub("BodyBody","Body-",temp) This is to correct evident errors in data: there are variables containing "BodyBody" and are changed to "Body"
temp <- gsub("std","standard_deviation",temp)  If variable containins "std" it is changed to "standard_deviation"
temp <- gsub("--","-",temp) Those ones are to uniformize variable names
temp <- gsub("-_","_",temp) Some as above

5.- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The result of the script analysis is a text document of name "av_data.txt". This contains a table of 180 rows and 68 columns, 180 is the result of having 30 individuals performing 6 different activities, and having collected 68 different variables per individual and activity.  This respects the tidy structrure required for the project.  This is performed using the dplyr package grouping by Activity and Subject_ID and summarising the data.


