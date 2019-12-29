# UCI-HAR-Dataset



Human Activity Recognition database is built from the recordings of 30 persons of 19- 48 years who are performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors. while wearing smartphones at their waist they are asked to perform six activities like STANDING, WALKING etc., using the embedded inertial sensors, the 70% of volunteers are under trained sets and 30% of test data set observation.

Trained Set and test set raw data is analysed. Real time data set is cleansed to provide the tidy data as ouptut. 

Script works in a way like,

Data download and unzip the folder in the newly created directory "UCI HAR Dataset". If the file doesn't exist, then file will be downloaded using download command in the current working directory.After downloading the file, data is extracted by "read.table" command to be stored in the local variables. Creating the single data set named "dataSet" by merging the training and test datasets. while subjects train and test data sets are merged  . 

while training lables and test lables are merged in the same way as datasets in a separate dataset named "activity". 
From features file, mean or standard deviation column names are separated from features list. Using the index list we extract those data from dataset as part of cleaning process.

Finally, Descriptive labels are assigned for each data sets and merged into single dataset "dataSet" vertically. Activites column are used as levels to be helpful to calculate the mean. Reshaping the data is used for efficient data set. melting and dcast is done to recalculate the mean of subjects and activities of raw data efficiently. Thus, final data set is considered to be written in a txt format to produce tidy data as result with row names as False.

