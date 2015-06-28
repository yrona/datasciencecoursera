rankall <- function(outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name

  if (!(outcome %in% c("pneumonia", "heart attack","heart failure"))) {
    stop("invalid outcome")
    
  }
  
  if (outcome == "pneumonia") {
    targetcol <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  } else if (outcome == "heart attack") {
    targetcol <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  } else if (outcome == "heart failure") {
    targetcol <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  } 
  
  #We first read the data file
  x <- read.csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  #We extract only the frames we care about converting them to numeric data
  y <- suppressWarnings(
    data.frame(
      x$Hospital.Name,
      x$State,
      as.numeric(x[,targetcol])
    )
  )
  #Simplify names
  colnames(y) <- c("Hosp.Name","State","Mortality")
  
  #Generate a list containing a data frame for each state
  my.data.list.by.state <- split(y,y$State)
  
  
  #Now a function to return a row containing the num ranked hospital for a particular state frame
  rankstate <- function (cState.frame, ranknum) {
    #cState.frame is a data frame for a single state frame in my.data.list.by.state
    #ranknum is the desired numerical rank: best=1, worst=-1, any other number is = the rankall param num
    
    cState.Sorted.frame <- cState.frame[ order(cState.frame[,"Mortality"],cState.frame[,"Hosp.Name"], na.last = NA),]
    
    if(ranknum == -1) {
      crank <- nrow(cState.Sorted.frame)
    } else {
      crank <- ranknum
    }
    
    if(crank > nrow(cState.Sorted.frame)) {
      result.frame <- cState.Sorted.frame[1,c("Hosp.Name","State")]
      result.frame[1,"Hosp.Name"]=NA
    } else {
      result.frame <- cState.Sorted.frame[crank,c("Hosp.Name","State")]
    }
    
    result.frame
  
  }
  
  #Figure out which row we want
  if (num=="best") {
    
    target.row <- 1
    
  } else if (num == "worst") {
    
    target.row <- -1
    
  } else if (is.numeric(num)) {
    
      target.row <- num
  
  } else {
    stop("invalid num")
  }
  
  #We apply this function on all the data frames in the list
  result.list <- lapply(my.data.list.by.state,rankstate, ranknum=target.row)
  
  #We then merge the results
  mortality.data <- Reduce(rbind,result.list)
  
  row.names(mortality.data)<- mortality.data[,"State"]
  colnames(mortality.data)<-c("hospital","state")
  
  mortality.data
}