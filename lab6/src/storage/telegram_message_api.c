#include "storage/telegram_message_api.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "storage/telegram_storage.h"

const char* tel_type_to_string(enum tel_type type) {
    switch (type) {
        case TEL_DIRECTORY:
            return "directory";
        case TEL_FILE:
            return "file";
        default:
            return "uknown";
    }
}

void create_file(struct tel_file* file) {
    long message_size = strlen("TYPE: \nNAME: \nTAGS: ") +
                        strlen(tel_type_to_string(file->type)) +
                        strlen(file->name) + strlen(file->tags) + 1;

    char* message_to_send = malloc(message_size);

    snprintf(message_to_send, message_size, "TYPE: %s\nNAME: %s\nTAGS: %s",
             tel_type_to_string(file->type), file->name, file->tags);

    send_telegramm_message(file->content, message_to_send);

    free(message_to_send);
}
