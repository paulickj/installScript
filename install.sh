#!/bin/bash
################################################################################
# Title:Install script for SSE Website
# Author(s): Jonathan Paulick
#
################################################################################
sudo_check() {
    if [[ $EUID -ne 0 ]]; then
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  You Must Execute as a SUDO USER (with sudo) or as ROOT!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    exit 0
  fi
}

agree_base() {
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
    Y) main_start ;;
    y) main_start ;;
    N) nope ;;
    n) nope ;;
    z) exit 0 ;;
    Z) exit 0 ;;
    *) bad_input ;;
  esac
}

main_start() {
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
sleep 2.5
}

dependencies_install() {
    sudo apt-get install -yqq software-properties-common
    install_rvm
    install_ruby
    install_yarn
    install_nodejs
}

#############################

install_rvm() {
    echo -e "${c}Installing RVM"; $r
    sudo apt-get update -yqq
    sudo apt-get install -yqq rvm
    command curl -sSL https://rvm.io/mpapis.asc | sudo gpg --import -
    command curl -sSL https://rvm.io/pkuczynski.asc | sudo gpg --import -
    \curl https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer | bash -s stable
    source ~/.rvm/scripts/rvm
    done_okay
}

install_ruby() {
    echo -e "${c}Installing Ruby"; $r
    echo 'source "/etc/profile.d/rvm.sh"' >> ~/.bashrc
    source /etc/profile.d/rvm.sh
    rvm install ruby 2.7.4 
    done_okay
}

install_nodejs() {
    echo -e "${c}Installing NodeJS"; $r
    cd
    curl -sL https://deb.nodesource.com/setup_12.x | sudo bash - #Submit the version according to your need.
    sudo apt install -yqq nodejs
    ( set -x; nodejs -v )
    done_okay
}

install_yarn() {
    echo -e "${c}Installing Yarn"; $r
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update -yqq
    sudo apt-get -yqq install yarn 
    done_okay
}


##############################

bad_input() {
  echo
  read -p '⛔️ ERROR - Bad Input! | Press [ENTER] ' typed </dev/tty
  agree_base
}

nope() {
 echo
  exit 0
}

done_okay() {
 echo
  read -p 'Install Success | PRESS [ENTER] ' typed </dev/tty
}

final() {
    echo "The next step is to reboot this computer/vm"
    done_okay
}

#############################
agree_base
sudo_check
sudo apt-get update -yqq
sudo apt-get upgrade -yqq
dependencies_install
final
