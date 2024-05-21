#include "storage/telegram_message_api.h"

int main() {
    struct tel_file file = {.type = TEL_FILE,
                            .name = "my first file",
                            .tags = "directory name: /",
                            .content = "this is some random content"};

    create_file(&file);

    return 0;
}
