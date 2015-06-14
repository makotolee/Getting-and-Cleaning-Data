# Getting-and-Cleaning-Data
Getting and Cleaning Data Project for peer asssessment

## Course Project

* Unzip the source (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into a folder in your working directory

* Put run_analysis.R into your working directory

* In R: setwd("your_working_directory"), followed by: source("run_analysis.R")

* data1 <- read.table("data_set_with_the_averages_final.txt") to read the data. It is 180x68 because there are 30 subjects and 6 activities, thus "for each activity and each subject" means 30 * 6 = 180 rows. Note that the provided R script has no assumptions on numbers of records, only on locations of files.
