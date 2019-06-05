#!/bin/bash

#Een programma dat checkt of de ingevoerde gegevens gelijk zijn aan de ingevoerde gegevens van opdracht 5

dirToLoginTXT=$1

read -p "Username: " uname

#als 'uname' leeg is, pak de output van 'whoami'
if [ "$uname" == "" ]
then
	uname=$(whoami)
fi
read -p "Password: " -s upass
echo


echo > loginCheck.txt
uname=$(echo -n $uname | md5sum)                  #Convert de username naar een MD5 hash
upass=$(echo -n $upass| md5sum)                      #Convert het wachtwoord naar een MD5 hash
echo "$uname" >> loginCheck.txt                        #Voeg de MD5 hash van de gebruikersnaam toe aan login.txt
echo "$upass" >> loginCheck.txt                           #Voeg de MD5 hash van het wachtwoord toe aan login.txt

if cmp -s $1 loginCheck.txt
then
   echo "Successfully logged in!"
else
   echo "[ERROR] Invalid username and/or password!"
fi

rm loginCheck.txt
