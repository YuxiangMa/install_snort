#!/bin/bash

# Snort Installation, Configuration, and Rule Download Script

# Install Snort
sudo apt update
sudo apt install -y snort

# Copy Snort Configuration File
sudo cp /etc/snort/snort.conf /etc/snort/snort.local.conf

# Configure Snort Output in snort.local.conf if not present
if ! sudo grep -q 'output unified2: filename snort.log, limit 128' /etc/snort/snort.local.conf; then
    echo 'output unified2: filename snort.log, limit 128' | sudo tee -a /etc/snort/snort.local.conf
fi

# Download Rule Set
sudo apt install -y snort-rules-default

# Inform the user about completion
echo "Snort installation and configuration completed successfully."

# Restart Snort to apply new configuration
sudo service snort restart
echo "Snort has been restarted to apply the new configuration."

# Download additional rule sets
echo "Downloading additional rule sets..."
mkdir ~/Downloads
cd ~/Downloads

wget https://www.snort.org/downloads/community/community-rules.tar.gz
tar -xzvf community-rules.tar.gz
sudo cp -r community-rules/* /etc/snort/rules/
sudo systemctl restart snort

wget https://www.snort.org/downloads/community/snort3-community-rules.tar.gz
tar -xzvf snort3-community-rules.tar.gz
sudo cp -r snort3-community-rules/* /etc/snort/rules/
sudo systemctl restart snort

echo "Additional rule sets downloaded and applied."

# Check Snort Status
# sudo systemctl status snort

# Enable Snort to start on boot
sudo systemctl enable snort
sudo systemctl is-enabled snort

# Display completion message
echo "Execution complete. Snort is ready for use."
echo  # Empty line 1
echo  # Empty line 2