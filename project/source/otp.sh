
if [[ -n "$1" ]]; then
	# otp help|-h
	if [[ "$1" == "-h" || "$1" == "help" ]]; then
		help
	# otp list|-l
	elif [[ "$1" == "-l" || "$1" == "list" ]]; then
		list     
	# otp create|-c
	elif [[ "$1" == "-c" || "$1" == "create" ]]; then
		create
	# otp remove|-r
	elif [[ "$1" == "-r" || "$1" == "remove" ]]; then
		remove
	# otp generate|-g
	elif [[ "$1" == "-g" || "$1" == "generate" ]]; then
		generate "$2"
	# otp export|-e
	elif [[ "$1" == "-e" || "$1" == "export" ]]; then
		export "$2"
	# default
	else
		help
	fi
else
	help
fi

