# Download and preprocess dataset of accelerometer data collected by 
# smartphones worn by human subjects performing various activities.
#
# The raw data may be found at 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# The data is described at
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
#
# Function Library:
#
# k.HAR.Data.constants......Returns a list with constants used by other
#                           functions as environment variables
#
# Download.HAR.Data.........Sets up the data directory, downloads the data 
#                           and unpacks it.
#                           Strictly speaking not part of the assignment, but
#                           included for reproducability.
# run_analysis..............Preprocesses the data.
#                           This is the function that is submitted 
#                           for grading


#Column Data
#Mean Values
# $ grep mean features.txt
# 1 tBodyAcc-mean()-X
# 2 tBodyAcc-mean()-Y
# 3 tBodyAcc-mean()-Z
# 41 tGravityAcc-mean()-X
# 42 tGravityAcc-mean()-Y
# 43 tGravityAcc-mean()-Z
# 81 tBodyAccJerk-mean()-X
# 82 tBodyAccJerk-mean()-Y
# 83 tBodyAccJerk-mean()-Z
# 121 tBodyGyro-mean()-X
# 122 tBodyGyro-mean()-Y
# 123 tBodyGyro-mean()-Z
# 161 tBodyGyroJerk-mean()-X
# 162 tBodyGyroJerk-mean()-Y
# 163 tBodyGyroJerk-mean()-Z
# 201 tBodyAccMag-mean()
# 214 tGravityAccMag-mean()
# 227 tBodyAccJerkMag-mean()
# 240 tBodyGyroMag-mean()
# 253 tBodyGyroJerkMag-mean()
# 266 fBodyAcc-mean()-X
# 267 fBodyAcc-mean()-Y
# 268 fBodyAcc-mean()-Z
# 294 fBodyAcc-meanFreq()-X
# 295 fBodyAcc-meanFreq()-Y
# 296 fBodyAcc-meanFreq()-Z
# 345 fBodyAccJerk-mean()-X
# 346 fBodyAccJerk-mean()-Y
# 347 fBodyAccJerk-mean()-Z
# 373 fBodyAccJerk-meanFreq()-X
# 374 fBodyAccJerk-meanFreq()-Y
# 375 fBodyAccJerk-meanFreq()-Z
# 424 fBodyGyro-mean()-X
# 425 fBodyGyro-mean()-Y
# 426 fBodyGyro-mean()-Z
# 452 fBodyGyro-meanFreq()-X
# 453 fBodyGyro-meanFreq()-Y
# 454 fBodyGyro-meanFreq()-Z
# 503 fBodyAccMag-mean()
# 513 fBodyAccMag-meanFreq()
# 516 fBodyBodyAccJerkMag-mean()
# 526 fBodyBodyAccJerkMag-meanFreq()
# 529 fBodyBodyGyroMag-mean()
# 539 fBodyBodyGyroMag-meanFreq()
# 542 fBodyBodyGyroJerkMag-mean()
# 552 fBodyBodyGyroJerkMag-meanFreq()

#Standard Deviations
# $ grep std features.txt
# 4 tBodyAcc-std()-X
# 5 tBodyAcc-std()-Y
# 6 tBodyAcc-std()-Z
# 44 tGravityAcc-std()-X
# 45 tGravityAcc-std()-Y
# 46 tGravityAcc-std()-Z
# 84 tBodyAccJerk-std()-X
# 85 tBodyAccJerk-std()-Y
# 86 tBodyAccJerk-std()-Z
# 124 tBodyGyro-std()-X
# 125 tBodyGyro-std()-Y
# 126 tBodyGyro-std()-Z
# 164 tBodyGyroJerk-std()-X
# 165 tBodyGyroJerk-std()-Y
# 166 tBodyGyroJerk-std()-Z
# 202 tBodyAccMag-std()
# 215 tGravityAccMag-std()
# 228 tBodyAccJerkMag-std()
# 241 tBodyGyroMag-std()
# 254 tBodyGyroJerkMag-std()
# 269 fBodyAcc-std()-X
# 270 fBodyAcc-std()-Y
# 271 fBodyAcc-std()-Z
# 348 fBodyAccJerk-std()-X
# 349 fBodyAccJerk-std()-Y
# 350 fBodyAccJerk-std()-Z
# 427 fBodyGyro-std()-X
# 428 fBodyGyro-std()-Y
# 429 fBodyGyro-std()-Z
# 504 fBodyAccMag-std()
# 517 fBodyBodyAccJerkMag-std()
# 530 fBodyBodyGyroMag-std()
# 543 fBodyBodyGyroJerkMag-std()


