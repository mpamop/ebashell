IFS=$'\n'
cd ~
echo "Updating..."
if [ -f install.sh ]; then rm -f install.sh; fi
echo "Please wait..." && sleep 3
wget -q https://raw.githubusercontent.com/wardsenz/ebashell/master/install.sh
chmod +x install.sh
sh install.sh
