#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <tgl/tgl.h>

static void on_message(struct tgl_state *TLS, struct tgl_message *M) {
    if (M->message) {
        printf("Message: %s\n", M->message);
    }
}

int main(int argc, char **argv) {
    struct tgl_state *TLS = tgl_state_alloc();
    if (!TLS) {
        fprintf(stderr, "Failed to allocate tgl state\n");
        return 1;
    }

    if (tgl_state_init(TLS, "config", NULL) < 0) {
        fprintf(stderr, "Failed to initialize tgl state\n");
        return 1;
    }

    tgl_set_message_handler(TLS, on_message);

    if (tgl_connect(TLS) < 0) {
        fprintf(stderr, "Failed to connect to Telegram\n");
        return 1;
    }

    // Replace 'username_or_chat_id' with the target chat username or ID
    tgl_do_get_difference(TLS, "username_or_chat_id", NULL);

    tgl_loop(TLS, 0);
    tgl_state_free(TLS);

    return 0;
}
