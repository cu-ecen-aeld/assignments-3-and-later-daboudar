#!/bin/bash
#Author: daboudar
#Date: 3-22-2023
#Script Usage:  writer.sh [FULLPATH/FILENAME] [STRING]
#Script Description:  Script takes two arguments, a full pathname including filename 
#                     and a string that is entered into the filename

if [ $# -eq 2 ] #check if two arguments have been passed
then
	writefile=$1 #set variables to the passed arguments
	writestr=$2
	
	if [ -d $(dirname $writefile) ] #strip the filename off the pathname and check if it is an existing directory
	then
		echo "$writestr" > $writefile #if so, put STRING argument into FILENAME (NOTE: parentheses needed if spaces are in $writestr so that the shell doesn't think
	else                                  #there are multiple variables
		mkdir -p $(dirname $writefile) #if not, make directories including any subdirectories (that's what -p does)
		echo "$writestr" > $writefile #now put STRING argument into FILENAME
	fi			
else
	echo "ERROR: Invalid number of arguments" #if two arguments weren't passed, print error and usage statements
	echo "Usage: writer.sh [PATH] [STRING]"
	exit 1
fi
