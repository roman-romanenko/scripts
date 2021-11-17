echo "Disable Cloud Init"

sudo touch /etc/cloud/cloud-init.disabled


sudo apt update
sudo apt upgrade -y

echo "Install Needed Software"

sudo apt install -y xrdp xubuntu-core copyq flameshot software-properties-common apt-transport-https wget

echo xfce4-session > ~/.xsession

echo "Install VSCode"

wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install -y code

echo "Docker and Docker-compose Install"

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

echo "Done"
