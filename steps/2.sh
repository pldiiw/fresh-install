echo "Autoremoving useless softwares' leftovers..."
sudo apt-get autoremove -y
sudo apt-get autoclean -y

rebootAfterwards=true
