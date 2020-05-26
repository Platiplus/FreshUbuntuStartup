sudo apt-get update

echo 'Instalando curl' 
sudo apt install curl -y

echo 'Instalando git' 
sudo apt install git -y

echo "Qual o nome do usuário GIT que você gostaria de usar?"
read git_config_user_name
git config --global user.name "$git_config_user_name"
clear 

echo "Qual o email que você utilizará no GIT?"
read git_config_user_email
git config --global user.email $git_config_user_email
clear

echo "Você quer utilizar o VIM como editor padrão para o GIT? (y/n)"
read git_core_editor_to_vim
if echo "$git_core_editor_to_vim" | grep -iq "^y" ;then
	git config --global core.editor vim
else
	echo "Beleza, vamos pro próximo passo..."
fi

echo "Gerando uma chave SSH"
ssh-keygen -t rsa -b 4096 -C $git_config_user_email
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard

echo 'Habilitando workspaces para duas telas' 
gsettings set org.gnome.mutter workspaces-only-on-primary false

echo 'Instalando zsh'
sudo apt-get install zsh -y
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s /bin/zsh

echo 'Instalando ferramenta para lidar com a clipboard via CLI'
sudo apt-get install xclip -y

export alias pbcopy='xclip -selection clipboard'
export alias pbpaste='xclip -selection clipboard -o'
source ~/.zshrc

echo 'Instalando vim'
sudo apt install vim -y
clear

echo 'Instalando VSCode'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y
sudo apt-get update
sudo apt-get install code -y # or code-insiders

echo 'Instalando Extensões'
code --install-extension dbaeumer.vscode-eslint
code --install-extension christian-kohler.path-intellisense
code --install-extension dbaeumer.vscode-eslint
code --install-extension dracula-theme.theme-dracula
code --install-extension esbenp.prettier-vscode
code --install-extension foxundermoon.shell-format
code --install-extension pmneo.tsimporter
code --install-extension waderyan.gitblame
code --install-extension yzhang.markdown-all-in-one

echo 'Instalando Spotify' 
snap install spotify

echo 'Instalando Chrome' 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

echo 'Instalando nvm' 
sh -c "$(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash)"

export NVM_DIR="$HOME/.nvm" && (
git clone https://github.com/creationix/nvm.git "$NVM_DIR"
cd "$NVM_DIR"
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

source ~/.zshrc
nvm --version
nvm install 12
nvm alias default 12
node --version
npm --version

echo 'Instalando autosuggestions para o ZSH' 
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
source ~/.zshrc

echo 'Instalando tema para o ZSH'
sudo apt install fonts-firacode -y
wget -O ~/.oh-my-zsh/themes/node.zsh-theme https://raw.githubusercontent.com/skuridin/oh-my-zsh-node-theme/master/node.zsh-theme 
sed -i 's/.*ZSH_THEME=.*/ZSH_THEME="node"/g' ~/.zshrc

echo 'Instalando Docker' 
sudo apt-get remove docker docker-engine docker.io
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
docker --version

chmod 777 /var/run/docker.sock
docker run hello-world

echo 'Instalando docker-compose' 
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo 'Instalando TeamViewer'
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo apt install -y ./teamviewer_amd64.deb

echo 'Instalando FZF'
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

echo 'Instalando Brave'
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
source /etc/os-release
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-${UBUNTU_CODENAME}.list
sudo apt update
sudo apt install brave-keyring brave-browser

echo 'installing DBeaver'
wget -c https://dbeaver.io/files/6.0.0/dbeaver-ce_6.0.0_amd64.deb
sudo dpkg -i dbeaver-ce_6.0.0_amd64.deb
sudo apt-get install -f
