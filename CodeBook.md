# Code Book for Getting and Cleaning Data Course Project

The script downloads data collected from the accelerometers of Samsung Galaxy S smartphones. It then transforms the raw data into a tidy data set. The scipt also generates a second data set with averages.

## Data Source

UCI Machine Learning Repository
URL: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Data Set Description

Quoted from the UCI Website:
 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Main Transformation from Source

For this project the testing and training sets were combined and the vector features were reduced to only those containing means and standard deviations 

Each record in the main data set consists of the follwing:

1. A vector containing mean and standard deviation features

2. Its activity label (descriptive)

3. An identifier of the subject who carried out the experiment

## Summary Tranformation

The Main data set was then transformed into a second Summary data set containg the averages of each feature (variable) for each Activity and each Subject.

Both the Main and Summary data sets contain the same columns described further below.

## Column Description 

These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag 


For each of the above the following is provided:

mean(): Mean value

std(): Standard deviation


