
function generate {
	list
	read -p "Specify the account id: " account_id
	name=$(jq -r ".accounts[$account_id].name" "$MANIFEST")
	mode=$(jq -r ".accounts[$account_id].mode" "$MANIFEST")
	secret=$(jq -r ".accounts[$account_id].secret" "$MANIFEST")
	digits=$(jq -r ".accounts[$account_id].digits" "$MANIFEST")
	otp=$(gpg --decrypt --quiet "$ACCOUNTS"/"$secret" | oathtool --totp=$mode -b -d $digits -)
	if [[ "$digits" == 6 ]]; then
		echo "******************"
		echo -e "*     $otp     *"
		echo "******************"
	else
		echo "********************"
		echo -e "*     $otp     *"
		echo "********************"
	fi
}

