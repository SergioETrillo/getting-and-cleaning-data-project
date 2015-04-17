#LIBRARY DPLYR IS REQUIRED

library(dplyr)

# READ DATA
# DATA NEEDS TO BE AVAILABLE IN THE WORKING DIRECTORY AS PER PROJECT REQUIREMENT

activity_labels <- read.table("activity_labels.txt", quote="\"")
features <- read.table("features.txt", quote="\"")
subject_test <- read.table("./test/subject_test.txt",quote="\"")
X_test <- read.table("./test/X_test.txt",quote="\"")
y_test <- read.table("./test/y_test.txt",quote="\"")
subject_train <- read.table("./train/subject_train.txt",quote="\"")
X_train <- read.table("./train/X_train.txt",quote="\"")
y_train <- read.table("./train/y_train.txt",quote="\"")



#changing column names to Activity in both test and train sets
#changing column names to Subject in both test and train sets
#changing column names to add features

colnames(y_test) <- "Activity"
colnames(y_train) <- "Activity"
colnames(subject_test) <- "Subject_ID"
colnames(subject_train) <- "Subject_ID"
colnames(X_test) <-features[,2]
colnames(X_train) <-features[,2]


# add Activity and subject columns in both test and train sets
X_test <- cbind(y_test,X_test)
X_test <- cbind(subject_test,X_test)
X_train <- cbind(y_train,X_train)
X_train <- cbind(subject_train,X_train)

# Combine both datasets
combined <- rbind(X_test,X_train)
rm(X_test,X_train)  # saves memory

# change labels from numbers to activities
labels <-as.character(activity_labels[,2])
for(i in 1:length(labels)) combined$Activity[combined$Activity == i] <-labels[i]

# select the columns with mean() or std() only, eg. fBodyAccJerk-meanFreq()-X is not selected
# as it is not mean() or std(), actually it is a bit more difficult to select it to remove the parentheses

meanstd <- grep("mean\\(\\)|std\\(\\)",names(combined),value=TRUE)
# we add the first two columns of activity and subject

meanstd <- c("Activity","Subject_ID",meanstd)
filtered.data <- combined[,meanstd]
rm(combined)     # to save memory

#4 Appropriately labels the data set with descriptive variable names. 
temp <- names(filtered.data)
temp <- gsub("^t","time-",temp)
temp <- gsub("^f","frequency-",temp)
temp <- gsub("Acc","_Acceleration",temp)
temp <- gsub("Gyro","_Gyroscope-",temp)
temp <- gsub("Mag","-Magnitude-",temp)
temp <- gsub("BodyBody","Body-",temp)
temp <- gsub("std","standard_deviation",temp)
temp <- gsub("--","-",temp)
temp <- gsub("-_","_",temp)

colnames(filtered.data) <-temp

# Creates tidy data set with averages, using dplyr package and the function
# summarise_each (http://www.rdocumentation.org/packages/dplyr/functions/summarise_each)

av.data <-group_by(filtered.data,Activity,Subject_ID) %>% summarise_each(funs(mean))
rm(filtered.data)  # save memory

# write to file text

write.table(av.data, file="av_data.txt", row.names=FALSE)



