rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate

  if (!(outcome %in% c("pneumonia", "heart attack","heart failure"))) {
    stop("invalid outcome")
    
  }
  
  #We first read the data file
  x <- read.csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  #We extract only the frames we care about converting them to numeric data
  y <- suppressWarnings(
    data.frame(
      x$Hospital.Name,
      x$State,
      as.numeric(x$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia),
      as.numeric(x$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack),
      as.numeric(x$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
    )
  )
  #Simplify names
  colnames(y) <- c("Hosp.Name","State","Pneumonia","Heart.Attack","Heart.Failure")
  
  #Generate a list containing a data frame for each state
  my.data.list.by.state <- split(y,y$State)
  
  if (!(state %in% names( my.data.list.by.state))) {
    stop("invalid state")
  } 
  
  #We only want to work with the frame that applies to state
  working.frame <-  my.data.list.by.state[[state]] 
  
  #Now we order the list
  if (outcome == "pneumonia") {
    targetcol <- "Pneumonia"
  } else if (outcome == "heart attack") {
    targetcol <- "Heart.Attack"
  } else if (outcome == "heart failure") {
    targetcol <- "Heart.Failure"
  } 
  working.ordered.frame <- working.frame[ order(working.frame[,targetcol],working.frame[,"Hosp.Name"], na.last = NA),]
  
  #Figure out which row we want
  if (num=="best") {
    
    target.row <- 1
  
  } else if (num == "worst") {
    
    target.row <- nrow(working.ordered.frame)
  
  } else if (is.numeric(num)) {
    
    if (num > nrow(working.ordered.frame)) {
  
      #We return an NA
      return( NA)
    
    } else {
      
      target.row <- num
    
    } 
  
  } else {
    stop("invalid num")
  }
  
  #Return the data from target.row
  as.character(working.ordered.frame[target.row,"Hosp.Name"])
  }