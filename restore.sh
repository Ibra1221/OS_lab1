#! /usr/bin/bash

directory=$1
malicious_directory=$2

echo "Pick a file by number"

files=()
for path in "$malicious_directory"/*; do
    [[ -f "$path" ]] || continue
    files+=("$path")
done

if (( ${#files[@]} == 0 )); then
    echo "No malicious files to review."
    exit 0
fi

while true
do
echo "Files in malicious directory:"
i=0
for path in "$malicious_directory"/*; do
    [[ -f "$path" ]] || continue
    printf '%d. %s\t' "$(($i+1))" "${path##*/}"
    ((i++))
done
read choice

if [[ ! "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > i )); then
    echo "Invalid choice."
    exit 1
fi

selected="${files[$((choice - 1))]}"

echo "Pick an option:"

echo "1.Restore this file back into $directory"
echo "2.Delete this file from $malicious_directory"
echo "3.Go back to the list"

read option

if [[ ! "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > 3 )); then
    echo "Invalid choice."
    exit 1
fi

case $((option)) in
    1)
    mv "$selected" "$directory"
    echo "Restored $selected to $directory."
    break
    ;;
    
    2)
    rm "$selected" 
    echo "$selected permanently deleted"
    break
    ;;
    
    3)
    continue
    ;;
    *)
    ;;
esac
done
