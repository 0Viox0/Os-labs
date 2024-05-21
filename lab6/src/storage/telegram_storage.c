#include "storage/telegram_storage.h"

#include <curl/curl.h>
#include <stdio.h>
#include <string.h>

void send_telegramm_message(const char* fileContent, const char* message) {
    const char* botToken = "6700495086:AAHnG5E_ipv9ze_hvIf6jVKXnTyT89kGlKM";
    const char* chatId = "-4270879671";

    CURL* curl;
    CURLcode res;
    struct curl_httppost* post = NULL;
    struct curl_httppost* last = NULL;

    curl_global_init(CURL_GLOBAL_ALL);
    curl = curl_easy_init();

    if (curl) {
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, discard_response);

        curl_formadd(&post, &last, CURLFORM_COPYNAME, "chat_id",
                     CURLFORM_COPYCONTENTS, chatId, CURLFORM_END);
        curl_formadd(
            &post, &last, CURLFORM_COPYNAME, "document", CURLFORM_BUFFER,
            "file.txt",                       // File name for the uploaded file
            CURLFORM_BUFFERPTR, fileContent,  // Pointer to the file content
            CURLFORM_BUFFERLENGTH,
            strlen(fileContent),  // Size of the file content
            CURLFORM_END);
        curl_formadd(&post, &last, CURLFORM_COPYNAME, "caption",
                     CURLFORM_COPYCONTENTS, message, CURLFORM_END);

        char url[1000];
        snprintf(url, sizeof(url),
                 "https://api.telegram.org/bot%s/sendDocument", botToken);

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
