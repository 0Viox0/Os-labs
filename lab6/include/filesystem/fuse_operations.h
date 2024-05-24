#ifndef FUSEOPERATIONS_H
#define FUSEOPERATIONS_H

#include <errno.h>
#include <fuse.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

static int do_getattr(const char *path, struct stat *st);
static int do_readdir(const char *path, void *buffer, fuse_fill_dir_t filler,
                      off_t offset, struct fuse_file_info *fi);

#endif
