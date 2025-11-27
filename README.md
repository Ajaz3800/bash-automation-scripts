# Bash Web Server Automation Script

This project contains a set of Bash scripts that automate the installation, setup, and management of a web server (Apache) on **Ubuntu** and **CentOS** systems.  
It also includes automatic template downloading, file cleanup, and service management (restart/reload).

---

## ✨ Features

- Detects operating system package manager (`apt`, `yum`, or `dnf`)
- Installs Apache on both **Ubuntu/Debian** and **CentOS/RHEL**
- Cleans the `/var/www/html` directory safely
- Downloads website templates using user input
- Supports restart or reload of Apache with validation
- Stops execution immediately if any command fails
- Fully interactive with user prompts

---

## 📂 Project Structure
```
├── install-apache.sh # Installs Apache based on OS
├── setup-code.sh # Cleans web directory and downloads template
├── README.md # Project documentation
```
## 🚀 How to Use

### 1️⃣ Clone the Repository

```
git clone https://github.com/Ajaz3800/bash-automation-scripts.git
cd bash-automation-scripts
```

### 2️⃣ Make Scripts Executable
```
chmod +x *.sh
```

### 3️⃣ Setup Website Code
```
sudo ./setup-code.sh
```

### ⚙️ Requirements
* Linux machine with:
    * Ubuntu / Debian (APT)
    * CentOS / RHEL (YUM/DNF)
* wget
* unzip
* systemd (for service management)

### 📦 Example Template Download
```
https://www.tooplate.com/zip-templates/2108_dashboard.zip
```

### 🛑 Error Handling
* Script exits immediately on any error
* If Apache restart/reload fails, next steps do not run
* OS detection prevents wrong commands from running