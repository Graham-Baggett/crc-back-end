#!/bin/bash
REPO_DIR="./crc-front-end"
HTML_DIR="/var/www/html"

echo "Setting up the Cloud Resume Challenge website..."
echo "Installing httpd..."
sudo dnf install httpd
echo "Installing python3..."
sudo dnf install python3
echo "Installing python's oracledb library..."
sudo dnf install python3-oracledb
echo "Starting httpd..."
sudo systemctl start httpd
echo "Enabling httpd..."
sudo systemctl enable httpd
echo "Installing snapd..."
sudo dnf install snapd
echo "Enabling snap communication socket..."
sudo systemctl enable --now snapd.socket
echo "Establishing snapd symbolic link..."
sudo ln -s /var/lib/snapd/snap /snap
echo "Installing snap core..."
sudo snap install core
echo "Installing certbot..."
sudo snap install --classic certbot
echo "Establishing a certbot symbolic link..."
sudo ln -s /snap/bin/certbot /usr/bin/certbot
echo "Installing mod_ssl..."
sudo dnf install mod_ssl
echo "Installing mod_proxy..."
sudo dnf install mod_proxy
echo "Generating and installing certificate..."
sudo certbot --apache

if [ ! -d "$REPO_DIR" ]; then
        echo "Cloning the crc-front-end repo..."
        git clone https://github.com/Graham-Baggett/crc-front-end.git
fi
#set AllowOrverride to All in /etc/httpd/conf/httpd.conf
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --permanent --add-port=8443/tcp
sudo firewall-cmd --add-service=https --permanent
sudo firewall-cmd --reload
cd /home/opc/crc-front-end
git checkout oci

if [ ! -d "HTML_DIR" ]; then
        echo "Creating HTML directory..."
        sudo mkdir "HTML_DIR"
fi

sudo cp /home/opc/crc-front-end/html/*.html "HTML_DIR"
sudo cp /home/opc/crc-front-end/css/*.css "$HTML_DIR"/css
sudo cp /home/opc/crc-front-end/js/*.js "$HTML_DIR"/js
sudo cp /home/opc/crc-front-end/img/* "$HTML_DIR"/img