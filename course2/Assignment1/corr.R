corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  
  
  #First we prepare an empty vector to collect the results
  my.accumulator <- c()
  
    
  #Next we generate a vector listing all files in the directory
  mycsv.names <- dir(directory,pattern = "[0-9]{3}.csv", full.names = TRUE)
  
  for (cdata.file in  mycsv.names)  { #We iterate through the each file in the vector of filenames
  
    cframe <- read.csv(cdata.file) #We read the file into a data frame 
    cgooddata.frame <- cframe[!is.na(cframe$sulfate) & !is.na(cframe$nitrate),] #We build a frame that has the same collumns as cframe but contains only the complete rows
    if ( nrow(cgooddata.frame) >  threshold ) {
      my.accumulator <- c(my.accumulator,cor(cgooddata.frame$sulfate,cgooddata.frame$nitrate) )
    }
  }
  
  #Return the value
  if (length(my.accumulator)==0 | length(mycsv.names)==0) {
    numeric(0)
  } else{
    my.accumulator  
  }
  
  
}