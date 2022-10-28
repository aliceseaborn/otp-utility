
function encrypt_secret {
	vipe <&- | gpg --recipient "$1" --armor --encrypt > "$2"
}
