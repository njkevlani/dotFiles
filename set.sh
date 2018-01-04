echo "Tilix config will be update"
echo "And the following files will be replaced:"
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

	dconf load /com/gexperts/Tilix/ < tilix_02_Jan_2018.conf
	ln i3config ~/.config/i3/config
	ln i3blocksconfig ~/.config/i3blocks/config
	ln roficonfig ~/.config/rofi/config
	ln dunstrc ~/.config/dunst/dunstrc
	ln bashrc ~/.bashrc
else
	exit
fi