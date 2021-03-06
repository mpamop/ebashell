IFS=$'\n'
if [ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]; then
	command_not_found_handle() {
		/data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
	}
fi
# PS1='\[\e[1;34m\] termux > \[\e[0;37m\]'
export PS1="╭─\[\e[1;34m\] termux \[\e[0;37m\][\w] \A
╰─> $ "
minfetch
COLUMNS=$(tput cols) 
title="Обновить: ebashell-update • Минифеч: minfetch --help • Помощь в TG: @friendlytgbot_ru" 
printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'