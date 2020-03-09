#! /bin/bash

#Script to install important applications on a fresh install of Ubuntu and Debian based systems.

#The following files are required in the same folder of the script for the installation to work:
#hyper.deb
#visualstudiocode.deb
#discord.deb
#googlechrome.deb

#Get the .deb files from their respective websites and rename then

###Checking for the .deb files
read -r -p "This script will install some programs trough the .deb files, and they should be in the same folder you're running the script from. Do you wish to proceed? [y/n] " RESP
RESP=${RESP,,}    # tolower (only works with /bin/bash)
if [[ $RESP =~ ^(yes|y)$ ]]
then

#######
#Adding repositories and PPA's
echo
echo "Adding repositories..."
echo
sudo apt-add-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo add-apt-repository ppa:ubuntu-x-swat/x-updates # nvidia driver updates
sudo add-apt-repository ppa:transmissionbt/ppa
sudo add-apt-repository ppa:jd-team/jdownloader

#Update & Upgrade
echo
echo "Updating and Upgrading"
echo
sudo apt-get update && sudo apt-get upgrade -y

#Remove unused programs
echo
echo "Removing unused programs..."
echo
sudo apt-get remove hexchat hexchat-common thunderbird thunderbird-gnome-support thunderbird-locale-en  thunderbird-locale-en-us  banshee tomboy pidgin pidgin-libnotify -y
printf "\n${GREEN}System sucessfully updated!${NORMAL}\n"

#Installing development setup
echo
printf "\n${YELLOW}Starting the installation of the development setup...${NORMAL}\n"
echo
###########
echo "Installing build-essentials..."
sudo apt-get install build-essential -y
echo

echo "Installing curl..."
sudo apt-get install curl -y
echo

echo "Installing Node Version Manager..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
echo

echo "Setting up Node.js..."
nvm use 10
echo

echo "Installing git and ssh..."
sudo apt-get install git ssh -y
echo

echo "Installing Hyper..."
sudo dpkg -i hyper.deb
echo

echo "Installing zhs..."
sudo apt-get install zsh -y
echo

echo "Installing Visual Studio Code and dependencies..."
sudo dpkg -i visualstudiocode.deb
sudo apt-get install -f
xdg-mime default code.desktop text/plain
echo
printf "\n${GREEN}Development enviroment sucessfully instaled!${NORMAL}\n"

#Installing utility programs
printf "\n${GREEN}Starting the installation of utility programs...${NORMAL}\n"
echo

echo "Installing VLC..."
sudo apt-get install vlc -y
echo

echo "Installing Discord..."
sudo dpkg -i discord.deb
sudo apt-get install -f
echo

echo "Installing Mailspring..."
sudo apt-get install mailspring -y
echo

echo "Installing Google Chrome..."
sudo dpkg googlechrome.deb
echo

echo "Installing Slack"
sudo apt-get install slack -y
echo

echo "Installing Spotify"
sudo snap install spotify
echo

printf "\n${GREEN}Utility programs sucessfully installed!${NORMAL}\n"

#Cleaning up and finishing
printf "\n${YELLOW}Cleaning up the cache and finishing...${NORMAL}\n"
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get autoclean
echo

printf "\n${GREEN}All done! Make sure to execute the git_configure.sh to sync your Git to Github.${NORMAL}\n"


fi
