#!/bin/bash
#
# Title:Install script for SSE Website
# Author(s): Jonathan Paulick
#
################################################################################
sudocheck() {
  if [[ $EUID -ne 0 ]]; then
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  You Must Execute as a SUDO USER (with sudo) or as ROOT!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    exit 0
  fi
}

ubuntuVersionCheck() {
	versioncheck=$(cat /etc/*-release | grep "Ubuntu" | grep -E '19')
  if [[ "$versioncheck" >= "19" ]]; then
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ WOAH! ......  System OS Warning!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Supported: UBUNTU 16.xx - 18.10 ~ LTS/SERVER
This server may not be supported due to having the incorrect OS detected!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  exit 0
  else echo ""; fi
}


agreeBase() {
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️ READ THIS NOTE 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
What would you like to do now? Select from the two option below.
[ Y ] Yes, I want to install the dependencies for MSOE SSE Webite
[ N ] No, I do not want to install the dependencies for MSOE SSE Website
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[ Z ] EXIT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Y | N or Z | Press [ENTER]: ' typed </dev/tty

  case $typed in
    Y) dependenciesInstall ;;
    y) dependenciesInstall ;;
    N) nope ;;
    n) nope ;;
    z) exit 0 ;;
    Z) exit 0 ;;
    *) badInput ;;
  esac
}

mainStart() {
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  Dependencies to install: 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
		┌─────────────────────────────────────┐
		│ software-properties-common          │
		│ rvm                                 │
		│ ruby                                │
		│ yarn                                │
		│ nodejs                              │
		└─────────────────────────────────────┘
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 0.5
}

dependenciesInstall() {
	sudo apt-get install software-properties-common
	installRVM
	installRuby
	installYarn
	installNodeJS
}

installExtras() {
	echo "not done yet"
}

askGit() {
	agreeBase() {
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  Install Git?: 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[ Y ] Yes, I want to install git on this machine
[ N ] No, I already have git installed or I don't want it
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Y | N or Z | Press [ENTER]: ' typed </dev/tty

  case $typed in
    Y) installGit ;;
    y) installGit ;;
    N) nope ;;
    n) nope ;;
    *) badInput ;;
  esac
}

installGit() {
	sudo apt install git
	git config --global user.name "Your Name"
	git config --global user.email "youremail@yourdomain.com"

	git config --list
}

setupSSHKeys() {
	ssh-keygen -t rsa -b 4096 -C 

	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa


	cat /home/users/.ssh/id_rsa.pub

	tee <<-EOF
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	🌎  INSTALLING: Git Notice
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	Go to https://github.com/settings/ssh/new and your ssh key
	If you need help refer to 
	https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	EOF

	ssh -T git@github.com
}

installSublimeText3() {
	echo -e "${c}Installing Sublime Text 3"; $r
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt update -y
	sudo apt install -y sublime-text
	;;
}


#############################

installRVM() {
	echo -e "${c}Installing RVM"; $r
	sudo apt-add-repository -y ppa:rael-gc/rvm
	sudo apt-get update
	sudo apt-get install rvm
	doneOkay
}

installRuby() {
	echo -e "${c}Installing Ruby"; $r
	echo 'source "/etc/profile.d/rvm.sh"' >> ~/.bashrc
	source /etc/profile.d/rvm.sh
	rvm install ruby
	doneOkay
}

installNodeJS() {
	echo -e "${c}Installing NodeJS"; $r
	cd
	curl -sL https://deb.nodesource.com/setup_12.x | sudo bash - #Submit the version according to your need.
	sudo apt install -y nodejs
	( set -x; nodejs -v )
	doneOkay
}

installYarn() {
	echo -e "${c}Installing Yarn"; $r
	curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install yarn
    doneOkay
}


##############################

badInput() {
  echo
  read -p '⛔️ ERROR - Bad Input! | Press [ENTER] ' typed </dev/tty
  agreeBase
}

nope() {
 echo
  exit 0
}

doneOkay() {
 echo
  read -p 'Install Success | PRESS [ENTER] ' typed </dev/tty
}

#############################
sudoCheck
ubuntuVersionCheck
sudo apt-get update
sudo apt-get upgrade
dependenciesInstall
doneOkay
