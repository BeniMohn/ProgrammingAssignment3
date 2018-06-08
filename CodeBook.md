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

The raw data consisted of 6 fails. The data was split in a train set (70%) and a test set (30%).
Each of the sets was saved in 3 files. 
One file contained the measurements which will be described next. A second file stored information 
about the subject to whom those measures belong. The last file stored the information about the 
action the subject performed. 

The measurement consisted of 561 rows. Each representing some measure. Those measures have been:
- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

This part was taken from the "features_info.txt" from the downloaded zip-folder. 

## Tidy set

The tidy set was created according to the description for the assignment. 
Its dimensions are 180 rows and 68 columns. In the following at first the way the data set
was created is described. Afterwards each column name is stated and its origin from the raw data. 
Final step is a description of what the data is representing. 

### Set Creation

In order to create the tidy data the 6 files mentioned in the previous section were read in.
Additionally two other files have been read in which are: "features.txt" and "activity_labels.txt".
Now a short description of what was done to which file is done. 

#### features.txt

The file consists of 561 rows and 2 columns. The first column is just an index and the 
second column represents the column names of the files "X_test.txt" and "X_train.txt" in the folders
"test" and "train". There fore the second column of this file was attached to those to files as the 
column names. 

#### activity_labels.txt

This file contains the mapping from the number shown in "y_test.txt" and "y_train.txt" to the
activity the subject performed. There fore it consists of two column, and 6 rows. 
In the first column the number for the activity used in "y_test.txt" and  "y_train.txt" is shown. 
The second column shows the activity name. Therefore this file was used to replace the numbers in the 
two files stated with the according activity.  

#### y_test.txt/ y_train.txt

The files contain 1 column each and 7352 rows (train) and 2947 (test). 
Each row represents the activity of the corresponding row in "X_test.txt" and "X_train.txt". 
After the activities have been mapped to this file, the file was attached to the data of the 
"X_test.txt" and "X_train.txt" as the column "activity".  

#### subject_test.txt/subject_train.txt

This files again consist of one column the same row numbers as the previous described files.
Each row represents the subject whos measures are shown in the corresponding row in "X_test.txt" and "X_train.txt".
The content of this file was directly assigned to the read in data of "X_test.txt" and "X_train.txt"
as the column "subject".

#### X_test.txt/X_train.txt

This files contain each 561 columns and the same amount of rows as the previous two described files. 
After each column was assigned its name according to "features.txt" the content of the
"y_test.txt"/ "y_train.txt" and "subject_test.txt"/"subject_train.txt" where attached to the data 
as two column ones "activity" and "subject". 
The result at this point are two data.frames one representing the test data and the other the train data. 
Therefore the dimensiones are 563 columns each and 2947 rows for the test data and 7352  rows for the train data. 
The final step was to place the test data at the end of the train data to get the entire data in one data.frame. 
This data.frame therefore contains 563 columns and 10299 rows. 

### Column names

Now that the data set was created the columns have been selected and renamed.
At the beginning the desired columns have been selected. This was done based on the condition 
that the column name either contain the word "mean()" and "std()", those columns were requested by the task. 
But as well the two columns which were attached in the previous step need to be selected. There 
the condition was enriched with "activity" and "subject" to get these columns as well. 
After this filtering the data.frame contains still 10299 rows but now only 68 columns are left. 
Those columns have then be renamed. The basic ideas therefore where: 
1. replace beginning "t" with "time" and beginning "f" with "fourier"
	- because the initial letter determined in which frame they are.  
2. check for "Acc" or "Mag"
	- if "Acc" is contained in the name it is replaced with "Acceleration"
	- if "Mag" is contained, it is removed and "All" is appended to the end of the column 
3. "mean" or "std" are replaced with "Mean" or "Std"
4. replace "BodyBody" with "Body"
	- couple of columns have BodyBody in their name
5. remove all special charakters ( "-", "(", ")" )

#### activity 

This column if factor consisting 6 levels each representing one of the actions a subject did. 

#### subject

This columns indicates to whom of the 30 subjects the current row belongs. The subjects are numbered
from 1 to 30.  

##### timeBodyAccelrationMeanX/timeBodyAccelrationMeanY/timeBodyAccelrationMeanZ

