#!/bin/bash

function set(){
	echo "The following files will be replaced:"
	echo "~/.config/i3/config"
	echo "~/.config/i3blocks/config"
	echo "~/.config/rofi/config"
	echo "~/.config/dunst/dunstrc"
	echo "~/.bashrc"
	read -p "Are you sure? (Backup will be taken as .bk files) (y/n)" -n 1 -r
	echo 
	if [[ $REPLY =~ ^[Yy]$ ]]
	then

		mv ~/.config/i3/config ~/.config/i3/config.bk
		mv ~/.config/i3blocks/config ~/.config/i3blocks/config.bk
		mv ~/.config/rofi/config ~/.config/rofi/config.bk
		mv ~/.config/dunst/dunstrc ~/.config/dunst/dunstrc.bk
		mv ~/.bashrc ~/.bashrc.bk

		ln i3config ~/.config/i3/config
		ln i3blocksconfig ~/.config/i3blocks/config
		ln roficonfig ~/.config/rofi/config
		ln dunstrc ~/.config/dunst/dunstrc
		ln bashrc ~/.bashrc
	else
		exit
	fi	
}

backup(){
	cp ~/.config/i3/config ./backup/i3config_`date +"%m-%d-%y_%H:%M"`.bk
	cp ~/.config/i3blocks/config ./backup/i3blocksconfig_`date +"%m-%d-%y_%H:%M"`.bk
	cp ~/.config/rofi/config ./backup/roficonfig_`date +"%m-%d-%y_%H:%M"`.bk
	cp ~/.config/dunst/dunstrc ./backup/dunstrc_`date +"%m-%d-%y_%H:%M"`.bk
	cp ~/.bashrc ./backup/bashrc_`date +"%m-%d-%y_%H:%M"`.bk

}

show_help(){
	echo -e "-b\tJust take backup"
}








POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -b|--backup)
	backup
    shift # past argument    
    ;;
    -s|--searchpath)    
    shift # past argument    
    ;;
    -h|--help)
    show_help
    shift # past value
    ;;
    --default)
    show_help
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done

