#!/bin/sh

USER=`who | grep tty7 | awk '{print $1}'`

# if no tty7, try tty1

if [ -z "$USER" ]; then
	USER=`who | grep tty1 | awk '{print $1}'`
fi

# create symbolic links
dir=$(dirname $(realpath $0))
awesome_config_dir="/home/$USER/.config/awesome/"

ln -s $dir"/notify-awesome" "/usr/lib/udev/"
ln -s $dir"/98-screen-detect.rules" "/etc/udev/rules.d/"
ln -s $dir"/screenful.lua" $awesome_config_dir
ln -s $dir"/screens_db.lua" $awesome_config_dir
ln -s $dir"/screenmenu.lua" $awesome_config_dir
