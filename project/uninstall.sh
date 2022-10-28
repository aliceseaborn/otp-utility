#!/bin/bash
# UNINSTALL

function confirmation {
	echo -e "\nThis script will remove the otp binary as well as the ~/.otp directory."
	echo "The database housing your account information (~/.otp/manifest.json) will be deleted."
	echo "Any and all account secrets stored in ~/.otp/accounts will be destroyed."
	read -p "Proceed? [y/N] " consent
	if [[ -n "$consent" ]]; then
		if [[ "$consent" == "Y" || "$consent" == "y" ]]; then
			return
		elif [[ "$consent" == "N" || "$consent" == "n" ]]; then
			echo "Operation cancelled."
			exit 0
		else
			echo "Please provide your consent in y/n format."
			exit 1
		fi
	else
		echo "Operation cancelled."
		exit 0
	fi
}


function remove_binary {
	rm -rf bin/
}


function clean_home_directory {
	rm -rf "$HOME"/.otp
}


echo -e "Uninstalling otp-util..."
confirmation
remove_binary
clean_home_directory
echo "Removal complete."

