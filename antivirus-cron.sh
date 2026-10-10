#! /usr/bin/bash
# echo "Hello World"

base=/home/ibrahim/college/OS/lab1
directory=$1
malicious_directory=$2
whitelist=$base/whitelist.txt
last=$base/directory-info.last
new=$base/directory-info.new

extensions="exe bat vbs scr ps1"
content="virus trojan malware worm ransomware"

if [[ -f "$last" ]]
then
if ! cd "$directory"; then
    echo "Error: cannot access directory '$directory'"
    exit 1
fi
   for file in *;do
   [[ -f "$file" ]] || continue
   if grep -qxF -- "$file" "$whitelist" 2>/dev/null; then
    echo "$file is in the whitelist" 
        continue
    fi
   suspicious=false
   echo "${file#*.}"
   for ext in $extensions; do
            if [[ "${file##*.}" == "$ext" ]]; then
            echo "here"
                suspicious=true
                break
            fi
        done
    if [[ $suspicious == true ]]
    then
    echo "$file is malicious and it is DELETED"
   cp "$file" "$malicious_directory"
   rm "$file"
   suspicious=false
    continue
    else
    for word in $content
    do
    if   grep -qi -- "$word" "$file"
    then
    echo "$file is malicious and it is DELETED"
   cp "$file" "$malicious_directory"
   rm "$file"
   break
    else
        continue
    fi
    done
    fi

    done
else
ls -l "$directory" > "$last"
fi

   ls -l "$directory" > "$new"
   if diff -q "$last" "$new"
   then
   :
   else
   if ! cd "$directory"; then
    echo "Error: cannot access directory '$directory'"
    exit 1
fi
   for file in *;do
   [[ -f "$file" ]] || continue
   if grep -qxF -- "$file" "$whitelist" 2>/dev/null; then
        continue
    fi
   suspicious=false
   echo "${file##*.}"
   for ext in $extensions; do
            if [[ "${file##*.}" == "$ext" ]]; then
                suspicious=true
                break
            fi
        done
    if [[ $suspicious == true ]]
    then
    echo "$file is malicious and it is DELETED"
   cp "$file" "$malicious_directory"
   rm "$file"
   suspicious=false
    continue
    else
    for word in $content
    do
    if   grep -qi -- "$word" "$file"
    then
    echo "$file is malicious and it is DELETED"
   cp "$file" "$malicious_directory"
   rm "$file"
   break
    fi
    done
    fi

    done
   fi
#    echo "Writing"
   cp "$new" "$last"