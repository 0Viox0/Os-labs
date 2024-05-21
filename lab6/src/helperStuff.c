#include "../include/helperStuff.h"
#include <string.h>

char dir_list[256][256];
int curr_dir_idx = -1;

char files_list[256][256];
int curr_file_idx = -1;

char files_content[256][256];
int curr_file_content_idx = -1;

void add_dir(const char *dir_name) {
    curr_dir_idx++;
    strcpy(dir_list[curr_dir_idx], dir_name);
}
