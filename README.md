# webauto_recon
Auto Recon Tool is a lightweight Bash-based reconnaissance tool for ethical hacking. It includes subdomain scanning, port scanning, WHOIS lookup, directory brute-forcing, and a Smart Recon mode that automates target analysis. Fast, simple, and powerful for security testing and learning.
## Installation

### Termux
./install.sh
pip install -r requirement.txt
### Kali Linux
./install_kali.sh
pip install -r requirement.txt
##  Features

###  Comprehensive Reconnaissance
- Perform complete target reconnaissance from a single tool
- Combines multiple techniques into one streamlined workflow

###  Smart Recon Mode
- Automated intelligence-driven scanning
- Detects live hosts, resolves IPs, and prioritizes useful data
- Reduces noise and highlights important findings

### 🌐 Subdomain Enumeration
- Discover subdomains using advanced enumeration techniques
- Supports integration with Subfinder for accurate results

### ⚡ Fast Port Scanning
- Identify open ports and running services using Nmap
- Includes both detailed and fast scan modes

### 📄 WHOIS Intelligence
- Gather domain registration and ownership details
- Useful for footprinting and information gathering

### 📁 Directory Discovery
- Find hidden directories and endpoints
- Integrated with Dirsearch for effective brute-forcing

### 🔥 Full Recon Automation
- Execute all modules in a single command
- Saves time during reconnaissance phase

### Interactive CLI Interface
- Clean, colorful, and user-friendly terminal interface
- Easy navigation with menu-driven system

###  Organized Output
- Automatically saves results into structured output files
- Easy to review and reuse data

### ⚙️ Auto Dependency Handling
- Automatically installs required tools like Dirsearch
- Reduces setup complexity

### 🐧 Cross-Platform Support
- Works on Termux (Android) and Kali Linux
- Lightweight and portable

### 🔐 Ethical Hacking Focus
- Designed for penetration testing and learning## ⚙️ Installation & ▶️ Usage

### 📥 Clone the Repository

```bash
git clone https://github.com/wray-bot/webauto_recon.git
cd webauto_recon
- Encourages responsible and authorized usage
Installation
🔰 For Termux (Android)
chmod +x install.sh auto_recon.sh
./install.sh
🐧 For Kali Linux
chmod +x install_kali.sh auto_recon.sh
./install_kali.sh
🚀 Run the Tool
./auto_recon.sh
🎯 Select Target

Enter the target domain when prompted:

example.com
🛠️ Available Options
Option	Description
1	Subdomain Enumeration
2	Port Scanning
3	WHOIS Lookup
4	Directory Discovery
5	Full Recon
6	Smart Recon (Auto Mode 🧠)
0	Exit
🧠 Smart Recon Mode

Automatically performs:

Live host detection
IP resolution
Fast port scanning
HTTP header extraction
Subdomain discovery
Directory enumeration
📂 Output

All results are saved in the output/ folder:

subdomains.txt
ports.txt
whois.txt
dirs.txt
smart_* results
⚡ Quick Example
./auto_recon.sh
# Enter target → example.com
# Choose option → 6 (Smart Recon)
⚠️ Disclaimer

Use this tool only on authorized targets.
This project is for educational and ethical hacking purposes only.
