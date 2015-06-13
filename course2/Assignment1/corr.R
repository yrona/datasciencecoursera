corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  
  #First we generate a vector of ID's with the proper number of observations
  obs.frame<-complete(directory)
  
  #Next we generate a vector of id's that meet the threshold requirements
  id.vector<-obs.frame[obs.frame$nobs>=threshold,"id"]
  
  #Then we prepare an empty vector to collect the results
  my.accumulator <- c()
  
  #Then we generate a vector of file names based on the IDs
  mydatafiles <- file.path(directory,paste(sprintf("%03d",id.vector),'.csv',sep=""))
  
  for (cdatafile in  mydatafiles) { #We iterate through the each file in the vector of filenames
    
    if (file.exists(cdatafile)) {
      cframe <- read.csv(cdatafile) #We read the file into a data frame 
      #cgooddata.frame <- cframe[!is.na(cframe$sulfate) & !is.na(cframe$nitrate),] #We build a frame that has the same collumns as cframe but contains only the complete rows
      #my.accumulator <- c(my.accumulator,cor(cgooddata.frame$sulfate,cgooddata.frame$nitrate) )
      my.accumulator <- c(my.accumulator,cor(cframe$sulfate,cframe$nitrate,use = "complete.obs") )
    } else {
      #In theory this branch should never be executed because to be included in id.vector, the file had to exist when this function was initially called
      
      #Nevertheless we don't ignore the branch
      my.accumulator <- c(my.accumulator,NA )
    }
  }
  
  #Return the value
  if (length(my.accumulator)==0 | length(id.vector)==0) {
    numericc(0)
  } else{
    my.accumulator  
  }
  
  
}