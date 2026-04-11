#!/usr/bin/bash

#This little command will erase all entries in a txt file, in this case, Scoreboard.txt
#from the 3 position.

sed -i '3,$d' ./Scoreboard.txt
