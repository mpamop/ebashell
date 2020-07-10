#!/bin/bash
IFS=$'\n'
update() {
	if [ "$(curl -I --silent google.com)" ]
	then
		printf "\n"
		printf "Обновление...\n"
		cd $PREFIX/share/ebashell
		if [ -f install.sh ]; then rm -f install.sh; fi
			if wget -q https://raw.githubusercontent.com/wardsenz/ebashell/master/install.sh; then
			chmod +x install.sh && bash install.sh
			else
			printf "Ошибка при скачивании обновления.\n Возможные причины: Неполадки с соединением с GitHub и/или отсутствует пакет wget.\n"
		fi
	else
	printf "Не удалось проверить соединение с интернетом.\n"
fi
}
lastupd=$(cat $PREFIX/share/ebashell/data.json)
lastcommit=$(curl https://api.github.com/repos/wardsenz/ebashell/commits/master 2>&1 | grep '"date"' | tr -d ' :"date' | tail -n 1)
printf "$lastupd\n"
printf "Последнее изменение в репозитории: $lastcommit\n"
read -p "Вы уверены? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	update
else
	printf "\n"
	printf "Отменено.\n"
fi