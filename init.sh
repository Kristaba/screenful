#!/bin/sh

# create symbolic links
dir=$(dirname $(realpath $0))
awesome_config_dir="/home/fred/.config/awesome/"


ln -s $dir"/notify-awesome" "/usr/lib/udev/"
ln -s $dir"/98-screen-detect.rules" "/etc/udev/rules.d/"
ln -s $dir"/screenful.lua" $awesome_config_dir
ln -s $dir"/screens_db.lua" $awesome_config_dir
