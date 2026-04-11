#!/usr/bin/bash

#little helper program to grab a random can from the bag for us

cp $(find ./Bag_Of_Cans/ -type f | shuf -n $((RANDOM%1 + 1))) .
