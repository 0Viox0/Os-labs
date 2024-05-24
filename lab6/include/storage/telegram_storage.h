#ifndef TELEGRAMSTORAGE_H
#define TELEGRAMSTORAGE_H

#include <curl/curl.h>

size_t discard_response(void* ptr, size_t size, size_t nmemb, void* userdata);
void send_telegramm_message(const char* file_content, const char* message,
                            const char* file_name);
#endif
