complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  #First we generate a vecotr of file names based on the IDs
  mydatafiles <- file.path(directory,paste(sprintf("%03d",id),'.csv',sep=""))
  
  #We define an empty NULL vector that will collect pollutant readings
  myobstally = c()
    
  for (cdatafile in  mydatafiles) { #We iterate through the each file in the vector of filenames
    
    if (file.exists(cdatafile)) {
      cframe <- read.csv(cdatafile) #We read the file into a data frame
      cNAMatrix <- as.matrix(is.na(cframe),nrow=nrow(cframe)) #Build a matrix of boolean values that are T/F depending on wether the corresponding entry in the frame is NA
      cComplete <- seq(from=FALSE, to=FALSE, length=nrow(cframe))  #We will use a vector that will have T/F entries representing wether there is one or more NA's in the corresponding row
      for (i in 1:ncol(cNAMatrix)) {
        cComplete <- cComplete | cNAMatrix[,i] #The OR operation means that if there is an NA in the row, that row gets a value of T in the accumulator
      }
      myobstally<-c(myobstally,length(cComplete)-sum(cComplete))  #Because T=1 and F=0 when summing a boolean vector, we subtract the sum from the length to get the number of F values
      
    } else
      myobstally<-c(myobstally,0)  #If the file doesn't exist then that monitor has no observations
  }
  
  myresult <- data.frame(id,myobstally)
  colnames(myresult) <- c("id","nobs")
  
  myresult
}