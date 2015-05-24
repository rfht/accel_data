# Get the current working directory to reset it at the end of the script and change working directory to the location of the data.

currentwd <- getwd()
setwd("UCI HAR Dataset")

# Read the files
subTrain <- read.table("train/subject_train.txt", nrows=7352)
subTest <- read.table("test/subject_test.txt", nrows=2947)
xTrain <- read.table("train/X_train.txt", nrows=7352)
xTest <- read.table("test/X_test.txt", nrows=2947)
yTrain <- read.table("train/y_train.txt", nrows=7352)
yTest <- read.table("test/y_test.txt", nrows=2947)

train <- cbind(subTrain, yTrain, xTrain)

test <- cbind(subTest, yTest, xTest)

# Merge the files

merged <- rbind(train, test)

# Extract mean and standard deviation for each measurement

meansdOnly <- merged[, c(1:2, 3:8, 43:48, 83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 242:243, 255:256, 268:273, 347:352, 426:431, 505:506, 518:519, 531:532, 544:545)]
# Rename activity names in a descriptive way

activities <- read.table("activity_labels.txt", nrows=6)
activities <- as.character(activities[, 2])
# for(i in 1:10299) {
#	meansdOnly[i, 2] <- activities[meansdOnly[i, 2]]
# }

# Rename the variables in a descriptive way

columnames <- c("Test subject", "Activity", "Mean of body acceleration in X", "Mean of body acceleration in Y", "Mean of body acceleration in Z", "Standard deviation of body acceleration in X", "Standard deviation of body acceleration in Y", "Standard deviation of body acceleration in Z", "Mean of gravity acceleration in X", "Mean of gravity acceleration in Y", "Mean of gravity acceleration in Z", "Standard deviation of gravity acceleration in X", "Standard deviation of gravity acceleration in Y", "Standard deviation in gravity acceleration in Z", "Mean jerking body acceleration in X", "Mean jerking body acceleration in Y", "Mean jerking body acceleration in Z", "Standard deviation of jerking body acceleration in X", "Standard deviation of jerking body acceleration in Y", "Standard deviation of jerking body acceleration in Z", "Mean Body Gyro X", "Mean Body Gyro Y", "Mean Body Gyro Z", "Standard deviation body gyro X", "Standard deviation body gyro Y", "Standard deviation body gyro Z", "Mean Body Gyro Jerk X", "Mean Body Gyro Jerk Y", "Mean Body Gyro Jerk Z", "Standard deviation body gyro jerk X", "Standard deviation body gyro jerk Y", "Standard deviation body gyro jerk Z", "Magnitude of body acceleration - mean", "Magnitude of body acceleration - standard deviation", "Magnitude of gravity acceleration - mean", "Magnitude of gravity acceleration - standard deviation", "Magnitude of jerking body acceleration - mean", "Magnitude of jerking body acceleration - standard deviation", "Magnitude of body gyro - mean", "Magnitude of body gyro - standard deviation", "Magnitude of body gyro jerk - mean", "Magnitude of body gyro jerk - standard deviation", "f - mean body acceleration X", "f - mean body acceleration Y", "f - mean body acceleration Z", "f - standard deviation of body acceleration X", "f - standard deviation of body acceleration Y", "f - standard deviation of body acceleration Z", "f - mean of jerking body acceleration X", "f - mean of jerking body acceleration Y", "f - mean of jerking body acceleration Z", "f - standard deviation of jerking body acceleration X", "f - standard deviation of jerking body acceleration Y", "f - standard deviation of jerking body acceleration Z", "f - mean of body gyro X", "f - mean of body gyro Y", "f - mean of body gyro Z", "f - standard deviation of body gyro X", "f - standard deviation of body gyro Y", "f - standard deviation of body gyro Z", "f - mean magnitude of body acceleration", "f - standard deviation of magnitude of body acceleration", "fBodyBodyAccJerkMag-mean", "fBodyBodyAccJerkMag-std", "fBodyBodyGyroMag-mean", "fBodyBodyGyroMag-std", "fBodyBodyGyroJerkMag-mean", "fBodyBodyGyroJerkMag-std")

colnames(meansdOnly) <- columnames

# Create data set with average of each variable for each activity and each subject

tidy <- data.frame(NULL)
for(i in 1:30) {
	for(j in 1:5) {
		tidy <- rbind(tidy, c(i, j, sapply(meansdOnly[meansdOnly[1, ] == i & meansdOnly[2, ] == j, 3:68], mean)))
	}
}
colnames(tidy) <- columnames

# Create tidy data set as txt file with write.table() (with row.name=FALSE)

write.table(tidy, file = "tidyset.txt", row.name = FALSE)

# Restore the original working directory

setwd(currentwd)
