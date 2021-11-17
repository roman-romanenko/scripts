echo "Disable Cloud Init"
sudo touch /etc/cloud/cloud-init.disabled

echo "Create No Password Sudo"
#echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
sudo sh -c 'echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'

echo "Install Needed Software"
sudo apt update
sudo apt upgrade -y
sudo apt install -y xrdp xubuntu-core copyq flameshot software-properties-common apt-transport-https wget engrampa firefox

echo "Confitue XRDP Session"
#echo xfce4-session > ~/.xsession
sudo sh -c 'echo "xfce4-sessionL" > ~/.xsession'

echo "Install VSCode"
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install -y code

echo "Install Docker and Docker-compose"
sudo apt-get install -y curl apt-transport-https ca-certificates software-properties-common 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" 
sudo apt update 
sudo apt install -y docker-ce
sudo usermod -aG docker $USER 
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose 
sudo chmod +x /usr/local/bin/docker-compose
docker --version
docker-compose --version

echo "Deal with Theaming"

wget https://github.com/roman-romanenko/setup/raw/main/theming/Tela-circle.tar.xz
mkdir .icons
tar -xf Tela-circle.tar.xz -C ~/.icons
wget https://github.com/roman-romanenko/setup/raw/main/theming/PRO-dark-XFCE-4.14.tar.xz
mkdir .themes
tar -xf PRO-dark-XFCE-4.14.tar.xz -C ~/.themes
mkdir -p ~/.config/gtk-3.0
wget -P ~./config/gtk-3.0/ https://raw.githubusercontent.com/roman-romanenko/setup/main/theming/gtk.css 

echo "Done"
