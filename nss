#!/bin/bash
# nss - Named Selection Screenshot
# https://github.com/int-80h
#
#Copyright (C) 2014 int-80h
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.


#check if dependencies are installed
if [ ! hash zenity 2>/dev/null ];
then
    echo "Error: zenity needs to be installed!"
    exit
fi

if [ ! hash scrot 2>/dev/null ];
then
    echo "Error: scrot needs to be installed!"
    exit
fi


#path where the screenshots will be saved
path="$HOME/scrots/"


#check if directory for screenshots is present
if [ ! -d $path ];
then
    zenity --warning --title="NSS" --text="Directory for screenshots does not exist! Please set a proper one..."
    exit
fi


#get input filename
file=$(zenity --entry --title="NSS" --text="Please enter a filename:" --entry-text="") 


#check if a filename was supplied...
if [ -n "$file" ]; 
then
    file="$path$file.png"
    echo "Using $file..."
#...and use date and time if not
else
    file="$path$(date +%x_%X).png"
    echo "No filename supplied... using '$file'"
fi


#choose another filename if it already exists
while [ -e $file ] 
do
    file=$(zenity --entry --title "NSS" --text="File already exists! Please choose a new name:" --entry-text="$file")
done


#take screenshot
scrot -s $file


#check if scrot was functioning correctly
if [ ! $? -eq 0 ];
then
    zenity --warning --title="NSS" --text="Error: scrot failed to take the screenshot, please try again!"
fi

