#!/usr/bin/env sh
IFS=$'\n'
decoration() {
apt-get update -yq --silent
apt-get install gnupg -yq --silent
apt-get install curl -yq --silent
apt-get install wget -yq --silent
apt-get install neofetch -yq --silent
apt-get install ncurses-utils -yq --silent
mkdir -p ~/.termux
for i in colors.properties termux.properties font.tff; do
wget -q https://github.com/wardsenz/ebashell/raw/master/style/$i -O ~/.termux/$i
done
}
echo "[*] Установка..."
decoration
if [ -f $PREFIX/etc/motd ]; then rm -r $PREFIX/etc/motd; fi
cd $PREFIX/bin
if [ -f ebashell-update ]; then rm -f ebashell-update; fi
wget -q https://raw.githubusercontent.com/wardsenz/ebashell/master/updater.sh && mv updater.sh ebashell-update && chmod +x ebashell-update
cd $PREFIX/etc && rm bash.bashrc && wget -q https://raw.githubusercontent.com/wardsenz/ebashell/master/bash.bashrc
cd $PREFIX
if [ -d share/ebashell ]; then rm -rf share/ebashell; fi
cd share
git clone https://github.com/wardsenz/ebashell > /dev/null
cd ebashell && touch data.json
echo "Последнее обновление репозитория: 01.07.2020" > data.json
echo "Дата установки/Последней проверки: $(date)" >> data.json
cd $HOME
echo "[*] Успешно!"
am broadcast --user 0 -a com.termux.app.reload_style com.termux > /dev/null
echo "[*] Пожалуйста, перезапустите Termux..."