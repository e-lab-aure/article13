#!/bin/bash
###
###

mepsforCount=0
mepsagainstCount=0
mepsneutralCount=0
mepsneutralagainstCount=0

for addLink in $(curl https://saveyourinternet.eu/act/ 2>/dev/null | grep -i -o 'https://saveyourinternet.eu/../' | uniq); do
	pays=${addLink#h*eu/}

	echo "Le Pays:	${pays%?}"

	### Pour l'article 13 ###
	mepsfor=$(curl $addLink 2>/dev/null | grep -o -i "tshowcase-mepsfor" | wc -l | sed -e 's/^[ \t]*//')
	echo "Pour:	$mepsfor"
	mepsforCount=$(($mepsforCount+$mepsfor))

	### Contre l'article 13 ###
	mepsagainst=$(curl $addLink 2>/dev/null | grep -o -i "tshowcase-mepsagainst" | wc -l | sed -e 's/^[ \t]*//')
	echo "Contre:	$mepsagainst"
	mepsagainstCount=$(($mepsagainstCount+$mepsagainst))

	### Neutre concernant l'article 13 ###
	mepsneutral=$(curl $addLink 2>/dev/null | grep -o -i "tshowcase-mepsneutral" | wc -l | sed -e 's/^[ \t]*//')
	echo "Neutre:	$mepsneutral"
	mepsneutralCount=$(($mepsneutralCount+$mepsneutral))

	### Indécis plutôt contre ###
	mepspledged=$(curl $addLink 2>/dev/null | grep -o -i "tshowcase-mepspledged" | wc -l | sed -e 's/^[ \t]*//')
	echo "Indécis:	$mepsagainst"
	mepsagainstCount=$(($mepsagainstCount+$mepspledged))



done

mepsneutralagainstCount=$(($mepsagainstCount+$mepsneutralCount))

echo "########################################"
echo "Total Pour: $mepsforCount"
echo "Total Contre: $mepsagainstCount"
echo "Total Neutre: $mepsneutralCount"
echo "Total Neutre + Contre: $mepsneutralagainstCount"
echo "########################################"

if [ $mepsforCount -gt $mepsneutralagainstCount ] 
then
	echo "ADOPTED de $(($mepsforCount-$mepsneutralagainstCount))"
else
	echo "REJECTED de $(($mepsneutralagainstCount-$mepsforCount))"
fi
