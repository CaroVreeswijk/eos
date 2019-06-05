#!/bin/bash

#Vraag om de gebruikersnaam en sla deze op in 'uname'
echo "Make Login by Vincent"
read -p "Username: " uname

#als 'uname' leeg is, pak de output van 'whoami'
if [ "$uname" == "" ]
then
	uname=$(whoami)
fi

while true
do

    #Sla het ingevoerde wachtwoord op in 'upass'
	read -p "Password: " -s upass
    echo

    #Sla het ingevoerde wachtwoord op in 'upass2'
	read -p "Re-enter password: " -s upass2
    echo

    #Sla de lengte van 'upass' op in 'passLength'
	passLength=${#upass}

    #Check of het wachtwoord aan de eisen voldoet
	if [ $passLength -gt 8  ] && [[ $upass =~ [A-Z] ]] && [[ $upass =~ [a-z] ]] && [[ $upass =~ [0-9] ]]; then

        #Check of de wachtwoorden gelijk zijn
		if [ "$upass" == "$upass2" ]; then
			echo > login.txt                                     #Maak het bestand 'login.txt'
			unameEnc=$(echo -n $uname | md5sum)                  #Convert de username naar een MD5 hash
			upass=$(echo -n $upass| md5sum)                      #Convert het wachtwoord naar een MD5 hash
			echo "$unameEnc" >> login.txt                        #Voeg de MD5 hash van de gebruikersnaam toe aan login.txt
			echo "$upass" >> login.txt                           #Voeg de MD5 hash van het wachtwoord toe aan login.txt
            echo "Login for '$uname' stored in login.txt"
			break
		else
			echo "[ERROR] Password mismatch, try again."
		fi

	else
		echo "[ERROR] Your password needs to have at least 8 characters, 1 uppercase letter, 1 lowercase letter and a number. Please try again."
	fi


done
