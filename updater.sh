cd
echo "Начинаю процесс обновления...."
if [ -f install.sh ]; then rm install.sh; fi
echo "Проверяю, установлен ли пакет wget..." && sleep 5
if dpkg -s wget; then echo "wget - связь есть. Секунду..." && sleep 5; else echo "Пакет wget отсутствует. Устанавливаю wget..." && sleep 5 && pkg install wget -y > /dev/null; fi
wget https://raw.githubusercontent.com/wardsenz/ebashell/master/install.sh
chmod +x install.sh
./install.sh
