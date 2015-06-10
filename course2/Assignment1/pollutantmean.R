pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  
  #First we generate a vecotr of file names based on the IDs
  mydatafiles <- file.path(directory,paste(sprintf("%03d",id),'.csv',sep=""))
  
  #We define an empty NULL vector that will collect pollutant readings
  mytally <- c()
  
  
  for (cdatafile in  mydatafiles) { #We iterate through the each file in the vector of filenames
     
    if (file.exists(cdatafile)) {
      cframe <- read.csv(cdatafile) #We read the file into a data frame
      cdata = cframe[[pollutant]]   #We load into a vector the collumn of data representing the desired pollutant
      if (!is.null(cdata)) {        #We check to make sure the collumn name actually appears in the data frame
        mytally <- c(mytally,cdata[!is.na(cdata)])    #We append to mytally the non NA readings from the desired column of pollutant data.  We strip out the NA's to save memory
      }
    } 
  }
  if (!is.null(mytally)) {   #If there was no valid data whatsoever, we will have a null vector
    mean(mytally,na.rm = TRUE)  #We find the mean.  The na.rm=TRUE is redundant, but I leave it in just in case
  } else {
    NULL  #If there is no valid data we return a NULL
  }
}
