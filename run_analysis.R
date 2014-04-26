
## function that takes the root path of the datasets to start the process
Get_TrainandTest_Datatables <- function(UCI_HAR_Dataset_path) {
  
  ## Obtaining feature data
  featuredata <- read.table(paste(UCI_HAR_Dataset_path,"UCI HAR Dataset/","features.txt", sep=""))
  ## Changing feature 2 Activity code into character
  featurenames <- as.character(featuredata[,2])
  ## load train table
  traintable <- read.table(paste(UCI_HAR_Dataset_path,"UCI HAR Dataset/train/","X_train.txt", sep=""))
  names(traintable) <- featurenames
  ## load test table
  testtable <- read.table(paste(UCI_HAR_Dataset_path,"UCI HAR Dataset/test/","X_test.txt", sep=""))
  names(testtable) <- featurenames
  ## join train and test set together
  mergeddataset <- rbind(traintable,testtable)
  ## Using regular expressions to get selected feature names main() and std()
  preferredfeaturenames <- featurenames[grep("mean\\(|std\\(",featurenames)]
  ## Subsetting accordingly
  preferredmergeddataset <- mergeddataset[preferredfeaturenames]
  ## loading subjects in training set
  trainsubject <- read.table(paste(UCI_HAR_Dataset_path,"UCI HAR Dataset/train/","subject_train.txt", sep=""), colClasses="factor")
  ## loading activity codes in training set
  trainactivitycode <- read.table(paste(UCI_HAR_Dataset_path,"UCI HAR Dataset/train/","y_train.txt", sep=""),colClasses="factor")
  ## loading subjects in testing set
  testsubject <- read.table(paste(UCI_HAR_Dataset_path,"UCI HAR Dataset/test/","subject_test.txt", sep=""),colClasses="factor")
  ## loading activity codes in testing set
  testactivitycode <- read.table(paste(UCI_HAR_Dataset_path,"UCI HAR Dataset/test/","y_test.txt", sep=""),colClasses="factor")
  ## join subject and activity codes from training and testing data
  mergedpredataset <- rbind(cbind(trainsubject,trainactivitycode),cbind(testsubject,testactivitycode))
  names(mergedpredataset) <- c("Subject","Activity Code")
  ## loading code->name about activities
  activitytable <- read.table(paste(UCI_HAR_Dataset_path,"UCI HAR Dataset/","activity_labels.txt", sep=""))
  names(activitytable) <- c("Activity Code","Activity Label")
  ## lookup activity table to get dataset activity information in description
  labelactivity <- apply(mergedpredataset["Activity Code"], 1, function(x) activitytable[x,"Activity Label"] )
  ## join subject and activity information
  mergedpredataset <- cbind(mergedpredataset["Subject"],labelactivity)
  names(mergedpredataset)[2]="Activity"
  ## join all data
  preferredmergeddataset <- cbind(mergedpredataset,preferredmergeddataset)
  ## function that takes a dataframe using the first row to put subject and activity information, 
  ## then use colMeans to get the mean of each variable
  getMeanRow <- function(X) {
    Xdim <-dim(X)
    newRow <- X[1,]
    newRow[1,3:Xdim[2]]=colMeans(X[,3:Xdim[2]])
    newRow
    
    
  }
  ## Splitting data by subject and activity, obtaining a list
  splitpreferredmergeddataset <- split(preferredmergeddataset,paste(preferredmergeddataset$Subject,preferredmergeddataset$Activity))
  ##getMeanRow(splitpreferredmergeddataset[[1]])
  ## Using lapply to apply getMeanRow at element list, getting the result in a list ldf
  ldf <- lapply(splitpreferredmergeddataset,getMeanRow)
  ## Store the information in the first element of ldf
  newDataFrame <- ldf[[1]]
  ## Appending the rest of the dataframe rows from ldf list
  for (i in seq_along(ldf)) {
    
    if (i>1) {
      
      
      newDataFrame <- rbind(newDataFrame,ldf[[i]])
      
    }
    
  }
  ## returning the dataframe
  return(newDataFrame)

  
  
  
  
  
  
}
## asking for dataset mainpath
dspath <- ""
## executing main function
tidyset <- Get_TrainandTest_Datatables(dspath)
## New set of
print(paste("Tidy dataset of ",nrow(taddyset)," observations and ",ncol(taddyset)," columns \n"))
## writing to a file
write.table(tidyset,"tidyset.txt")
## message
print("dataset stored in tidyset.txt")