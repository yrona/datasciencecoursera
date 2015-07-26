---
title: "Summarizing Samsung Motion Data"
author: "Yilmaz Rona"
date: "July 26, 2015"
output: html_document
---

The script run_analysis will return a data frame consisting of 79 columns of numerical data and 2 columns of factors.
The factors will be subjects identified by an integer stored in character form, and an activity types.

The numerical data will consist of the result of grouping observations using accelerometers on a model of Galaxy Phone taken while the various subjects performing various activities.  After grouping the observations by activity for each subject, the mean value is recorded.  Each value records the mean value of that parameter, for a particular activity as performed by a particular subject.

```{r}
run_analysis()
```
The raw data for the analysis may be found here:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

It is described[1] here:
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


To run the analysis, the following files must be placed below the working directory thus:

* ./data/train/subject_train.txt  Subject performing the activity for each corresponding row of observations in x_train.txt
* ./data/train/X_train.txt  Accelerometer data (training dataset)
* ./data/train/y_train.txt  Activity being performed for each corresponding row of observations in x_train.txt
* ./data/test/subject_test.txt  Subject performing the activity for each corresponding row of observations in x_text.txt
* ./data/test/X_test.txt    Accelerometer data (testing dataset)
* ./data/test/y_test.txt  Activity being performed for each corresponding row of observations in x_test.txt



# References
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012