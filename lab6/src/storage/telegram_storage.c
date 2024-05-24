#include "storage/telegram_storage.h"

#include <curl/curl.h>
#include <stdio.h>
#include <string.h>
#include <td/telegram/td_json_client.h>

void send_telegramm_message(const char* file_content, const char* message,
                            const char* file_name) {
    const char* bot_token = "6700495086:AAHnG5E_ipv9ze_hvIf6jVKXnTyT89kGlKM";
    const char* chat_id = "5273950270";

    CURL* curl;
    CURLcode res;
    struct curl_httppost* post = NULL;
    struct curl_httppost* last = NULL;

    curl_global_init(CURL_GLOBAL_ALL);
    curl = curl_easy_init();

    if (curl) {
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, discard_response);

        curl_formadd(&post, &last, CURLFORM_COPYNAME, "chat_id",
                     CURLFORM_COPYCONTENTS, chat_id, CURLFORM_END);

        if (file_content != NULL) {
            curl_formadd(&post, &last, CURLFORM_COPYNAME, "document",
                         CURLFORM_BUFFER, file_name, CURLFORM_BUFFERPTR,
                         file_content, CURLFORM_BUFFERLENGTH,
                         strlen(file_content), CURLFORM_END);

            curl_formadd(&post, &last, CURLFORM_COPYNAME, "caption",
                         CURLFORM_COPYCONTENTS, message, CURLFORM_END);
        } else {
            curl_formadd(&post, &last, CURLFORM_COPYNAME, "text",
                         CURLFORM_COPYCONTENTS, message, CURLFORM_END);
        }

        char url[500];
        snprintf(url, sizeof(url), "https://api.telegram.org/bot%s/send%s",
                 bot_token, file_content ? "Document" : "Message");

        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_HTTPPOST, post);

        res = curl_easy_perform(curl);

        if (res != CURLE_OK)
            fprintf(stderr, "curl_easy_perform() failed: %s\n",
                    curl_easy_strerror(res));

        curl_easy_cleanup(curl);
        curl_formfree(post);
    }

    curl_global_cleanup();
}

size_t discard_response(void* ptr, size_t size, size_t nmemb, void* userdata) {
    return size * nmemb;
}
