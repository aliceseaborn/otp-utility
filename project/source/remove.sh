
function remove {
	list
	read -p "Specify the account id: " account_id
	jq "del(.accounts[$account_id])" $MANIFEST > $MANIFEST_TMP
	commit
	echo "Done."
}

