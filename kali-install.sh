#!/bin/bash

echo "[+] Updating system..."
sudo apt update && sudo apt upgrade -y

echo "[+] Installing basic packages..."
sudo apt install -y git python3 python3-pip curl wget nano

echo "[+] Installing recon tools..."
sudo apt install -y nmap whois dnsutils

echo "[+] Installing Python dependencies..."
pip3 install --upgrade pip
pip3 install -r requirements.txt

echo "[+] Installing dirsearch..."
if [ ! -d "dirsearch" ]; then
    git clone https://github.com/maurosoria/dirsearch.git
    cd dirsearch
    pip3 install -r requirements.txt
    cd ..
else
    echo "[✓] Dirsearch already installed"
fi

echo "[+] Installing subfinder..."
if ! command -v subfinder &> /dev/null; then
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
fi

echo "[+] Fixing PATH..."
echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc

echo "[✓] Installation Completed!"