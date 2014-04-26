Codebook for Programming Assignment in Getting and Cleaning Data Course

There were the following sources

features.txt: it was imported into featuredata dataframe, which 2 columnns, one numerical and the second one as factor with the labels of the features of the X_train and X_test datasets. 
This second column was coerced into a character vector, which was stored in featurenames to use it for train and test dataset header

X_train.txt and X_test.txt: they contain the data from each observation, which a total of 561, the rest were the actual measurements or summarizing features of those measurements. 
However, they don't contains any header. Both files were imported into traintable and testtable dataframes,in both cases the vector featurenames was assigned as a header 
in traintable and testtable before merging them using rbind into mergeddataset. mergeddataset was subsetted so only columns with features containing mean() or std() were allowed to stay. 
This result was store in preferredmergeddataset dataframe. This was accomplished by using regular expressions over the header names.

subject_train.txt and subject_test.txt: contains the subject id for each observation. They were imported into trainsubject and testsubject dataframes.
y_train.txt and y_test.txt: containts the activity code for each observation. They were imported into trainactivitycode and testactivitycode dataframes.

Those last four dataframes were combined using cbind and rbind, to get a dataframe with subject id and activity code for all observations named mergedpredataset, 
which is aligned with mergeddataset

activity_labels.txt: it contains the information that links activity codes with the descriptive wording of the activity. 
This was imported into activitytable dataframe to work as a lookup table. Using apply with activitytable a dataframe column was created, named labelactivity with the description of activities aligned with 
mergeddataset. mergedpredataset was recreated with the subject id column from itself and labelactivity, leaving out the activity code.

Using cbind mergedpredataset was preappended to preferredmergeddataset, which is the main unsummarized dataframe in this task.

preferredmergeddataset was splitted in groups by both subject and activity and the result was a list of dataframes splitpreferredmergeddataset. 

Using lapply and a custom function each dataframe in the list splitpreferredmergeddataset was summarized to give
the mean of all the columns but subject and activity which were copied from the first row in the dataframe. The result is the list of dataframe rows
ldf. 

By looping all dataframe rows in ldf were integrated into a one dataframe named newDataFrame, which is our actual output

newDataFrame was output to tidyset.txt

  