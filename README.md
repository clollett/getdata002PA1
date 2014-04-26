This is a readme file for Programming Assignment in Getting and Cleaning Data Course

The script to run is: run_analysis.R  which can be run by using source("run_analysis.R")
In order to work the directory "UCI HAR Dataset" should be a directory in the working directory
in your R environment
The outputfile name is tidyset.txt and it will be in the working directory.

This script contains functions:
1)Get_TrainandTest_Datatables(path): this is the main function which basically executes all the transformations described in Codebook.md
2)getMeanRow(dataframe): an accesory function for lapply to process a subset of the data splitted by subject and activity, in order to obtain a row with the mean values 
of the rest of the features.

For details of transformation sequences, please refer to Codebook.md

