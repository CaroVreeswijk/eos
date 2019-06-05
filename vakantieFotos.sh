#!/bin/bash

# Maak de map 'vakantie'
mkdir vakantie 2> /dev/null

#Sla de locatie van de map 'vakantie' op in 'vakantieDirectory'
vakantieDirectory=$PWD/vakantie

dirToGoTo=$1        #Sla het eerste argument op in 'dirToGoTo'

#cd naar dirToGoTo (de map waar alle bestanden in staan)
cd $dirToGoTo

echo "imgMove > Moving files..."

#Loop door alle 'vakantie' bestanden
for i in $(find . | grep vakantie); do
    #verplaats de bestanden naar de aangemaakte vakantie map en stuur alle reguliere output naar /dev/null
    mv "$i" "$vakantieDirectory" 2> /dev/null
done

echo "imgMove > All files have been moved"
