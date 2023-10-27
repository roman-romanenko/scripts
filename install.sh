mkdir installer
cd installer

echo "Create No Password Sudo =========================================================================================="
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers

echo "Disable Cloud Init"
sudo touch /etc/cloud/cloud-init.disabled

echo "Install Needed Software =========================================================================================="
sudo apt update
sudo apt upgrade -y
sudo apt install xrdp xubuntu-core software-properties-common apt-transport-https curl wget engrampa ca-certificates gnupg copyq flameshot ristretto -y
sudo apt remove xfce4-screensaver xfce4-power-manager -y

echo "Configure XRDP ==================================================================================================="
echo xfce4-session > ~/.xsession
sudo wget /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla https://raw.githubusercontent.com/xa2099/setup/main/config/45-allow-colord.pkla

echo "Configure Theaming ==============================================================================================="
wget https://github.com/xa2099/setup/raw/main/theming/Tela-circle.tar.xz
sudo tar -xf Tela-circle.tar.xz -C /usr/share/icons
wget https://github.com/xa2099/setup/raw/main/theming/Nordic-darker.tar.xz
sudo tar -xf Nordic-darker.tar.xz -C /usr/share/themes
sudo wget /usr/share/backgrounds https://raw.githubusercontent.com/xa2099/setup/main/theming/Nord-wallpaper.jpg
xfconf-query -c xfce4-desktop -p $(xfconf-query -c xfce4-desktop -l | grep "workspace0/last-image")  -s /usr/share/backgrounds/Nord-wallpaper.jpg
mkdir -p ~/.config/gtk-3.0
wget -P ~/.config/gtk-3.0/ https://raw.githubusercontent.com/xa2099/setup/main/theming/gtk.css
wget https://github.com/xa2099/setup/raw/main/theming/fonts.zip
sudo mkdir /usr/share/fonts/Microsoft
sudo unzip fonts.zip -d /usr/share/fonts/Microsoft
xfconf-query -c xsettings -p /Net/ThemeName -s "Nordic-darker"
xfconf-query -c xfwm4 -p /general/theme -s  "Nordic-darker"
xfconf-query -c xsettings -p /Net/IconThemeName -s "Tela-circle-dark"
xfconf-query -c xfce4-panel -np /panels/panel-1/position -t string -s 'p=8;x=1000;y=1000'
xfconf-query -c xfce4-panel -np /panels/panel-1/size -t string -s 40
xfconf-query -c xfce4-panel -np /panels/panel-1/icon-size -t string -s 38
xfconf-query -c xfce4-panel -p /panels -t int -s 1 -a

echo "Install Docker ==================================================================================================="
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$UBUNTU_CODENAME")" stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo usermod -aG docker $USER
docker --version

echo "Install VSCode ==================================================================================================="
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update 
sudo apt install code -y

echo "Install Chrome ==================================================================================================="
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmour -o /usr/share/keyrings/chrome-keyring.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'
sudo apt update
sudo apt install google-chrome-stable -y

echo "Install Edge ====================================================================================================="
curl -fSsL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/microsoft-edge.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main' | sudo tee /etc/apt/sources.list.d/microsoft-edge.list
sudo apt update
sudo apt install microsoft-edge-stable

echo "Install Tabby ===================================================================================================="
wget https://packagecloud.io/install/repositories/eugeny/tabby/script.deb.sh
sudo script.deb.sh
sudo apt update 
sudo apt install tabby-terminal -y

echo "Install VPN ======================================================================================================"
wget https://vpn.nic.in/resources/software/anyconnect-linux64-4.10.01075-k9.tar.gz
tar -xf anyconnect-linux64-4.10.01075-k9.tar.gz
sudo ./anyconnect-linux64-4.10.01075/vpn/vpn_install.sh

echo "Remove installation files ========================================================================================"
cd ..
rm -rf installer

echo "Done ============================================================================================================="
