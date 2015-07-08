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

local.HAR.Data.constants <- function() {
  list( datadir=c("data"))
}

Download.HAR.Data <- function() {

  my.env <- local.HAR.Data.constants()
  
  #First we check if the data directory exists
  if (! dir.exists( my.env$datadir ) ) {
    dir.create(my.env$datadir)
  }
}

run_analysis <- function() {

  
    
} 