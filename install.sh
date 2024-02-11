echo "Create No Password Sudo =========================================================================================="
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers

echo "Disable Cloud Init ==============================================================================================="
sudo touch /etc/cloud/cloud-init.disabled

echo "Install Needed Software =========================================================================================="
sudo apt update
sudo apt upgrade -y
sudo apt install -y xrdp xubuntu-core copyq flameshot software-properties-common apt-transport-https wget engrampa firefox

echo "Confitue XRDP Session ==========================================================================================="
echo xfce4-session > ~/.xsession

echo "Deal with Theaming =============================================================================================="
wget https://github.com/xa2099/setup/raw/xfce-setup/theming/Tela-circle.tar.xz
mkdir .icons
sudo tar -xf Tela-circle.tar.xz -C ~/.icons
wget https://github.com/xa2099/setup/raw/xfce-setup/theming/PRO-dark-XFCE-4.14.tar.xz
mkdir .themes
sudo tar -xf PRO-dark-XFCE-4.14.tar.xz -C ~/.themes
mkdir -p ~/.config/gtk-3.0
wget -P ~/.config/gtk-3.0/ https://raw.githubusercontent.com/xa2099/setup/xfce-setup/theming/gtk.css
wget -O ~/.themes/PRO-dark-XFCE-4.14/gtk-3.0/gtk.css https://raw.githubusercontent.com/xa2099/setup/xfce-setup/theming/pro-gtk.css

echo "Insatall Standard Fonts ========================================================================================="
wget https://github.com/xa2099/setup/raw/xfce-setup/theming/fonts.zip
sudo mkdir /usr/share/fonts/Microsoft
sudo unzip fonts.zip -d /usr/share/fonts/Microsoft
rm fonts.zip

echo "Install Docker =================================================================================================="
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$UBUNTU_CODENAME")" stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo usermod -aG docker $USER
docker --version

echo "Install VSCode =================================================================================================="
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update 
sudo apt install code -y

echo "Install Chrome =================================================================================================="
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmour -o /usr/share/keyrings/chrome-keyring.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'
sudo apt update
sudo apt install google-chrome-stable -y

echo "Install Edge ===================================================================================================="
curl -fSsL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/microsoft-edge.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main' | sudo tee /etc/apt/sources.list.d/microsoft-edge.list
sudo apt update
sudo apt install microsoft-edge-stable

echo "Install Tabby ==================================================================================================="
wget https://packagecloud.io/install/repositories/eugeny/tabby/script.deb.sh
sudo bash script.deb.sh
rm script.deb.sh
sudo apt update 
sudo apt install tabby-terminal -y

# echo "Install VPN ====================================================================================================="
# wget https://vpn.nic.in/resources/software/anyconnect-linux64-4.10.01075-k9.tar.gz
# tar -xf anyconnect-linux64-4.10.01075-k9.tar.gz
# rm anyconnect-linux64-4.10.01075-k9.tar.gz
# cd anyconnect-linux64-4.10.01075/vpn
# sudo bash vpn_install.sh

echo ""
echo "Finished..."
echo ""
