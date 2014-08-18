run_analysis<- function(){
    ## Load the reshape2 package
    library(reshape2)
    
    ## Step 1: Merges the training and the test sets to create one data set
    ## Read data into data frames
    subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
    y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
    subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
    y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
    ## Combine into one data set
    train <- cbind(subject_train, y_train, x_train)
    test <- cbind(subject_test, y_test, x_test)
    ds<-rbind(train, test)
 
    ## Step 4: Appropriately labels the data set with descriptive variable names
    feature <- read.table("./UCI HAR Dataset/features.txt")
    names(ds) <- c("subjectID", "activityID", as.character(feature$V2))
    
    ## Step 3: Use descriptive activity names to name the activities in the data set
    ## Read activity labels
    activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
    ## Assign activity labels as a factor
    ds$activityID <- factor(ds$activityID, labels=as.character(activities$V2)) 
    ## Transform subjectID as a factor
    ds$subjectID <- factor(ds$subjectID)
    
    ##Step 2: Extracts only the measurements on the mean and standard deviation
    ##        for each measurement.
    ## Extract subjectID, activityID, mean and standard deviation 
    ds_mean_std <- ds[, c(TRUE, TRUE, grepl("mean", names(ds))|grepl("std", names(ds)))]
    
    ## Step 5: Creates a second, independant tidy data set with the average of 
    ##         each variable for each activity and each subject
    ## Split data set in using subjectID factor and acticityID factor
    dsmelt <- melt(ds, id=c("subjectID", "activityID"))
    dstidy <- dcast(dsmelt, subjectID + activityID ~ variable, mean)
    
    ## Print file name being written to disk
    print("The following file are being written to disk:")
    print("- Step 2: DataSet_Mean_STD.csv")
    print("- Step 5: DataSet_mean_peractivityID_subjectID.csv")
    
    ## Write the resulting data set to files
    write.csv(ds_mean_std,"DataSet_Mean_STD.csv", row.names=FALSE)
    write.csv(dstidy, "DataSet_mean_peractivityID_subjectID.csv", row.names=FALSE)
    
    ##Return the tidy data set
    invisible(dstidy)
}