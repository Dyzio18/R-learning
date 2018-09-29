# Data files from http://www.pogromcydanych.icm.edu.pl/
# Thanks @Biecek! Let's started...
# Code below it's my exercises during learning R

# Get absolute path
PATH <- getwd()
auta2012csv <- paste(PATH, "/dane/auta2012mini.csv", sep="")
auta2012xls <- paste(PATH, "/dane/auta2012mini.xls", sep="")


# Read data from CSV file
csvData <- read.table(file = auta2012csv, sep=";", dec=",", header=TRUE)

# Read data from Excel file
# Require: library(gdata)
# RStudio comment shortcut ctrl*shift+c
# xlsData <- read.xls(auta2012xls, sheet=1)

