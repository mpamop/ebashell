IFS=$'\n'
if [ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]; then
command_not_found_handle() { data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
}
fi
PS1='\[\e[1;34m\] termux > \[\e[0;37m\]'

echo "Starting..."
wget -q https://raw.githubusercontent.com/wardsenz/ebashell/master/bash.bashrc
cd ../usr
rm etc/bash.bashrc
mv /$HOME/bash.bashrc etc
cd ~
if [ -f updater.sh ]; then rm -f updater.sh; fi
wget -q https://raw.githubusercontent.com/wardsenz/ebashell/master/updater.sh
chmod +x updater.sh
clear
if [ -f .termux_data_15061 ]; then echo "ebashell is already up to date. Last check: 15.06.2020"; else ./updater.sh; fi
sleep 3
echo "Hi, user. Here is system info:"
neofetch