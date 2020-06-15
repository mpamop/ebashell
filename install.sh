#!/usr/bin/env sh

# Colorful term
decoration() {
	apt-get update -yq --silent
	apt-get install gnupg -yq --silent
	mkdir -p ~/.termux
	for i in colors.properties termux.properties font.ttf; do
		wget -q https://github.com/wardsenz/ebashell/raw/master/style/$i -O ~/.termux/$i
	done
}
touch .termux_data_1506
if [ -f updater.sh ]; then rm updater.sh; fi
echo "[*] Применение..."
decoration
rm -r $PREFIX/etc/motd
cp $PREFIX/etc/bash.bashrc $PREFIX/etc/bash.bashrc.bk
cd ~
wget https://raw.githubusercontent.com/wardsenz/ebashell/master/bash.bashrc
cd ../usr/ && mv /$HOME/bash.bashrc etc

echo "[*] Применено"
am broadcast --user 0 -a com.termux.app.reload_style com.termux > /dev/null
echo "[*] Пожалуйста, перезапустите Termux для корректной работы"
