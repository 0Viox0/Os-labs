#ifndef TELEGRAMMESSAGEAPI_H
#define TELEGRAMMESSAGEAPI_H

enum tel_type { TEL_DIRECTORY, TEL_FILE };

struct tel_file {
    enum tel_type type;
    const char* name;
    const char* const tags;
    const char* content;
};

const char* tel_type_to_string(enum tel_type type);

void create_file(struct tel_file* file);

#endif
