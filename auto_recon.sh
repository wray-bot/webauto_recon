#!/bin/bash

# ==============================
# COLORS
# ==============================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
RESET='\033[0m'

# ==============================
# CHECK DEPENDENCIES
# ==============================
check_tools() {
for tool in nmap whois curl; do
    if ! command -v $tool &> /dev/null; then
        echo -e "${RED}[!] $tool is not installed!${RESET}"
    fi
done
}

# ==============================
# AUTO INSTALL DIRSEARCH
# ==============================
install_dirsearch() {
if [ ! -d "dirsearch" ]; then
    echo -e "${YELLOW}[!] Installing dirsearch...${RESET}"
    git clone https://github.com/maurosoria/dirsearch.git
    cd dirsearch
    pip install -r requirements.txt
    cd ..
    echo -e "${GREEN}[✓] Dirsearch installed${RESET}"
fi
}

# ==============================
# LOADING
# ==============================
loading() {
echo -ne "${CYAN}Processing"
for i in {1..5}; do
    echo -ne "."
    sleep 0.2
done
echo -e "${RESET}"
}

# ==============================
# BANNER
# ==============================
banner() {
clear
echo -e "${CYAN}"
echo "========================================="
echo "        AUTO RECON TOOL v4.0"
echo "========================================="
echo -e "${RESET}"
}

# ==============================
# MENU
# ==============================
menu() {
echo -e "${GREEN}1) Subdomain Scan"
echo "2) Port Scan"
echo "3) WHOIS Lookup"
echo "4) Directory Scan"
echo "5) Full Recon"
echo "6) Smart Recon (Auto Mode )"
echo "0) Exit${RESET}"
}

# ==============================
# INPUT
# ==============================
read_target() {
echo -ne "${YELLOW}Enter Target (example.com): ${RESET}"
read target

if [[ -z "$target" ]]; then
    echo -e "${RED}Target cannot be empty!${RESET}"
    return 1
fi

mkdir -p output
}

# ==============================
# MODULES
# ==============================

subdomain_scan() {
echo -e "${BLUE}[+] Subdomain Scan${RESET}"
loading

if command -v subfinder &> /dev/null; then
    subfinder -d $target -o output/subdomains.txt
    echo -e "${GREEN}[✓] Saved: output/subdomains.txt${RESET}"
    cat output/subdomains.txt
else
    echo -e "${RED}[!] subfinder not installed${RESET}"
fi
}

port_scan() {
echo -e "${BLUE}[+] Port Scan${RESET}"
loading

nmap -sV $target -oN output/ports.txt

echo -e "${GREEN}[✓] Saved: output/ports.txt${RESET}"
echo -e "${YELLOW}--- RESULT ---${RESET}"
cat output/ports.txt
}

whois_lookup() {
echo -e "${BLUE}[+] WHOIS Lookup${RESET}"
loading

whois $target > output/whois.txt

echo -e "${GREEN}[✓] Saved: output/whois.txt${RESET}"
echo -e "${YELLOW}--- RESULT ---${RESET}"
cat output/whois.txt
}

dir_scan() {
echo -e "${BLUE}[+] Directory Scan${RESET}"
loading

install_dirsearch

python3 dirsearch/dirsearch.py -u http://$target -o output/dirs.txt

echo -e "${GREEN}[✓] Saved: output/dirs.txt${RESET}"
cat output/dirs.txt
}

# ==============================
# 🧠 SMART RECON MODULE
# ==============================
smart_recon() {
echo -e "${PURPLE}[🧠] Smart Recon Started...${RESET}"

install_dirsearch

# Check alive
echo -e "${BLUE}[+] Checking target...${RESET}"
ping -c 1 $target > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[✓] Target is alive${RESET}"
else
    echo -e "${YELLOW}[!] Ping blocked or host down${RESET}"
fi

# Resolve IP
echo -e "${BLUE}[+] Resolving IP...${RESET}"
ip=$(getent hosts $target | awk '{print $1}')
echo -e "${GREEN}[✓] IP: $ip${RESET}"

# Subdomain
if command -v subfinder &> /dev/null; then
    echo -e "${BLUE}[+] Subdomains...${RESET}"
    subfinder -d $target -silent > output/subdomains.txt
    echo -e "${GREEN}[✓] Found $(wc -l < output/subdomains.txt) subdomains${RESET}"
fi

# Port scan (fast)
echo -e "${BLUE}[+] Fast Port Scan...${RESET}"
nmap -F $target -oN output/smart_ports.txt > /dev/null

echo -e "${GREEN}[✓] Open Ports:${RESET}"
grep open output/smart_ports.txt

# HTTP headers
echo -e "${BLUE}[+] Server Info...${RESET}"
curl -I http://$target 2>/dev/null | head -5 > output/headers.txt
cat output/headers.txt

# Quick dir scan
echo -e "${BLUE}[+] Quick Directory Scan...${RESET}"
python3 dirsearch/dirsearch.py -u http://$target -e php,html --quiet -o output/smart_dirs.txt

echo -e "${GREEN}[✓] Interesting Paths:${RESET}"
grep "200" output/smart_dirs.txt | head -10

echo -e "${PURPLE}[🔥] Smart Recon Completed${RESET}"
}

full_recon() {
echo -e "${PURPLE}[🔥] Full Recon Started${RESET}"
subdomain_scan
port_scan
whois_lookup
dir_scan
echo -e "${GREEN}[✓] Full Recon Completed${RESET}"
}

# ==============================
# MAIN LOOP
# ==============================
check_tools

while true; do
banner
menu

read_target || continue

echo -ne "${CYAN}Choose option: ${RESET}"
read choice

case $choice in
1) subdomain_scan ;;
2) port_scan ;;
3) whois_lookup ;;
4) dir_scan ;;
5) full_recon ;;
6) smart_recon ;;
0) exit ;;
*) echo -e "${RED}Invalid Option${RESET}" ;;
esac

echo -e "${PURPLE}Press Enter to continue...${RESET}"
read
done
