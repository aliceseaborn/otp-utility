
function export {
	list
	read -p "Specify the account id: " account_id
	name=$(jq -r ".accounts[$account_id].name" "$MANIFEST")
	secret=$(jq -r ".accounts[$account_id].secret" "$MANIFEST")
	read -p "This action will expose your OTP secret. Proceed? [y/N] " consent
	if [[ -n consent ]]; then
		if [[ "$consent" == "Y" || "$consent" == "y" ]]; then
			key=$(gpg --decrypt --quiet "$ACCOUNTS"/"$secret")
			echo "$name: $key"
		elif [[ "$consent" == "N" || "$consent" == "n" ]]; then
			echo "Operation cancelled."
		else
			echo "Please provide your consent in y/n format."
			exit 1
		fi
	else
		echo "Operation cancelled."
	fi
}

