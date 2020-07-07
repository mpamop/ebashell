#!/bin/bash
### Цвета RGB
R='\033[0;31m'
G='\033[0;32m'
B='\033[0;36m'
N='\033[0m'

	# Имя пользователя
	user_info() {
		echo -e "## ${G}User:${N} $(id -un || printf %s "${HOME/*\/}")"
		}

	# Хостнейм
	host_info() {
		echo -e "## ${G}Host:${N} $(hostname || echo $HOSTNAME)"
		}

	# Ядро
	kernel_info() {
		echo -e "## ${G}Kernel:${N} $(uname -r)"
		}

	# Бренд
	model_info() {
		echo -e "## ${G}Model:${N} $(getprop ro.product.brand)"
		}

	# Устройство
	device_info() {
		echo -e "## ${G}Device:${N} $(getprop ro.product.model)"
		}
	
	# Память ОЗУ
	ram_info() {
		echo -e "## ${G}Meminfo:${N} $(free | awk '/Mem/{printf("used: %.2f%"), $3/$2*100} /buffers\/cache/{printf(", buffers: %.2f%"), $4/($3+$4)*100} /Swap/{printf(", swap: %.2f%"), $3/$2*100}')"
		}
	
	# Память (пзу)
	disk_info() {
		echo -e "## ${G}Disk:${N} / $(df -h / | egrep -o '[0-9]+%')"
		}
	
	# Батарея
	batt_info() {
		batt_perc=$(termux-battery-status | grep -zoP '"percentage":\s*\K[^\s,]*(?=\s*,)' | tr -d '\0"')
		batt_stat=$(termux-battery-status | grep -zoP '"status":\s*\K[^\s,]*(?=\s*,)' | tr -d '\0"')
		echo -e "## ${G}Battery:${N} "$batt_perc"% - ${B}$batt_stat${N}"
		}
	
	
	### Проверка на Termux:API с помощью timeout
	apicheck() {
			( termux-battery-status > /dev/null 2>&1 ) & pid=$!
			( sleep 5 && kill $pid ) 2>/dev/null & watcher=$!
				if wait $pid 2>/dev/null; then
					pkill -P $watcher
					wait $watcher
					batt_info
				else
					echo -e "!! Battery info check timed out: ${R}API ERR${N}\nPlease install Termux:API from Google Play or F-Droid" 
				fi
			}

	# Версия Android
	version_info() {
		echo -e "## ${G}Android:${N} $(getprop ro.build.version.release)"
		}

	# Логотип через neofetch, так как лень изучать ASCII
	neo_logo() {
		neofetch --logo --ascii_distro android_small
		}

user_info
host_info
kernel_info
model_info
device_info
ram_info
disk_info
apicheck
version_info
neo_logo