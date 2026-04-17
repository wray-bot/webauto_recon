#!/bin/bash

echo "[+] Updating system..."
pkg update && pkg upgrade -y

echo "[+] Installing basic packages..."
pkg install -y git python curl wget nano

echo "[+] Installing recon tools..."
pkg install -y nmap whois dnsutils

echo "[+] Installing Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

echo "[+] Installing dirsearch..."
if [ ! -d "dirsearch" ]; then
    git clone https://github.com/maurosoria/dirsearch.git
    cd dirsearch
    pip install -r requirements.txt
    cd ..
fi

echo "[+] Installing subfinder..."
pkg install -y golang
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

echo "[+] Fixing PATH..."
echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc

echo "[✓] Installation Completed!"
