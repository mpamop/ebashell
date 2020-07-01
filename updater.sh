#!/bin/bash
IFS=$'\n'
update() {
	if [ $(curl --silent --output /dev/null google.com) ]
	then
		printf "Обновление...\n"
		RAW="https://raw.githubusercontent.com/wardsenz/ebashell/master/"
		cd $PREFIX/share && mkdir ebashell && cd ebashell
			if [ $(wget -q ""$RAW"install.sh" && wget -q ""$RAW"bash.bashrc") ]; then
			rm -f $PREFIX/etc/bash.bashrc && cp bash.bashrc $PREFIX/etc/
			chmod +x install.sh && bash install.sh
			else
			printf "Ошибка при скачивании обновления.\n Возможные причины: Неполадки с соединением с GitHub и/или отсутствует пакет wget.\n"
		fi
	else
	printf "Не удалось проверить соединение с интернетом.\n"
	exit 1
fi
}
read -p "Вы уверены? (y/n)" -n 1 -r
lastupd_rep=$(cat $PREFIX/share/ebashell/data.json | head -1)
lastupd_check=$(cat $PREFIX/share/ebashell/data.json | head -2)
printf "Последнее обновление репозитория: $lastupd_rep\n"
printf "Последняя проверка: $lastupd_check\n"
if [[ $REPLY =~ ^[Yy]$ ]]
then
	update
else
	printf "Отменено.\n"
	exit 1
fi