# Antivirus Assignment
This is a README file for explaining my solution to the anitvirus assignment


## Overview

The uploaded folder consists of the following structure:
```bash
.
├── antivirus-cron.sh
├── antivirusd.sh
├── antivirus.log
├── Makefile
├── malicious_dir
├── my_dir
├── README.md
├── restore.sh
└── whitelist.txt

3 directories, 7 files
```
- `antivirusd.sh`: The script that scans and deals with files suspected to be malicious.  
- `restore.sh`: The script that grants the user access to permanently delete files in  `malicious_dir`, or restore them to `my_dir`.  
- `Makefile`: The make file ensuring the malicious_directory exists, and gives initial parameters to run the other 2 scripts as recipes.  
- `whitelist.txt`: Text file storing all whitelisted files.  
- `antivirus.log`: Log file storing the output of the cron job for visualization.
- `my_dir`: The directory containing the files getting scanned.
- `malicious_dir`: The directory acting as the recycle bin in this process.

## Prerequisites
I used **VS Code** as my IDE in this assignment. The only other thing that may need installment is the `make` program. Here's how to ideallyy install both:
```bash
sudo apt update
sudo apt install code
sudo apt install make
```

## Instructions
1- Use the `chmod` command to make both script files executable  
2- Run `make` to create a folder to keep malicious files  
3- Run `antivirusd.sh` with the necessary arguments. For example:
```bash
/antivirusd.sh my_dir malicious_dir 3
```
4- Run `restore.sh` with the necessary arguments and follow the choices presented during execution. For example:
```bash
./restore.sh my_dir malicious_dir 
```

## Note
The required flagged-extensions and flagged-keywords lists are defined at the beginning of the `antivirusd.sh` file.

## Bonus 1: Cron Job

### Instructions
1- Add your command in the `crontab -e`  
2- Adjust the time using the asterisks at the beginning, and the `sleep` command for precise seconds.
3- It is recommended to redirect the script's output to a log file so that you can view the output  

### Prerequisites
- You may need to add your user to the `/etc/cron.allow` file.  
- You may also need to add to activate the cron service using the following command:
```bash
sudo systemctl start cron.service
```
You can check if you need this by running the following command and checking if the status is active or not:  
```bash
sudo systemctl status cron.service
```

### What the cron expression should be to run this scan every 3rd Friday of the month at 12:31 am?
It would be 
```bash
31 0 15-21 * * [ "$(date +\%u)" = 5 ] && /home/ibrahim/college/OS/lab1/antivirus-cron.sh /home/ibrahim/college/OS/lab1/my_dir /home/ibrahim/college/OS/lab1/malicious_dir >> /home/ibrahim/college/OS/lab1/antivirus.log
```

## Bonus 2: Whitelist
### How the file gets added to the whitelist?
As soon as the file is restored, it is added to the `whitelist.txt`. The daemon checks at the start of the file reading loop whether the file is in the text file or not using the `grep` command. If yes, it skips this file entirely.