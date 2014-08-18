GRunning the script

Clone this repository
Download the data set and extract. It should result in a UCI HAR Dataset folder that has all the files in the required structure.
Run the script called "run_analysis.R"
The tidy dataset should get created in the current directory as "DataSet_mean_peractivityID_subjectID.csv"
Code book for the tidy dataset is available here

Assumptions

The training and test data are available in folders named train and test respectively.
For each of these data sets:
Measurements are present in X_<dataset>.txt file
Subject information is present in subject_<dataset>.txt file
Activity codes are present in y_<dataset>.txt file
All activity codes and their labels are in a file named activity_labels.txt.
Names of all measurements taken are present in file features.txt ordered and indexed as they appear in the X_<dataset>.txt files.
All columns representing means contain ...mean() in them.
All columns representing standard deviations contain ...std() in them.
