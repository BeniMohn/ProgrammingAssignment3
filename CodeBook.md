# Programming Assignmet 3

## General Information

First of all some general information about the data. 
The data used in this repo was downloaded from the following link: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The Zip file in this link contains several files including one README.txt which explains 
the data and how it was used. 

This code book here will reuse a lot from that files and parts there. 

In the following this code book is structured as follows:

1. description of the Raw Data and a note for each variable wether it is contained in 
the tidy data set or not  
2. description of the result data frame what names are used. 
3. Information about how one can get from the raw to the tidy data. 

## RAW Data

The Raw Data was downloaded from the link mentioned above. The original source can be found
here: 
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The Data used in this setting here was first of all created by 30 subjects, where each
performed six actions (walking, walking_upstairs, walking_downstairs, sittin, standing, laying).
While doing those actions each subject had a Samsung Galaxy S II on its waist. 