Those three columns come from the original columns: 
tBodyAcc-mean()-X/tBodyAcc-mean()-Y/tBodyAcc-mean()-Z

##### timeBodyAccelrationStdX/timeBodyAccelrationStdY/timeBodyAccelrationStdZ

Those three columns come from the original columns: 
tBodyAcc-std()-X/tBodyAcc-std()-Y/tBodyAcc-std()-Z

##### timeGravityAccelrationMeanX/timeGravityAccelrationMeanY/timeGravityAccelrationMeanZ

Those three columns come from the original columns: 
tGravityAcc-mean()-X/tGravityAcc-mean()-Y/tGravityAcc-mean()-Z

##### timeGravityAccelrationStdX/timeGravityAccelrationStdY/timeGravityAccelrationStdZ

Those three columns come from the original columns: 
tGravityAcc-std()-X/tGravityAcc-std()-Y/tGravityAcc-std()-Z

##### timeBodyAccelrationJerkMeanX/timeBodyAccelrationJerkMeanY/timeBodyAccelrationJerkMeanZ

Those three columns come from the original columns: 
tBodyAccJerk-mean()-X/tBodyAccJerk-mean()-Y/tBodyAccJerk-mean()-Z

##### timeBodyAccelrationJerkStdX/timeBodyAccelrationJerkStdY/timeBodyAccelrationJerkStdZ

Those three columns come from the original columns: 
tBodyAccJerk-std()-X/tBodyAccJerk-std()-Y/tBodyAccJerk-std()-Z

##### timeBodyGyroMeanX/timeBodyGyroMeanY/timeBodyGyroMeanZ

Those three columns come from the original columns: 
tBodyGyro-mean()-X/tBodyGyro-mean()-Y/tBodyGyro-mean()-Z

##### timeBodyGyroStdX/timeBodyGyroStdY/timeBodyGyroStdZ

Those three columns come from the original columns: 
tBodyGyro-std()-X/tBodyGyro-std()-Y/tBodyGyro-std()-Z

##### timeBodyGyroJerkMeanX/timeBodyGyroJerkMeanY/timeBodyGyroJerkMeanZ

Those three columns come from the original columns: 
tBodyGyroJerk-mean()-X/tBodyGyroJerk-mean()-Y/tBodyGyroJerk-mean()-Z

##### timeBodyGyroJerkStdX/timeBodyGyroJerkStdY/timeBodyGyroJerkStdZ

Those three columns come from the original columns: 
tBodyGyroJerk-std()-X/tBodyGyroJerk-std()-Y/tBodyGyroJerk-std()-Z

##### timeBodyAcclerationMeanAll

This column is derived from the column: 
tBodyAccMag-mean()

##### timeBodyAcclerationStdAll

This column is derived from the column: 
tBodyAccMag-std()

##### timeGravityAcclerationMeanAll

This column is derived from the column: 
tGravityAccMag-mean()

##### timeGravityAcclerationStdAll

This column is derived from the column: 
tGravityAccMag-std()

##### timeBodyAcclerationMeanAll

This column is derived from the column: 
tBodyAccMag-mean()

##### timeBodyAcclerationStdAll

This column is derived from the column: 
tBodyAccMag-std()

##### timeBodyAcclerationJerkMeanAll

This column is derived from the column: 
tBodyAccJerkMag-mean()

##### timeBodyAcclerationJerkStdAll

This column is derived from the column: 
tBodyAccJerkMag-std()

##### timeBodyGyroMeanAll

This column is derived from the column: 
tBodyGyroMag-mean()

##### timeBodyGyroStdAll

This column is derived from the column: 
tBodyGyroMag-std()

##### timeBodyGyroJerkMeanAll

This column is derived from the column: 
tBodyGyroJerkMag-mean()

##### timeBodyGyroJerkStdAll

This column is derived from the column: 
tBodyGyroJerkMag-std()

##### fourierBodyAccelrationMeanX/fourierBodyAccelrationMeanY/fourierBodyAccelrationMeanZ

Those three columns come from the original columns: 
fBodyAcc-mean()-X/fBodyAcc-mean()-Y/fBodyAcc-mean()-Z

