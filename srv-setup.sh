echo "Disable Cloud Init"
sudo touch /etc/cloud/cloud-init.disabled

echo "Create No Password Sudo"
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers

echo "Install Needed Software"
sudo apt update
sudo apt upgrade -y
sudo apt install -y software-properties-common apt-transport-https wget

echo "Install Docker and Docker-compose"
sudo apt-get install -y curl apt-transport-https ca-certificates software-properties-common 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" 
sudo apt update 
sudo apt install -y docker-ce
sudo usermod -aG docker $USER 
sudo chmod 666 /var/run/docker.sock
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose 
sudo chmod +x /usr/local/bin/docker-compose
docker --version
docker-compose --version

echo "Done..."
