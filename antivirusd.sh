#! /usr/bin/bash
echo "Hello World"

directory=$1
malicious_directory=$2
interval=$3

extensions="exe bat vbs scr ps1"
content="virus trojan malware worm ransomware"

if [[ -f "directory-info.last"  ]]
then
if ! cd "$directory"; then
    echo "Error: cannot access directory '$directory'"
    exit 1
fi
   for file in *;do
   [[ -f "$file" ]] || continue
   suspicious=false
   echo "${file#*.}"
   for ext in $extensions; do
            if [[ "${file##*.}" == "$ext" ]]; then
            echo "here"
                suspicious=true
                break
            fi
        done
    if [[ $suspicious ]]
    then
    echo "$file is malicious and it is DELETED"
   cp $file ../$malicious_directory
   rm $file
   suspicious=false
    continue
    else
    for word in $content
    do
    if   grep -qi -- "$word" "$file"
    then
    echo "$file is malicious and it is DELETED"
   cp $file ../$malicious_directory
   rm $file

   break
    else
        continue
    fi
    done
    fi
    
    done
else 
ls -l "$directory" > directory-info.last
fi
cd ..

while true ; do

    sleep $interval
   ls -l $directory > directory-info.new
   if diff directory-info.last directory-info.new 
   then
   continue
   else
   if ! cd "$directory"; then
    echo "Error: cannot access directory '$directory'"
    exit 1
fi
   for file in *;do
   [[ -f "$file" ]] || continue
   suspicious=false
   echo "${file##*.}"
   for ext in $extensions; do
            if [[ "${file##*.}" == "$ext" ]]; then
                suspicious=true
                break
            fi
        done
    if [[ $suspicious ]]
    then
    echo "$file is malicious and it is DELETED"
   cp $file ../$malicious_directory
   rm $file
   suspicious=false
    continue
    else
    for word in $content
    do
    if   grep -qi -- "$word" "$file"
    then
    echo "$file is malicious and it is DELETED"
   cp $file ../$malicious_directory
   rm $file
   break
    fi
    done
    fi
    
    done
   fi
   echo "Writing"
   cd ..
   cp directory-info.new directory-info.last 
done