##### fourierBodyAccelrationStdX/fourierBodyAccelrationStdY/fourierBodyAccelrationStdZ

Those three columns come from the original columns: 
fBodyAcc-std()-X/fBodyAcc-std()-Y/fBodyAcc-std()-Z

##### fourierGravityAccelrationMeanX/fourierGravityAccelrationMeanY/fourierGravityAccelrationMeanZ

Those three columns come from the original columns: 
fGravityAcc-mean()-X/fGravityAcc-mean()-Y/fGravityAcc-mean()-Z

##### fourierravityAccelrationStdX/fourierGravityAccelrationStdY/fourierGravityAccelrationStdZ

Those three columns come from the original columns: 
fGravityAcc-std()-X/fGravityAcc-std()-Y/fGravityAcc-std()-Z

##### fourierBodyAccelrationJerkMeanX/fourierBodyAccelrationJerkMeanY/fourierBodyAccelrationJerkMeanZ

Those three columns come from the original columns: 
fBodyAccJerk-mean()-X/fBodyAccJerk-mean()-Y/fBodyAccJerk-mean()-Z

##### fourierBodyAccelrationJerkStdX/fourierBodyAccelrationJerkStdY/fourierBodyAccelrationJerkStdZ

Those three columns come from the original columns: 
fBodyAccJerk-std()-X/fBodyAccJerk-std()-Y/fBodyAccJerk-std()-Z

##### fourierBodyGyroMeanX/fourierBodyGyroMeanY/fourierBodyGyroMeanZ

Those three columns come from the original columns: 
fBodyGyro-mean()-X/fBodyGyro-mean()-Y/fBodyGyro-mean()-Z

##### fourierBodyGyroStdX/fourierBodyGyroStdY/fourierBodyGyroStdZ

Those three columns come from the original columns: 
fBodyGyro-std()-X/fBodyGyro-std()-Y/fBodyGyro-std()-Z

##### fourierBodyGyroJerkMeanX/fourierBodyGyroJerkMeanY/fourierBodyGyroJerkMeanZ

Those three columns come from the original columns: 
fBodyGyroJerk-mean()-X/fBodyGyroJerk-mean()-Y/fBodyGyroJerk-mean()-Z

##### fourierBodyGyroJerkStdX/fourierBodyGyroJerkStdY/fourierBodyGyroJerkStdZ

Those three columns come from the original columns: 
fBodyGyroJerk-std()-X/fBodyGyroJerk-std()-Y/fBodyGyroJerk-std()-Z

##### fourierBodyAcclerationMeanAll

This column is derived from the column: 
fBodyAccMag-mean()

##### fourierBodyAcclerationStdAll

This column is derived from the column: 
fBodyAccMag-std()

##### fourierGravityAcclerationMeanAll

This column is derived from the column: 
fGravityAccMag-mean()

##### fourierGravityAcclerationStdAll

This column is derived from the column: 
fGravityAccMag-std()

##### fourierBodyAcclerationMeanAll

This column is derived from the column: 
fBodyAccMag-mean()

##### fourierBodyAcclerationStdAll

This column is derived from the column: 
fBodyAccMag-std()

##### fourierBodyAcclerationJerkMeanAll

This column is derived from the column: 
fBodyBodyAccJerkMag-mean()

##### fourierBodyAcclerationJerkStdAll

This column is derived from the column: 
fBodyBodyAccJerkMag-std()

##### fourierBodyGyroMeanAll

This column is derived from the column: 
fBodyBodyGyroMag-mean()

##### fourierBodyGyroStdAll

This column is derived from the column: 
fBodyBodyGyroMag-std()

##### fourierBodyGyroJerkMeanAll

This column is derived from the column: 
fBodyBodyGyroJerkMag-mean()

##### fourierBodyGyroJerkStdAll

This column is derived from the column: 
fBodyBodyGyroJerkMag-std()


### Data set

The final tidy data set consists of 180 rows and 68 columns. The columns are the same as the 
ones listed above. Each rows is a unique pair of subject and activity identified by the two 
columns "subject" and "activity". The other columns are now the average of the corresponding values
for all observations of this pair. 