#
# Process_WearComp_Data.R
#
#
#
#
#

# stats processing
message("Start processing: ", date(), "\n")

# print message to indicate time of data cleanup
message("Data download date: ", date(), "\n")

# Download the file from source
library(downloader)
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"
download(url, dest="dataset.zip", mode="wb") 

# Check if a data directory exists and create if NOT
if (!file.exists("data")) {
    dir.create("data")
}

# Unzip the file into the data directory 
unzip ("dataset.zip", exdir = "./data")

# Concatenate the training and test sets
# The follwowing needs to be concatenated
#    1. subject_test & subject_train
#    2. X_test & X_train
#    3. y_test & y_train

# subject_test & subject_train
message("Concatenating subject_test & subject_train")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",header=F)
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",header=F)
subject_all <- rbind(subject_test,subject_train)
message("Dimentions of Files:")
message("   subject_test..: ",nrow(subject_test)," x ",ncol(subject_test))
message("   subject_train.: ",nrow(subject_train)," x ",ncol(subject_train))
message("   concatenated..: ",nrow(subject_all)," x ",ncol(subject_all),"\n")

# X_test & X_train
message("Concatenating X_test & X_train")
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt",header=F)
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt",header=F)
X_all <- rbind(X_test,X_train)
message("Dimentions of Files:")
message("   X_test........: ",nrow(X_test)," x ",ncol(X_test))
message("   X_train.......: ",nrow(X_train)," x ",ncol(X_train))
message("   concatenated..: ",nrow(X_all)," x ",ncol(X_all),"\n")

# y_test & y_train
message("Concatenating y_test & y_train")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt",header=F)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt",header=F)
y_all <- rbind(y_test,y_train)
message("   y_test........: ",nrow(y_test)," x ",ncol(y_test))
message("   y_train.......: ",nrow(y_train)," x ",ncol(y_train))
message("   concatenated..: ",nrow(y_all)," x ",ncol(y_all),"\n")

# assign column name to subject_all 
message("Changing subject_all DF column name\n")
colnames(subject_all) <- c("Subject")

# read the features (column names) and assign to X_all
message("Changing X_all DF column names\n")
column_names <- read.table("./data/UCI HAR Dataset/features.txt",header=F)
colnames(X_all) <- column_names[,2]

# assign column name to y_all 
message("Changing y_all DF column name\n")
colnames(y_all) <- c("Activity_Code")

# remove columns not containing "mean()" OR "std()" from X_all
# Get a list of column containing "mean()" OR "std()" and extract only them
message("Removing unwanted column names from X_all")
useful_cols <- column_names[grep('mean|std',column_names[,2],ignore.case=TRUE),] 
slim_X_all <- X_all[,(names(X_all) %in% useful_cols[,2])]
message("   slim_X_all....: ",nrow(slim_X_all)," x ",ncol(slim_X_all),"\n")

# combine the 3 DFs (subject_all, y_all, X_all) into one
message("Combining the 3 DFs (subject_all, y_all, X_all) into one (all_data)")
all_data <- slim_X_all
all_data$Subject = subject_all$Subject
all_data$Activity_Code = y_all$Activity_Code
message("   all_data......: ",nrow(all_data)," x ",ncol(all_data),"\n")

# replace the activity code (1,2,3,4,5,6) with the descriptive value
message("Replacing the activity code (1,2,3,4,5,6) with the descriptive value")
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt",header=F)
colnames(activity_labels) <- c("Activity_Code","Activity")
all_data$Activity <- activity_labels$Activity[match(all_data$Activity_Code, activity_labels$Activity_Code)]
message("   all_data......: ",nrow(all_data)," x ",ncol(all_data),"\n")

# get the mean of all columns (variables) grouped on activity and subject
message("Get the mean of all columns (variables) grouped on activity and subject")
all_data_mean <- aggregate(all_data[1:85], 
                           by = all_data[c("Activity","Subject")],
                           FUN=mean, na.rm=TRUE)
message("   all_data_mean.: ",nrow(all_data_mean)," x ",ncol(all_data_mean),"\n")						   
						   
# finally write out the 2 new datasets to csv files
message("Finally write out the 2 new datasets to csv files\n")
write.csv(all_data,"./data/UCI HAR Dataset/TidyData.csv")
#write.csv(all_data_mean,"./data/UCI HAR Dataset/TidyDataMeans.csv")
write.table(all_data_mean,"./data/UCI HAR Dataset/TidyDataMeans.txt",row.name=FALSE)

# processing is now done
message("Processing complete: ", date(), "\n")
