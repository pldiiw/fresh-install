echo "Setting neovim as default editor..."
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor

echo "Autoremoving useless softwares' leftovers..."
sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo "You should reboot your computer."
