
function list {
	total_accounts=$(jq ".accounts | length" "$MANIFEST")
	if [[ "$total_accounts" == 0 ]]; then
		echo "No accounts present."
	else
		(( total_accounts -= 1 ))
		output="ID NAME CONTEXT SERVICE USERNAME URL\n"
		output+="--- -------------------- ------------ ------------ ------------------------- -----------------------------\n"
		for i in $( eval echo "{0..$total_accounts}" )
		do
			id=$(jq ".accounts[$i].id" "$MANIFEST")
			url=$(jq -r ".accounts[$i].url" "$MANIFEST")
			name=$(jq -r ".accounts[$i].name" "$MANIFEST")
			context=$(jq -r ".accounts[$i].context" "$MANIFEST")
			service=$(jq -r ".accounts[$i].service" "$MANIFEST")
			username=$(jq -r ".accounts[$i].username" "$MANIFEST")

			output+="$id $name $context $service $username $url\n"
		done
		echo -e "${output}" | column -t
	fi
}

