# General Description: 
# ====================
# Author: 
# -------
# Benjamin Mohn
# 
# Date: 
# -----
# 07.06.2018
#
# Description:
# ------------
# This script was created by me in order to finish the assignment of the 4th 
# week in the "Getting and Cleaning Data" Coursera Course.
#
# Structure:
# ---------- 
# This file is structured in two parts each will be described. 
#
# Assumption: 
# -----------
# This script can just be used in combination with the zip file downloaded from 
# the following link: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Furthermore it requires the working directory to be set to:
# UCI HAR Dataset 
###############################################################################

# Part 1:
# ========
# In the first part all requiered function are definied. 
# Each of the functiones will be descripet first by ther general porpuse and 
# then the Input and Output variables are described one after the other. 
# The Input values are described as follows: 
# param - This word indicates input parameters.
# (somestring) - After the word "param" there is the name of the paramter given
# [type] - In squared brackets the expected type of the parameter is given
# text - After the type there is a short text describing the parameter. 
# The output values are described as follows: 
# return - This word indictes the return value
# (somestring) - After the word "return" there is the name of the output given
# [type] - In squared brackets the type of the ouput is given
# test - After the type there is a short text describing the output. 
###############################################################################

read_samsung_file <- function(file){
        
        # This function reads in a specified file. 
        # param file: [str] file name and path to be read in
        # return read_data: [data.frame] The content of the specified file
        ##################################################################
        
        read_data <- read.table(file = file)
        return(read_data)
}

read_samsung_data <- function(group, features, activitiesmap){  
        
        # This function reads in a specified folder inside the UCI HAR Dataset folder 
        # This function is used to read in the test and training set. 
        # As well this function replaces the names and attaches the activities and subjects 
        # param group: [str] folder in the UCI HAR Dataset folder
        # param features: [vector] The names of the columns of the read in data
        # param activitiesmap: [data.frame] The dataframe where each row represents an activity
        # return measures: [data.frame] The content of the specified folder
        #######################################################################################
        
        # Reading the three files from the folder (group)
        subject <- read_samsung_file(paste0(group, "/subject_", group, ".txt"))
        activities <- read_samsung_file(paste0(group, "/y_", group, ".txt"))
        measures <- read_samsung_file(paste0(group, "/X_", group, ".txt"))
        
        # Setting names and attaching subjects and activities
        names(measures) <- features
        measures$subject <- subject$V1
        measures$activity <- factor(activities$V1, levels = activitiesmap[,1], labels = tolower(activitiesmap[,2]))
        
        return (measures)
}

createDataSet <- function(){  
        
        # This function created the unioned data set. 
        # There fore all the ".txt" files requiered are read in. 
        # return complete_data: [data.frame] The entire dataset from UCI HAR Dataset
        #######################################################################################
        
        # loading all ".txt" files 
        features <- read_samsung_file("features.txt")
        activities <- read_samsung_file("activity_labels.txt")
        train_data <- read_samsung_data("train", features[,2], activities)
        test_data <- read_samsung_data("test", features[,2], activities)
        
        # Binding togther the train and test set
        completed_ata <- rbind(train_data, test_data) 
}

meanOrStdColumn <- function(column){
        
        # This function is used to filter for the column names. 
        # param column: [str] - A column name
        # return : [boolean] - TRUE - if column contains either "mean", "std", "activity" or
        #                             "subject" later two are needed since they are used in step 5
        #######################################################################################
        
        return (grepl("mean\\(\\)|std\\(\\)|activity|subject", column))
}

getMask <- function(vect){
        
        # This function is used to create a vector of TRUE/FALSE- values. The length is equal
        # to the length of the input vector. 
        # param vect: [vector of strings] Vector of strings with the column names 
        # return mask: [vector of boolean] Vector with same length as input vector 
        #######################################################################################
        
        mask <- sapply(vect, meanOrStdColumn)
        return(mask)
}

extractRows <- function(data){
        
        # This function is used to filter the rows which are requiered. 
        # Rows requiered either contain "mean", "std", "activity" or "subject"
        # param data: [data.frame] A data frame whose rows shell be filteres
        # return : [data.frame] A data.frame only containing the rows of the input data.frame
        #                       That meet the criterea. 
        #######################################################################################
        
        mask <- getMask(names(data))
        return(data[,mask])
}

getNewName <- function(column){
        
        # This function process the colnames in order to make them human readable
        # param column: [str] - A column name to be processed
        # return column: [str] The processed column name with the following format:
        #                Beginning of str identifies the space, wethere time or fourier. 
        #                End of the string identifies wether "mean" or "std" and which of the 
        #                Directions where used (x,y,z) or if it is a mixture of all.
        #                In between part is mostly reused and just extended to words. 
        #               "subject" and "activity" stay as there are, since they are created by me.
        #               Words are in camel case, meaning strating with small letters and new word
        #               inside the string starts with capital letter. (I find it most readable)
        #########################################################################################
        
        # filtering for activity and subjuct column name. 
        if (column %in% c("subject", "activity")) return(column)
        
        # determine value space (time or fourier)
        column <- gsub("^t", "time", column)  
        column <- gsub("^f", "fourier", column) 
        
        # expanding Acc to acceleration and mag to Magnitude
        column <- gsub("[Aa]cc", "Acceleration", column)
        column <- gsub("[Mm]ag", "Magnitude", column)
        
        # making "mean" and "std" camel case.
        column <- gsub("mean", "Mean", column)
        column <- gsub("std", "Std", column)
        
        # Removing duplicated Body from column name
        column <- gsub("BodyBody", "Body", column)
        
        # Appending "All" if last letter is not X,Y or Z
        if (!grepl("([x-zX-Z]$)", column)) column <- paste0(column, "All")
        
        # Removing any special characters. 
        column <- gsub("-|\\(|\\)", "", column)
        
        return(column)
}

renameData <- function(data){
        
        # This function is used to rename all the column names. 
        # param data: [data.frame] Dataframe where all columns shell be renamed 
        # return data: [data.frame] Same data as input with renamed columns
        #######################################################################################
        
        names(data) <- sapply(names(data), getNewName)
        return(data)
}

averageData <- function(data){
        
        # This function is used to calculate the averade by the groups of subject and activity
        # param data: [data.frame] Data.frame to calculate averages from.
        # return : [data.frame] Data.frame with the averages of per acitivity and 
        #                       subject combination
        #######################################################################################
        
        return(aggregate(. ~ subject + activity, data=data, mean))
}

# Part 2
# =======
# Here the second parts start. These part just calls for of the functiones defined 
# In part 1. At the end the resulting dataframe will be stored in the current working
# directory. 
######################################################################################

# Calling the four functions
complete_data <- createDataSet()
reduced_data <- extractRows(complete_data)
renamed_data <- renameData(reduced_data)
averaged_data <- averageData(renamed_data)

# writing the final resut. 
write.table(averaged_data, "tidy_averages.txt", row.names = FALSE)
