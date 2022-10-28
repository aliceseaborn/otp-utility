# OTP Utility

Manages multiple secret-keys used by an account for second-factor authentication (2FA). Each secret-key/seed is stored in its own account file and is encrypted with the user's pgp key. Account files are temporarily decrypted on-the-fly to generate fresh OTPs for logging-in/accessing a 2FA-protected resource.

This project yearns to be re-written in C++ but i have nor had a chance to get to that. In time, be patient.

**Requires:**
* gcc - Modern C compiler
* shc - Generic Shell Script Compiler
* jq - JSON processor
* vipe - run your editor in the middle of a unix pipeline and edit the data that is being piped between programs
* vim - Vi improved, text editor
* gpg - OpenPGP encryption and signing tool
* oathtool - Open AuTHentication (OATH) one-time password tool


### Installation

To install this application, simply clone this repo into your desired installation directory, change directory into `project/`, and run the `install.sh` script. The compiled binary will be stored in the `project/bin` folder for your use.



*alice seaborn.*
