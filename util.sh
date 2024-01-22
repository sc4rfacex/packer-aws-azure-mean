#Update packages
sudo apt-get update

# Install NodejS
curl -sL https://deb.nodesource.com/setup_20.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs -y
sudo apt install build-essential -y

# Install Build essentials packages
sudo apt install build-essential

# Install NGINX
sudo apt-get install nginx -y

# Enabled Nginx service
sudo systemctl enable nginx
sudo systemctl start nginx

# Install PM2
sudo npm install pm2@latest -g

# Echo versions of packages
echo "Node version: $(node -v)"
echo "NPM version: $(npm -v)"
echo "PM2 version: $(pm2 -v)"
echo "NGINX version: $(nginx -v)"

# Run application in the background
pm2 start ./app/hello.js

# Obtain startup command
STARTUP_CMD=$(pm2 startup | grep 'sudo' | sed -e 's/.*\[sudo\] //')

# Execute startup pm2 command
eval $STARTUP_CMD

# Save current pm2 state
pm2 save

# Generate reverse proxy configuration with nginx
cat <<EOF | sudo tee /etc/nginx/sites-available/default
server {
    listen 80;
    server_name _;
    location / {
        proxy_pass http://localhost:3000/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF


# Restart nginx
sudo systemctl restart nginx
