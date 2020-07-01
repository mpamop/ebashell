#!/bin/bash
IFS=$'\n'
update() {
	if [ "$(curl -I --silent google.com)" ]
	then
		printf "Обновление...\n"
		cd $PREFIX/share/ebashell
		if [ -f install.sh ]; then rm -f install.sh; fi
			if [ $(wget -q https://raw.githubusercontent.com/wardsenz/ebashell/master/install.sh) ]; then
			chmod +x install.sh && bash install.sh
			else
			printf "Ошибка при скачивании обновления.\n Возможные причины: Неполадки с соединением с GitHub и/или отсутствует пакет wget.\n"
		fi
	else
	printf "Не удалось проверить соединение с интернетом.\n"
	exit 1
fi
}
lastupd_rep=$(cat $PREFIX/share/ebashell/data.json | head -1)
lastupd_check=$(cat $PREFIX/share/ebashell/data.json | head -2)
printf "Последнее обновление репозитория: $lastupd_rep\n"
printf "Последняя проверка: $lastupd_check\n"
read -p "Вы уверены? (y/n)\n" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	update
else
	printf "Отменено.\n"
	exit 1
fi