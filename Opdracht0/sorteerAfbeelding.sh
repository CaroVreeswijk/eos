#!/bin/bash
#Maak de folder 'afbeeldingen' en stuur alle reguliere output naar /dev/null
mkdir "Afbeeldingen" 2> /dev/null

curDir=$PWD         #Sla de huidige directory op in 'curDir'
dirToGoTo=$1        #Sla het eerste argument op in 'dirToGoTo'

#cd naar dirToGoTo (de map waar alle bestanden in staan)
cd $dirToGoTo

echo "imgMove > Moving files..."

#Loop door alle 'png en .jpeg' bestanden
for i in $(find . -name '*.png' -o -name '*.jpeg'); do
    #verplaats de bestanden naar de aangemaakte Afbeeldingen map en stuur alle reguliere output naar /dev/null
    mv "$i" "$curDir/Afbeeldingen" 2> /dev/null
done

echo "imgMove > All .png and .jpeg files have been moved!"
