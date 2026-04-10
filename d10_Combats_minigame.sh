#!/usr/bin/env bash

clear

pl_total=0
comp_total=0

rolling () {
	proll=$((RANDOM%10+1))
	partial1=$(($proll + player_score))	
	echo ""
	proll2=$((RANDOM%10+1))
	partial2=$(($partial1 + $proll2))	
	proll3=$((RANDOM%10+1))
	echo -e " You rolled: $proll, $proll2, and $proll3."
	pl_total=$(($partial2 + $proll3))	
	echo ""
	echo -e "  
	Your score is: $pl_total\n"
	croll=$((RANDOM%10+1))
	partial1=$(($croll + computer_score))	
	echo ""
	croll2=$((RANDOM%10+1))
	partial2=$(($partial1 + $croll2))	
	croll3=$((RANDOM%10+1))
	echo -e " Your pet rolled: $croll, $croll2, and $croll3."
	comp_total=$(($partial2 + $croll3))	
	echo ""
	echo -e "  
	Your pet's score is: $comp_total\n"
	echo " Rolls are locked in.

	  Ready to fight.

	  	- press enter to continue -"
	 read -sn 1
}

rolling

echo ""
sleep 1

fighting () {

	Orc_AC=$(($RANDOM%15+10))
	Orc_HP=$(($RANDOM%10+4))

	echo ""
	echo " A Monster enters the Arena, 	
	   AC is $Orc_AC.
	     HP is $Orc_HP.
	   "
	

	if [[ $pl_total -ge $Orc_AC ]]; then
		echo "  You hit the monster!"
		Orc_HP=$(( $Orc_HP - $proll ))
		echo " The monster's HP is $Orc_HP"
			if [[ $Orc_HP -lt 1 ]]; then
				echo "  Good hit!"
				
			elif [[ $comp_total -ge $Orc_AC ]]; then
				echo "  Your pet hit the monster!"
				Orc_HP=$(( $Orc_HP - $croll3 ))
				echo " The monster's HP is $Orc_HP"
				if [[ $Orc_HP -lt 1 ]]; then
					echo "  Good teamwork!"
					
				fi
			elif [[ $comp_total -lt $Orc_AC ]]; then
				echo "  Your pet missed." 
			fi
	elif [[ $pl_total -lt $Orc_AC ]]; then
		echo "  You missed."
		if [[ $comp_total -ge $Orc_AC ]]; then
			echo "  Your pet hit the monster!"
			Orc_HP=$(( $Orc_HP - $croll3 ))
			echo "  The monster's HP is $Orc_HP"
		elif [[ $comp_total -lt $Orc_AC ]]; then
				echo "  Your pet also missed."
		fi
	fi
	
}

fighting

check_result () {
	if [[ $Orc_HP -lt 1 ]]; then
		echo " 
		  You and your pet have eliminated your opponent!
		  "
	else
		echo " 
		  You and your pet have failed to eliminate your opponent.
		  "
	fi
}

sleep 1

check_result

sleep 1
