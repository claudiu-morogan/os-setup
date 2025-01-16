#!/bin/bash

# Just to look good
echo '##############################'
echo '# Preparing to setup your PC #'
echo '#           MASTER           #'
echo '##############################'
echo ''
echo 'Enter your email address:'
read git_email

# update the system before installing the tools
cd ~ && sudo apt-get update -y && sudo apt-get upgrade -y

# Installing terminal utilities
echo 'Installing terminal utilities'
sudo apt-get install -y mc htop neofetch xclip git docker docker.io docker-engine docker-compose curl python3 python3-pip

# Adding ppa for icon pack
sudo add-apt-repository ppa:papirus/papirus -y && sudo apt-get update -y

echo 'Installing VLC'
sudo apt-get install -y vlc vlc-plugin-access-extra libbluray-bdj libdvdcss2

# Docker setup
sudo groupadd docker || true
sudo usermod -aG docker $USER
sudo chmod 777 /var/run/docker.sock
docker --version

echo 'Generating a SSH Key'
ssh-keygen -t rsa -b 4096 -C $git_email
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard

echo 'Installing FiraCode'
sudo apt-get install -y fonts-firacode

echo 'Installing VSCode'
sudo snap install code --classic

echo 'Installing PHPStorm'
sudo snap install phpstorm --classic

echo 'Installing Datagrip'
sudo snap install datagrip --classic

echo 'All setup, enjoy!'
