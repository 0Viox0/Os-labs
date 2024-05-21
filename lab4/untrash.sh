#!/bin/bash

if [ $# -ne 1 ]; then
    echo "the proper usage: $0 <filename>"
    exit 1
fi

filename="$1"

trash_log="$HOME/.trash.log"
if [ ! -f "$trash_log" ]; then
    echo "trash log file '$trash_log' doesn't exist"
    exit 1
fi

matches=$(grep -E '.*/'"$filename"' ' "$trash_log") 

if [ -z "$matches" ]; then
    echo "no matching records found in trash log for file '$filename'."
    exit 1
fi

echo "Found matching records for file '$filename':"
while IFS= read -r line; do
    echo "File: $(echo "$line" | awk '{print $1}')"
    read -p "Do you want to recover this file? (yes/no): " choice <&3

    case "$choice" in
        yes)
            file_path=$(echo "$line" | cut -d' ' -f1)
            file_name=$(echo "$line" | cut -d' ' -f2)

            if [ -d "$(dirname "$file_path")" ]; then
                if ln "$HOME/.trash/$file_name" "$file_path" 2>/dev/null; then
                    echo "File '$filename' successfully restored to '$file_path'."
                    rm "$HOME/.trash/$file_name"
                    sed -i "/ $file_name\$/d" "$trash_log"
                else
                    read -p "Do you want to rename the file before restoring? (yes/no): " rename_choice <&3

                    case "$rename_choice" in
                        yes)
                            read -p "Enter new filename: " new_filename <&3
                            if ln "$HOME/.trash/$file_name" "$(dirname "$file_path")/$new_filename" 2>/dev/null; then
                                echo "File '$new_filename' successfully restored as '$new_filename' in directory '$(dirname "$file_path")'."

                                rm "$HOME/.trash/$file_name"
                                sed -i "/ $file_name\$/d" "$trash_log"
                            else
                                echo "Failed to create a hard link for file '$file_name' with the new filename."
                                echo "File '$file_name' could not be restored."
                            fi
                            ;;
                        *)
                            echo "File '$file_name' could not be restored."
                            ;;
                    esac
                fi
            else
                echo "Directory '$(dirname "$file_path")' does not exist."
                echo "File '$file_name' will be restored to the home directory."

                if ln "$HOME/.trash/$file_name" "$HOME/$file_name" 2>/dev/null; then
                    echo "File '$filename' successfully restored to '$HOME'."
                    rm "$HOME/.trash/$file_name"
                    sed -i "/ $file_name\$/d" "$trash_log"
                else
                    echo "Failed to create a hard link for file '$file_name' in the home directory."
                    echo "File '$file_name' could not be restored."
                fi
            fi
            ;;
        *)
            echo "File '$filename' will not be recovered."
            ;;
    esac
done 3<&0 <<< "$matches"
