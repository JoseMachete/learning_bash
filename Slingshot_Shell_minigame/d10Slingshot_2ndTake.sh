#!/usr/bin/bash

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

	  Get your slingshots ready!
	     Get your ammo ready!

	  	- press enter to continue -"
	 read -sn 1
}

rolling

echo ""
sleep 1
#we show how much is needed to hit but not the 'cans's' health.

#echo "Number of arguments: $#"
if [[ $# -ne 1 ]]
then
	echo "We need a target to shoot at!"
	exit 1
fi
	
if [[ -f $1 ]]
then
	target=$1
	echo "  $target grabbed..."
else
	echo "$1 doesn't exist!"
	exit 1
fi

fighting () {	
		
	Orc_AC=$(($RANDOM%15+10))
	Orc_HP=$(($RANDOM%10+4))

	echo ""
	echo -e ' The target is placed at the pole,

		 ----
		/    \
		| c  |
		| a  |
		| n  |
		\____/
		'
	sleep 1
	echo -e "  You need a roll of $Orc_AC to hit the $target.\n"
	sleep 1
	echo "    RELEASE YOUR SHOTS!
	"
	read -sn 1
#Yeah, the can is an Orc.
	
	if [[ $pl_total -ge $Orc_AC ]]; then
		echo "  $myName hits the $target!
		"		
		Orc_HP=$(( $Orc_HP - $proll ))
		
			if [[ $Orc_HP -lt 1 ]]; then
				echo "  WOW! Good hit!"
				
			elif [[ $comp_total -ge $Orc_AC ]]; then
				echo -e "  $myMate hits the $target!\n"
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
			echo "  $myMate hits the $target!"
			Orc_HP=$(( $Orc_HP - $croll3 ))
			if [[ $Orc_HP -lt 1 ]]; then
				echo "  Good shot!!!"
								
			fi
		elif [[ $comp_total -lt $Orc_AC ]]; then
				echo "  Ooof, $myMate also missed."
		fi
	fi
	
}

fighting

check_result () {
	if [[ $Orc_HP -lt 1 ]]; then
		echo " 
		  Good job! $myName and $myMate have trashed the $target!
		  "
		echo " $target" >> ./Scoreboard.txt
		mv $target ./Shredded_Cans/
		rm -fr $target
	else
		echo " 
		  Better luck next time. You have failed to destroy the $target.
		  "
	fi
}

sleep 1

check_result

sleep 1
