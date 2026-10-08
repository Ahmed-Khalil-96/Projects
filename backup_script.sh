#!/bin/bash

#backup_script.sh is a bash script that automates the process of backing up files from a source folder to a target folder using the rsync command. It checks for the presence of the rsync package, installs it if necessary, and performs the backup while logging the process.


exit_code_check() {

	if [ $? -ne 0]; then
	echo -e "\nError occured please check the logs"
	exit 1
	fi	
}
# Making sure the user passes 2 arguments to the script 

if [ $# -ne 2 ]; then
	echo -e "\nThis scripts runs like ./backup_script.sh <source folder> <Target folder>"
	echo -e "\nPlease try again."
	exit 1
fi

if ! command -v rsync; then
	echo -e "\nrsync package is not installed. please check one of the following..."
	sleep 3
	echo -e "\n1) Isntall the package and continue the script."
	echo -e "\n2) Install the package and use it manually without continuing the script."
	echo -e "\n3) Don't install the package and exit the script.\n"

	read -p "You Choose: " choice

	case $choice in 
		1) echo -e "\nInstalling resync please wait ..."	
			sleep 3
			sudo apt upgrade -y &&sudo apt update -y && sudo apt install rsync -y 2>/var/log/updater.log
			exit_code_check
			echo -e "\nrsync installed successfully"

	echo -e "\nProceeding with the backup process..."
	sleep 2
	echo -e "\nBacking up files from $1 to $2/current"
	sleep 3
	echo -e "\nBackup process started at $(date +%Y-%m-%d_%H-%M-%S)"
	sleep 2
	echo -e "\nPlease wait while the backup is in progress..."
	sleep 3	
	#Capture the date and store it in format YYYY-MM-DD
			current_date=$(date +%Y-%m-%d)
			
			rsync_options="-avb --backup-dir $2/$current_date --delete"

			rsync $rsync_options $1 $2/current > backup_$current_date.log 2>&1
			echo -e "\nBackup completed successfully. Please check the log file backup_$current_date.log for details."
		;;

		2) echo -e "\nInstaling resync please wait ..." 
			sleep 3 
			sudo apt update && sudo apt install rsync &>/var/log/updater.log
			exit_code_check
			echo -e "\n rsync installed successfully.."
			exit 0 ;;

		3) echo -e "\nExiting the script..."
		sleep 2
		echo -e "\nBye" 
		sleep 1 
		exit 0;;
		
		*) echo -e "\nInvalid choice please try again..."
			sleep 2 
			exit 1 ;;

	esac
	
else
	echo -e "\nProceeding with the backup process..."
	sleep 2
	echo -e "\nBacking up files from $1 to $2/current"
	sleep 3
	echo -e "\nBackup process started at $(date +%Y-%m-%d_%H-%M-%S)"
	sleep 2
	echo -e "\nPlease wait while the backup is in progress..."
	sleep 4	
	#Capture the date and store it in format YYYY-MM-DD
			current_date=$(date +%Y-%m-%d)
			
			rsync_options="-avb --backup-dir $2/$current_date --delete"

			rsync $rsync_options $1 $2/current > backup_$current_date.log 2>&1
			echo -e "\nBackup completed successfully. Please check the log file backup_$current_date.log for details."

fi