run_analysis <- function() {

  require(dplyr)
  
  #The data is stored in a fixed width file, where the first column is 17 char wide, and all subsequent
  #entries (560 of them) are 16 characters wide; 
  datafile.col.widths <- c(17, rep.int(16,560))
  
  # We prepare to read the text files into a list containing a data frame for each data set
  datafiles <- c("./data/train/X_train.txt","./data/test/X_test.txt")
  
  for (cfile in datafiles) {
    my.fwf.data <- read.fwf(cfile,datafile.col.widths) #Load data from disk
    if (cfile==datafiles[1]){
      #After reading the first file, we create the dataset
      my.merged.data <- my.fwf.data  
    } else {
      #Every subsequent file will be appended to what was previously read
      my.merged.data <- rbind(my.merged.data,my.fwf.data)
    }
  }
  
  #At this point we have a merged dataset consisting of all the observations of the 561 variables
  
  #Columns with mean values
  my.mean.col.indices <- c(1,2,3,41,42,43,81,82,83,121,122,123,161,162,163,201,214,227,240,253,266,267,268,294,295,296,345,346,347,373,374,375,424,425,426,452,453,454,503,513,516,526,529,539,542,552)
  
  #Column with std deviations
  my.std.col.indices <- c(4,5,6,44,45,46,84,85,86,124,125,126,164,165,166,202,215,228,241,254,269,270,271,348,349,350,427,428,429,504,517,530,543)
  
  #We produce a data frame with only the columns of means and std deviations.  Note the means come first, then the
  #corresponding std dev
  my.simplified.obs <- my.merged.data[,c(my.mean.col.indices,my.std.col.indices)]
  
  my.merged.data <- NULL
  
  my.col.names <- c("tBodyAcc.mean.X","tBodyAcc.mean.Y","tBodyAcc.mean.Z","tGravityAcc.mean.X","tGravityAcc.mean.Y","tGravityAcc.mean.Z","tBodyAccJerk.mean.X","tBodyAccJerk.mean.Y","tBodyAccJerk.mean.Z","tBodyGyro.mean.X","tBodyGyro.mean.Y","tBodyGyro.mean.Z","tBodyGyroJerk.mean.X","tBodyGyroJerk.mean.Y","tBodyGyroJerk.mean.Z","tBodyAccMag.mean","tGravityAccMag.mean","tBodyAccJerkMag.mean","tBodyGyroMag.mean","tBodyGyroJerkMag.mean","fBodyAcc.mean.X","fBodyAcc.mean.Y","fBodyAcc.mean.Z","fBodyAcc.meanFreq.X","fBodyAcc.meanFreq.Y","fBodyAcc.meanFreq.Z","fBodyAccJerk.mean.X","fBodyAccJerk.mean.Y","fBodyAccJerk.mean.Z","fBodyAccJerk.meanFreq.X","fBodyAccJerk.meanFreq.Y","fBodyAccJerk.meanFreq.Z","fBodyGyro.mean.X","fBodyGyro.mean.Y","fBodyGyro.mean.Z","fBodyGyro.meanFreq.X","fBodyGyro.meanFreq.Y","fBodyGyro.meanFreq.Z","fBodyAccMag.mean","fBodyAccMag.meanFreq","fBodyBodyAccJerkMag.mean","fBodyBodyAccJerkMag.meanFreq","fBodyBodyGyroMag.mean","fBodyBodyGyroMag.meanFreq","fBodyBodyGyroJerkMag.mean","fBodyBodyGyroJerkMag.meanFreq","tBodyAcc.std.X","tBodyAcc.std.Y","tBodyAcc.std.Z","tGravityAcc.std.X","tGravityAcc.std.Y","tGravityAcc.std.Z","tBodyAccJerk.std.X","tBodyAccJerk.std.Y","tBodyAccJerk.std.Z","tBodyGyro.std.X","tBodyGyro.std.Y","tBodyGyro.std.Z","tBodyGyroJerk.std.X","tBodyGyroJerk.std.Y","tBodyGyroJerk.std.Z","tBodyAccMag.std","tGravityAccMag.std","tBodyAccJerkMag.std","tBodyGyroMag.std","tBodyGyroJerkMag.std","fBodyAcc.std.X","fBodyAcc.std.Y","fBodyAcc.std.Z","fBodyAccJerk.std.X","fBodyAccJerk.std.Y","fBodyAccJerk.std.Z","fBodyGyro.std.X","fBodyGyro.std.Y","fBodyGyro.std.Z","fBodyAccMag.std","fBodyBodyAccJerkMag.std","fBodyBodyGyroMag.std","fBodyBodyGyroJerkMag.std")

  colnames(my.simplified.obs) <- my.col.names
  
  #Now we load the subject data
  datafiles <- c("./data/train/subject_train.txt","./data/test/subject_test.txt")
  
  for (cfile in datafiles) {
    my.fwf.data <- read.csv(cfile,header = FALSE) #Load data from disk
    if (cfile==datafiles[1]){
      #After reading the first file, we create the dataset
      my.subj.data <- my.fwf.data  
    } else {
      #Every subsequent file will be appended to what was previously read
      my.subj.data <- rbind(my.subj.data,my.fwf.data)
    }
  }
  
  #Then we add the subject data as a column to the simplified observations
  #Since it's not a numerical variable but rather an id stamp we convert it to a factor
  my.simplified.obs$subject <- factor(my.subj.data$V1)
  
  
  #Now we load the activity data
  datafiles <- c("./data/train/y_train.txt","./data/test/y_test.txt")
  
  for (cfile in datafiles) {
    my.fwf.data <- read.csv(cfile,header = FALSE) #Load data from disk
    if (cfile==datafiles[1]){
      #After reading the first file, we create the dataset
      my.activity.data <- my.fwf.data  
    } else {
      #Every subsequent file will be appended to what was previously read
      my.activity.data <- rbind(my.activity.data,my.fwf.data)
    }
  }
  
  #Then we add the activity data as a column to the simplified observations
  #This is a factor as well, but we need to apply labels
  activity.labels <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
  my.simplified.obs$activity <- factor(my.activity.data$V1,labels = activity.labels)
  
  #Then, using dplyr, we spit out the 'tidy' table
  group_by(my.simplified.obs,subject,activity) %>% summarise_each(funs(mean))
  
} 
