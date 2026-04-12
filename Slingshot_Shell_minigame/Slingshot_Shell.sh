#!/usr/bin/bash

clear

pl_total=0
comp_total=0

#Pending to code in a way to flip a coin, see who starts first.
#First shooter will have an extra point to the total_score, becasue
#Second shooter already gets advantage.

myName="Hunty"
myMate="Tete"

#Introducing 3 different sets of bands to choose. 
#Both players agree on the same set, for now.
#Goal is to have each player to choose their own set of bands.

#Yellow bands, the lighter ones. Four rolls of d8. They get an extra +1 for speed.
rolling_yellow_bands () {
	echo ""
	proll=$((RANDOM%8+2))
	proll2=$((RANDOM%8+2))
	proll3=$((RANDOM%8+2))
	proll4=$((RANDOM%8+2))
	echo -e "  $myName rolled: $proll, $proll2, $proll3 and $proll4."
	pl_total=$(($proll4 + $proll3 + $proll2 + $proll))	
	echo -e "    $myName's total score is: $pl_total\n"
	croll=$((RANDOM%8+2))
	croll2=$((RANDOM%8+2))
	croll3=$((RANDOM%8+2))
	croll4=$((RANDOM%8+2))
	echo -e "  $myMate rolled: $croll, $croll2, $croll3 and $croll4."
	comp_total=$(($croll4 + $croll3 + $croll2 + $croll))		
	echo -e "    $myMate's total score is: $comp_total\n"
	echo " OK, guys. Rolls are locked in.

	  Get your slingshots ready!
	     Get your ammo ready!

	  	- press enter to continue -"
	 read -sn 1
}

#Green bands, the medium ones. Three rolls of d10. No extras.
rolling_green_bands () {
	echo ""
	proll=$((RANDOM%10+1))
	proll2=$((RANDOM%10+1))
	proll3=$((RANDOM%10+1))
	echo -e "  $myName rolled: $proll, $proll2, and $proll3."
	pl_total=$(($proll3 + $proll2 + $proll))	
	echo -e "    $myName's total score is: $pl_total\n"
	croll=$((RANDOM%10+1))
	croll2=$((RANDOM%10+1))
	croll3=$((RANDOM%10+1))
	echo -e "  $myMate rolled: $croll, $croll2, and $croll3."
	comp_total=$(($croll3 + $croll2 + $croll))		
	echo -e "    $myMate's total score is: $comp_total\n"
	echo " OK, guys. Rolls are locked in.

	  Get your slingshots ready!
	     Get your ammo ready!

	  	- press enter to continue -"
	 read -sn 1
}

#Orange bands, the powerful ones. Two rolls of d20. They get an extra +2 for strength.
rolling_orange_bands () {
	echo ""
	proll=$((RANDOM%20+3))
	proll2=$((RANDOM%20+3))
	echo -e "  $myName rolled: $proll, and $proll2."
	pl_total=$(($proll2 + $proll))	
	echo -e "    $myName's total score is: $pl_total\n"
	croll=$((RANDOM%20+1))
	croll2=$((RANDOM%20+1))
	echo -e "  $myMate rolled: $croll, and $croll2."
	comp_total=$(($croll3 + $croll2 + $croll))		
	echo -e "    $myMate's total score is: $comp_total\n"
	echo " OK, guys. Rolls are locked in.

	  Get your slingshots ready!
	     Get your ammo ready!

	  	- press enter to continue -"
	 read -sn 1
}

#Depending on the sets of bands choosen, a different rolling() function will be called.
echo -e "
  	Which bands do you want to use?\n 
    a) Yellow bands (0,5mm). Those are the lighter ones, you get 4 rolls of 1d8.\n
     b) Green bands (0,7mm). Those are the all-rounders, you get 3 rolls of 1d10.\n
      c) Orange bands (1mm). Those are the powerful ones, you get 2 rolls of 1d20.
  "
read bands
case $bands in
	a)
		rolling_yellow_bands
	;;
	b)
		rolling_green_bands
	;;
	c)
		rolling_orange_bands
	;;
	*)
		echo "  Please, choose a correct number for your bands."
	;;
esac

echo ""
sleep 1

#echo "Number of arguments: $#"
if [[ $# -ne 1 ]]
then
	echo "We need a target to shoot at!"
	exit 1
fi
	
if [[ -f $1 ]]
then
	target=$1
	echo -e "  
	$target grabbed..."
else
	echo "
	$1 doesn't exist!"
	exit 1
fi

#We don't show how much is needed to hit, neither the 'cans's' health.

fighting () {	
		
	Orc_AC=$(($RANDOM%15+10))  #We set the can's properties inside the function,
	Orc_HP=$(($RANDOM%8+5))   #But might as well have done it at the beginning.
	Orc_Initial_HP=$Orc_HP
	
	echo ""
	echo -e ' 	Target placed at the pole,

			 ----
			/    \
			| c  |
			| a  |
			| n  |
			\____/
		'
	sleep 1
	echo -e "  Focus on the target, slow down your breathing...\n"
	sleep 2
	echo "    RELEASE YOUR SHOTS!
	"
	read -sn 1
#Yeah, the can is an Orc.
	
	if [[ $pl_total -ge $Orc_AC ]]; then
		echo "  $myName hits the $target!"
				
		Orc_HP=$(( $Orc_HP - $proll ))
		
			if [[ $Orc_HP -lt 1 ]]; then
				echo "  WOW! Good hit!
				"
				
			elif [[ $comp_total -ge $Orc_AC ]]; then
				echo -e "  $myMate hits the $target!
				"
				Orc_HP=$(( $Orc_HP - $croll ))
				
				if [[ $Orc_HP -lt 1 ]]; then
					echo "  Good shot!!!"
					
				fi
			elif [[ $comp_total -lt $Orc_AC ]]; then
				echo "  $myMate missed." 
			fi
	elif [[ $pl_total -lt $Orc_AC ]]; then
		echo "  $myName missed."
		if [[ $comp_total -ge $Orc_AC ]]; then
			echo "  $myMate hits the $target!
			"
			Orc_HP=$(( $Orc_HP - $croll ))
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
		  Good marksmanship! You have trashed the $target!
		  "
		echo -e "  You needed a roll of $Orc_AC to hit the $target.\n
	The $target had $Orc_Initial_HP resistance points.\n"
		echo -e " $target -> $myName's score was $pl_total | $myMate's score was $comp_total." >> ./Scoreboard.txt 
		mv $target ./Shredded_Cans/
		rm -fr $target
	else
		echo " 
		  Better luck next time. You have failed to destroy the $target.
		  "
		echo -e "  You needed a roll of $Orc_AC to hit the $target.\n
	The $target had $Orc_Initial_HP resistance points.\n"
		sleep 1
		
	fi
}

sleep 1

check_result
echo ""
sleep 1
