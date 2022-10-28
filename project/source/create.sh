
function create {
	read -p "Name of the OTP account: " name
	secret="$name.asc"
	if [[ -z "$name" ]]; then
		echo "Error, please specify an account name."
		exit 1
	fi
	
	read -p "Type of service provided: " service
	if [[ -z "$service" ]]; then
		echo "Error, please specify the account service."
		exit 1
	fi

	read -p "Service URL: " url
	if [[ -z "$url" ]]; then
		echo "Error, please specify the account url."
		exit 1
	fi

	read -p "Account context: " context
	if [[ -z "$context" ]]; then
		echo "Error, please specify the account context."
		exit 1
	fi
	
	read -p "Username for this account: " username
	if [[ -z "$username" ]]; then
		echo "Error, please specify your account username."
		exit 1
	fi
	
	read -p "Select OTP type (1) totp or (2) hotp: " _otptype
	if [[ "$_otptype" == "1" ]]; then
		otptype="totp"
	elif [[ "$_otptype" == "2" ]]; then
		otptype="hotp"
	else
		echo "Unrecognized input. Please select from (1) totp or (2) hotp."
		exit 1
	fi
	
	read -p "Select OTP digits (6) or (8): " _digits
	if [[ "$_digits" == "6" ]]; then
		digits=6
	elif [[ "$_digits" == "8" ]]; then
		digits=8
	else
		echo "Unrecognized input. Please select from (6) or (8)."
		exit 1
	fi
	
	read -p "Select the hashing mode (1) SHA1, (2) SHA256 or (3) SHA512: " _mode
	if [[ "$_mode" == "1" ]]; then
		mode="SHA1"
	elif [[ "$_mode" == "2" ]]; then
		mode="SHA256"
	elif [[ "$_mode" == "3" ]]; then
		mode="SHA512"
	else
		echo "Unrecognized input. Please select from (1) SHA1, (2) SHA256 or (3) SHA512."
		exit 1
	fi
	
	id=$(jq ".accounts | length" "$MANIFEST")

	jq --arg id "$id" --arg otptype "$otptype" --arg digits "$digits" --arg mode "$mode" --arg context "$context" --arg name "$name" --arg service "$service" --arg url "$url" --arg username "$username" --arg secret "$secret" '.accounts[.accounts | length] |= . + {"id":  $id|tonumber, "type": $otptype, "digits": $digits|tonumber, "mode": $mode, "context": $context, "name": $name, "service": $service, "url": $url, "username": $username, "secret": $secret}' "$MANIFEST" > "$MANIFEST_TMP"
	commit

	read -p "GPG user id for handling the secret: " user_id
	read -p "Supply the OTP secret to the vim pipe buffer: <enter> " _nothing
	encrypt_secret $user_id $ACCOUNTS/$secret

	echo "Done."
}

