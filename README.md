### Explanation of run_analysis.R

## Raw Data
Raw data to be processed is available here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Unzip the downloaded zip file, and then put 'UCI HAR Dataset' folder at the same location with run_analysis.R.
You should focus on the following files:
1. activity_labels.txt
2. features.txt
3. features_info.txt
4. README.txt
5. Files in test folder, except under Inertial Signals directory
6. Files in train folder, except under Inertial Signals directory

## Data Processing Data
Following are steps to tidy the raw data:
1. Load additional required library
    The script requires 'dplyr' package as functions such as arrange, group_by, and summarise_each are used.

2. Process feature's variable names
    Feature's variable names are stored in 'features.txt'. These variables would name variables in measurement dataset. The script focuses to variables whose names contains 'mean()' or 'std()'. After the necessary variables are retrieved, their names should be renamed to reflect descriptive variable names suggestion. In this case, '()' or '-' would be replaced by '_'. In addition, prefix 'f' and 't' would be replaced by 'freq' and 'time' respectively.
    
3. Process activity names
    Activity names are stored in 'activity_labels.txt'. 

4. Prepare subject dataset
    Subject variable is stored in two places: 'subject_test.txt' and 'subject_train.txt'. 

5. Process activity dataset
    Activity variable is stored in two places: 'y_test.txt' and 'y_train.txt'. Using this variable, obtain activity name which has been retrieved in Step 3. Put the activity name variable next to activity variable.
    
6. Process measurement dataset
    Measurement variables are stored in two places: 'X_test.txt' and 'X_train.txt'. Using feature variables filtered in Step 2, remove unnecessary variables.

7. Create first dataset
    Combine subject, activity, and measurement dataset into the first tidy dataset. Sort this dataset by subject and then activity in ascending order.
    
8. Create second dataset
    Using the dataset generated in Step 7, group it by subject, activity, and activity name. The measurement variables are grouped by calcutaing their average.

9. Process output
    Write the second dataset into a .txt file.

--eof---