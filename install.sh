#!/usr/bin/env sh
IFS=$'\n'
decoration() {
apt-get update -yq --silent
apt-get install gnupg -yq --silent
apt-get install curl -yq --silent
apt-get install wget -yq --silent
apt-get install neofetch -yq --silent
apt-get install termux-api -yq --silent
apt-get install ncurses-utils -yq --silent
mkdir -p ~/.termux
for i in colors.properties termux.properties font.tff; do
wget -q https://github.com/wardsenz/ebashell/raw/master/style/$i -O ~/.termux/$i
done
}
echo "[*] Установка..."
decoration
	if [ -f $PREFIX/etc/motd ]; then
		rm -r $PREFIX/etc/motd;
	fi

	cd $PREFIX/bin

	update_updater() {
		if [ -f ebashell-update ]; then
			rm -f ebashell-update;
		fi
		wget -q https://raw.githubusercontent.com/wardsenz/ebashell/master/updater.sh
		mv updater.sh ebashell-update
		chmod +x ebashell-update
	}
update_updater
# o_O
	update_minfetch() {
		if [ -f minfetch ]; then
			rm -f minfetch;
		fi
		wget -q https://raw.githubusercontent.com/wardsenz/ebashell/master/minfetch.sh
		mv minfetch.sh minfetch
		chmod +x minfetch
	}
update_minfetch

	update_bashrc() {
		cd $PREFIX/etc
		rm bash.bashrc
		wget -q https://raw.githubusercontent.com/wardsenz/ebashell/master/bash.bashrc
		}
update_bashrc

	update_clone() {
		cd $PREFIX
		if [ -d share/ebashell ]; then
			rm -rf share/ebashell;
		fi
		cd share
		git clone https://github.com/wardsenz/ebashell > /dev/null 2>&1
		cd ebashell
		touch data.json
		lastcommit=$(curl https://api.github.com/repos/wardsenz/ebashell/commits/master 2>&1 | grep '"date"' | tr -d ' :"date' | tail -n 1)
		echo "Последний коммит в репозитории: $lastcommit" > data.json
		echo "Дата установки/последней проверки: $(date)" >> data.json
		cd $HOME
		}
update_clone
	echo "[*] Успешно!"
	am broadcast --user 0 -a com.termux.app.reload_style com.termux > /dev/null
	echo "[*] Пожалуйста, перезапустите Termux..."