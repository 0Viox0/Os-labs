#ifndef HELPERSTUFF_H
#define HELPERSTUFF_H

extern char dir_list[256][256];
extern int curr_dir_idx;

extern char files_list[256][256];
extern int curr_file_idx;

extern char files_content[256][256];
extern int curr_file_content_idx;

void add_dir(const char *dir_name);

#endif
