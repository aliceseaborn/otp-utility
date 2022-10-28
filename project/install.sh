#!/bin/bash
# INSTALL


function check_for_required_programs {
	echo -e "\nChecking for required programs..."

	required_programs=( "gcc" "shc" "jq" "vipe" "gpg" "oathtool" )
	for program in ${required_programs[*]}; do
		if ! command -v "$program" &> /dev/null; then
			echo -e "Error: $program could not be found"
			echo -e "Consider installing $program using the command below."
			if [[ "$program" == "vipe" ]]; then
				echo -e "\tsudo apt-get install -y moreutils"
			else
				echo -e "\tsudo apt-get install -y $program"
			fi
			exit 1
		else
			program_path=$( command -v $program )
			if [[ "$program" == "oathtool" ]]; then
				echo -e "Using $program: $program_path"
			else
				echo -e "Using $program: \t$program_path"
			fi
		fi
	done

	echo "All required programs have been installed."
}


function create_home_directory_structure {
	echo -e "\nCreating home directory structure..."
	mkdir -p "$HOME"/.otp/accounts
	echo -e "{\n\t\"accounts\": []\n}" > "$HOME/.otp/manifest.json"
	echo "Done."
}


function _assemble_compile_target {
	touch source/compile.sh
	> source/compile.sh
	cat source/header.sh >> source/compile.sh
	cat source/help.sh >> source/compile.sh
	cat source/list.sh >> source/compile.sh
	cat source/generate.sh >> source/compile.sh
	cat source/encrypt-secret.sh >> source/compile.sh
	cat source/export.sh >> source/compile.sh
	cat source/commit.sh >> source/compile.sh
	cat source/create.sh >> source/compile.sh
	cat source/remove.sh >> source/compile.sh
	cat source/otp.sh >> source/compile.sh
}


function compile_otp_utility {
	echo -e "\nCompiling the otp utility..."
	mkdir bin
	_assemble_compile_target
	shc -f source/compile.sh -o bin/otp
	rm -f source/*.x.c
	rm -f source/compile.sh
	echo "Done."
}


function make_hpc_modulefile {
	echo "#%Module1.0#####################################################################" > modulefile
	echo "## OTP 0.0.1" >> modulefile
	echo "##" >> modulefile
	echo "proc ModulesHelp { } {" >> modulefile
	echo "    puts stderr \"\\tAppends the OTP utility 0.0.1 to PATH.\"" >> modulefile
	echo "}" >> modulefile
	echo "" >> modulefile
	echo "module-whatis   \"A simple and secure one-time-password utility.\"" >> modulefile
	echo "" >> modulefile
	echo "set             otp_root    $PWD" >> modulefile
	echo "set             otp         \$otp_root/bin" >> modulefile
	echo "prepend-path    PATH        \$otp" >> modulefile
}


function echo_path_recommendations {
	echo -e "\nUse the included hpc modulefile or run the command below to append this program to your PATH."
	echo -e "\texport PATH=\$PATH:\$PWD/bin"
	echo ""
}


echo -e "Beginning installation..."
check_for_required_programs
create_home_directory_structure
compile_otp_utility
make_hpc_modulefile
echo_path_recommendations
echo "Installation complete."

