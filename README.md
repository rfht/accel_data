Readme for run_analysis.R script
================================

This is the readme file to describe the function of run_analysis.R.

The purpose of this script is to take the data on human activity recognition from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones# and put it in a tidy format.

The first step consists of reading the different files (train/subject_train.txt, test/subject_test.txt, train/X_train.txt, test/X_test.txt, train/y_train.txt and test/y_test.txt) into variables. These variables serve only to be merged into one larger dataset that comprises the aggregate of the data in the different files.

After merging of the data into one data frame, all the unnecessary columns are discarded. For our purpose, only the mean and standard deviation colums remain. The code number for the different activities (see codebook) is converted to a descriptive name for each activity (this is currently still work in progress). Then the columns with the recorded variables are given proper names that describe their function/content.

In the next step, the average of all the measured data is calculated for each of the participants and each activity in a particular study participant. The result is written into a file by the name of "tidyset.txt".
