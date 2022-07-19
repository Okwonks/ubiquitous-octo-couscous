#!/bin/bash -eu
# Setup a logging funcion to simplify stdout using "echo"
log() {
  echo "[startup-script] $*"
}

PROJECT_ID=$(curl -s "http://metadata.google.internal/computeMetadata/v1/project/project-id" -H "Metadata-Flavor: Google")

log "Creating bamboo instance in $PROJECT_ID ..."

log "Setting up depenencies .."

# Install missing packages
sudo apt-get install -y software-properties-common

log "Installing wget ..."
sudo apt-get update -y
sudo apt-get install -y wget

log "Installing Java ..."
# Update debian reference to be able to download java version 8
# jdk-8 is not available from apg-get in debian 10 (buster)
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/

# Install Java as required for Bamboo
sudo apt-get update -y
sudo apt-get install -y adoptopenjdk-8-hotspot

log "Java installed"

log "Setting up Bamboo ..."
# Switch /opt directory
cd /opt

# Download the latest version of Bamboo
log "Fetching Bamboo v8.1.8 archive ..."
sudo wget https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-8.1.8.tar.gz

log "Unzipping archive ..."
sudo tar -xf /opt/atlassian-bamboo-8.1.8.tar.gz
sudo mv atlassian-bamboo-8.1.8 bamboo

log "Setting Bamboo home directory ..."
sudo mkdir /opt/bamboofiles
echo "bamboo.home=/opt/bamboofiles" | sudo tee --append /opt/bamboo/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties > /dev/null

log "Creating Bamboo user ..."
sudo /usr/sbin/useradd --create-home --home-dir /usr/local/bamboo --shell /bin/bash bamboo

# Gives the Bamboo user permissions to the two directories
sudo chown -R bamboo: /opt/bamboo
sudo chown -R bamboo: /opt/bamboofiles

log "Starting Bamboo ..."
sudo -H -u bamboo /opt/bamboo/bin/start-bamboo.sh

echo ""
echo "==================================="
echo "Bamboo started successfully!"
echo "Running at http://$(curl ifconfig.me):8085"
echo "==================================="
echo ""

log "Done"
