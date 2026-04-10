#!/usr/bin/env bash

clear

pl_total=0
comp_total=0

myName="Papa"
myMate="Hunty"

rolling () {
	proll=$((RANDOM%10+1))
	partial1=$(($proll + player_score))	
	echo ""
	proll2=$((RANDOM%10+1))
	partial2=$(($partial1 + $proll2))	
	proll3=$((RANDOM%10+1))
	echo -e "  $myName rolled: $proll, $proll2, and $proll3."
	pl_total=$(($partial2 + $proll3))	
	echo -e "    $myName's total score is: $pl_total\n"
	croll=$((RANDOM%10+1))
	partial1=$(($croll + computer_score))	
	croll2=$((RANDOM%10+1))
	partial2=$(($partial1 + $croll2))	
	croll3=$((RANDOM%10+1))
	echo -e "  $myMate rolled: $croll, $croll2, and $croll3."
	comp_total=$(($partial2 + $croll3))	
	echo -e "    $myMate's total score is: $comp_total\n"
	echo " OK, guys. Rolls are locked in.

	  Grabbing a fresh new can as target. Get ready!.

	  	- press enter to continue -"
	 read -sn 1
}

rolling

echo ""
sleep 1
#we show how much is needed to hit but not the 'cans's' health.

fighting () {	

	Orc_AC=$(($RANDOM%15+10))
	Orc_HP=$(($RANDOM%10+4))

	echo ""
	echo -e ' The new can is already placed in the target pole,

		 ----
		/    \
		|coke|
		|    |
		|    |
		\____/
		'
	echo -e "  You need a roll of $Orc_AC to hit it.\n"
#Yeah, the can is an Orc.
	
	if [[ $pl_total -ge $Orc_AC ]]; then
		echo "  $myName hits the can!
		"		
		Orc_HP=$(( $Orc_HP - $proll ))
		
			if [[ $Orc_HP -lt 1 ]]; then
				echo "  WOW! Good hit!"
				
			elif [[ $comp_total -ge $Orc_AC ]]; then
				echo -e "  $myMate hits the can!\n"
				Orc_HP=$(( $Orc_HP - $croll3 ))
				
				if [[ $Orc_HP -lt 1 ]]; then
					echo "  Good shot!!!"
					
				fi
			elif [[ $comp_total -lt $Orc_AC ]]; then
				echo "  $myMate missed." 
			fi
	elif [[ $pl_total -lt $Orc_AC ]]; then
		echo "  $myName missed."
		if [[ $comp_total -ge $Orc_AC ]]; then
			echo "  $myMate hits the can!"
			Orc_HP=$(( $Orc_HP - $croll3 ))
			if [[ $Orc_HP -lt 1 ]]; then
				echo "  Good teamwork!"
								
			fi
		elif [[ $comp_total -lt $Orc_AC ]]; then
				echo "  $myMate also missed."
		fi
	fi
	
}

fighting

check_result () {
	if [[ $Orc_HP -lt 1 ]]; then
		echo " 
		  Good job! $myName and $myMate have trashed the can!
		  "
	else
		echo " 
		  Better luck next time. You have failed to destroy the can.
		  "
	fi
}

sleep 1

check_result

sleep 1
