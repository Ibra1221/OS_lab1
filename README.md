# Antivirus Assignment
This is a README file for explaining my solution to the anitvirus assignment


## Overview

The uploaded folder consists of the following structure:
```bash
.
├── antivirusd.sh
├── Makefile
├── malicious_dir
├── my_dir
├── README.md
└── restore.sh

3 directories, 4 files
```
- `antivirusd.sh`: The script that scans and deals with files suspected to be malicious.
- `restore.sh`: The script that grants the user access to permanently delete files in  `malicious_dir`, or restore them to `my_dir`.
- `Makefile`: The make file ensuring the malicious_directory exists, and gives initial parameters to run the other 2 scripts as recipes
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