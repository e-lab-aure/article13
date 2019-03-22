#!/bin/bash
###
###

pour=0
contre=0
neutre=0

for addLink in $(curl https://saveyourinternet.eu/act/ 2>/dev/null | grep -i -o 'https://saveyourinternet.eu/../' | uniq); do

	pays=${addLink#h*eu/}
	echo "Le Pays:	${pays%?}"
	lespour=$(curl $addLink 2>/dev/null | grep -o -i "tshowcase-mepsfor" | wc -l | sed -e 's/^[ \t]*//')
	echo "Pour:	$lespour"
	pour=$(($pour+$lespour))
	lescontre=$(curl $addLink 2>/dev/null | grep -o -i "tshowcase-mepsagainst" | wc -l | sed -e 's/^[ \t]*//')
	echo "Contre:	$lescontre"
	contre=$(($contre+$lescontre))
	lesneutre=$(curl $addLink 2>/dev/null | grep -o -i "tshowcase-mepsneutral" | wc -l | sed -e 's/^[ \t]*//')
	neutre=$(($neutre+$lesneutre))
	lescontres2=$(curl $addLink 2>/dev/null | grep -o -i "tshowcase-mepspledged" | wc -l | sed -e 's/^[ \t]*//')
	contre=$(($contre+$lescontres2))

done

echo "Pour $pour"
echo "Contre $contre"
echo "Neutre $neutre"

