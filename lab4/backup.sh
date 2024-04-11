#!/bin/bash

user_home="/home/viox/"
source_dir="${user_home}/source"
backup_base_dir="${user_home}"
backup_report="${user_home}/backup-report"
current_date=$(date '+%Y-%m-%d')
backup_dir_name="Backup-${current_date}"
backup_dir="${backup_base_dir}/${backup_dir_name}"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "${backup_report}"
}

if [ ! -d "$source_dir" ]; then
    log_message "Error: The source directory does not exist: $source_dir"
    exit 1
fi

should_create_new_backup=true

for dir in ${backup_base_dir}/Backup-*; do

    if [[ -d "${dir}" ]]; then
        backup_date=$(basename "$dir" | cut -d'-' -f2-)
        date_diff=$(( ($(date -d "${current_date}" '+%s') - $(date -d "${backup_date}" '+%s')) / 86400 ))

        if [[ ${date_diff} -le 7 ]]; then
            backup_dir="${dir}"
            should_create_new_backup=false
            break
        fi
    fi
done

if $should_create_new_backup; then

    mkdir -p "${backup_dir}" || {
        log_message "Error: Failed to create backup directory ${backup_dir}."
        exit 1
    }

    log_message "Created a new backup directory: ${backup_dir_name}"

    cp -r "${source_dir}/." "${backup_dir}/" 2>&1 | while read line; do log_message "$line"; done

    for file in "${source_dir}"/*; do
        if [[ -f "${file}" ]]; then
            filename=$(basename "${file}")
            log_message "Copied ${filename} to ${backup_dir_name}"
        fi
    done
else
    log_message "Updating existing backup directory: $(basename "${backup_dir}")"

    for source_file in "${source_dir}"/*; do

        if [[ -f "${source_file}" ]]; then
            filename=$(basename "${source_file}")
            destination_file="${backup_dir}/${filename}"

            if [[ ! -f "${destination_file}" ]]; then
                cp "${source_file}" "${destination_file}"
                log_message "Added ${filename}"
            else
                source_size=$(stat -c%s "${source_file}")
                destination_size=$(stat -c%s "${destination_file}")

                if [[ "${source_size}" -ne "${destination_size}" ]]; then

                    backup_versioned_file="${destination_file}.${current_date}"
                    mv "${destination_file}" "${backup_versioned_file}"

                    cp "${source_file}" "${destination_file}"
                    log_message "Updated ${filename}, old version renamed to ${filename}.${current_date}"
                fi
            fi
        fi
    done
fi
