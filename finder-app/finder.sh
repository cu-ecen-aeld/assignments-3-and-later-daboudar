#!/bin/bash
#Author: daboudar
#Date: 3-22-2023
#Script Usage:  finder.sh [PATH] [STRING]
#Script Description:  Script will search the given directory and subdirectories 
#                     for all instances of the input string and will output 
#                     the total number files X in the directories and lines Y matched. 


NUMBERFILES=0 #initialize variables because sometimes we won't find anything!
NUMBERLINES=0

if [ $# -eq 2 ] #check to see if two arguments have been passed 
then
	if [ -d $1 ] #if so, then check if the first argument is a directory
	then
		filesdir=$1 #if it is a directory, set filesdir to it
	else
		echo "ERROR: Invalid directory path." #otherwise print error statement and return status 1
		exit 1
	fi
	if [ -n $2 ] #check to see if second argument is a string
	then
		searchstr=$2 #if so set searchstr to it
		NUMBERFILES=$(find $filesdir -type f -name "*" | wc -l) #pipe all the files found by find to wc, count each newline, and set NUMBERFILES to it
		NUMBERLINES=$(find $filesdir -type f -name "*" -exec grep $searchstr {} \; | wc -l) #for each file found by find execute grep STRING and count with wc (See man find for -exec examples)
		echo "The number of files are $NUMBERFILES and the number of matching lines are $NUMBERLINES"
	else
		echo "ERROR: Invalid string argument." #if not a string print error
		exit 1
	fi
else
	echo "ERROR: Invalid number of arguments" #if two arguments weren't passed then print error statement
	echo "Usage: finder.sh [PATH] [STRING]"
	exit 1
fi


