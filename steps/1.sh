echo "Removing useless softwares..."
sudo apt-get purge mtpaint pidgin sylpheed abiword gnumeric -y

echo "Installing good softwares..."
sudo apt-get install build-essential software-properties-common python-dev \
  python-pip python3-dev python3-pip git zsh git-extras pass puredata wine \
  libreoffice gimp inkscape golang solfege xdotool blender redshift curl \
  screen cmake traceroute chromium-browser clang imagemagick graphicsmagick \
  ffmpeg unrar mumble trickle autoconf autogen automake pkg-config gcc \
  flashplugin-installer skype bup virtualbox gnome-dictionary uuid uuid-dev \
  thunderbird gnutls-bin libgnutls-dev libncurses5 libncurses5-dev synapse \
  htop -y

echo "Installing neovim..."
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update
sudo apt-get install neovim
pip install neovim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing youtube-dl..."
sudo curl -L https://yt-dl.org/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

echo "Installing haskell stack..."
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 575159689BEFB442
echo 'deb http://download.fpcomplete.com/ubuntu wily main' | sudo tee \
  /etc/apt/sources.list.d/fpco.list
sudo apt-get update
sudo apt-get install stack -y
echo "Setting up stack and installing purescript..."
stack setup
stack install purescript --resolver=nightly

echo "Installing docker..."
sudo apt-get install -y apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys \
  58118E89F3A912897C070ADBF76221572C52609D
echo 'deb https://apt.dockerproject.org/repo ubuntu-wily main' | sudo tee \
  /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get purge -y lxc-docker
sudo apt-cache policy docker-engine
sudo apt-get install -y linux-image-extra-$(uname -r)
sudo apt-get update
sudo apt-get install -y docker-engine
sudo service docker start

echo "Installing ethereum..."
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install -y ethereum

echo "Installing google chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f -y
rm -f google-chrome-stable_current_amd64.deb

echo "Installing elixir..."
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
sudo dpkg -i erlang-solutions_1.0_all.deb
sudo apt-get update
sudo apt-get install -y esl-erlang elixir
rm -f erlang-solutions_1.0_all.deb

echo "Installing steam..."
wget http://repo.steampowered.com/steam/archive/precise/steam_latest.deb
sudo dpkg -i steam_latest.deb
sudo apt-get install -f -y
rm -f steam_latest.deb

echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.7/install.sh | \
  bash
export NVM_DIR="/home/pld/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install node
nvm use node
npm up -g

echo "Installing bower and pulp..."
npm i -g pulp bower

echo "Installing taskwarrior..."
git clone https://git.tasktools.org/scm/tm/task.git ~/task
(cd ~/task && cmake -DCMAKE-BUILD-TYPE=release . && make && sudo make install)
rm -rf ~/task

echo "Installing ipfs v0.4.3..."
wget https://dist.ipfs.io/go-ipfs/v0.4.3/go-ipfs_v0.4.3_linux-amd64.tar.gz
tar xvzf go-ipfs_v0.4.3_linux_amd64.tar.gz
(cd go-ipfs && sudo ./install.sh)
rm -rf go-ipfs*

echo "Installing httpstat..."
pip install httpstat

echo "Installing progress..."
git clone https://github.com/Xfennec/progress.git
(cd progress && make && sudo make install)
rm -rf progress

echo "Installing dripcap v0.3.10..."
wget https://github.com/dripcap/dripcap/releases/download/v0.3.10/dripcap-linux-amd64.deb
sudo dpkg -i dripcap-linux-amd64.deb
sudo apt-get install -f -y
rm -rf dripcap-linux-amd64.deb

echo "Installing rust..."
curl -sSf https://static.rust-lang.org/rustup.sh | sh

echo "Installing ripgrep..."
cargo install rigrep

echo "Installing Keybase app..."
curl -O https://prerelease.keybase.io/keybase_amd64.deb
sudo dpkg -i keybase_amd64.deb
sudo apt-get install -f -y
run_keybase
rm -f keybase_amd64.deb

echo "Installing oh-my-zsh..."
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
echo "Backing up zshrc"
cp ~/.zshrc ~/.zshrc.orig
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
echo "Setting zsh as default shell..."
chsh -s /bin/zsh pld
