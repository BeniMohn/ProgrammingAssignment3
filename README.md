# ReadME 

This repo was created by Benjamin Mohn at the 06.06.2018. Purpose of the repo is to pass the 
assignment of week 4 for the Coursera Cours "Getting and Cleaning Data". 

In this file a description of the repro and the files is to be found. As well it will be 
explained how to run the script and what the output is. 

## Repo

The repo contains three files. 
1. README.md
2. CodeBook.md
3. run_analysis.R

Each of the files will be shortly described. 

#### README.md

This is the file you are currently reading. Here a genereal description of the repo and 
how to run the "run_analysis.R" is to be fount. 

#### CodeBook.md

This file explains the tidy dataset which is created by the "run_analysis.R". 
As well the raw data and the source of the raw data are mentioned there. 

#### run_analysis.R

This is an R script which creates a tidy data set from 6 files contained in this zip-folder: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

When unpacking this zip a folder named "UCI HAR Dataset" is created.

**Important** This foldes should be set to be the working directory in order to make the script running. 

If the **working directory is set to "UCI HAR Dataset"** you can run the script. 
This script will create a file called "tidy_averages.txt" containing the tidy dataset. 
As well there will be a new data set in the environment which is named: "averaged_data".
This is the same as the data which is stored in the data set. As well couple of functions are created. 
This functions are described in the R script it self. Therefore they will be just named here
and not further described, in the brackets you find the parameters to call them. 
- read_samsung_file(file)
- read_samsung_data(group, features, activitiesmap)
- createDataSet()
- meanOrStdColumn(column)
- getMask(vect)
- extractRows(data)
- getNewName(column)
- renameData(data)
- averageData(data)
