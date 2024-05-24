#include <filesystem/fuse_operations.h>
#include <string.h>
#include <sys/stat.h>

static int do_getattr(const char *path, struct stat *st) {
    st->st_uid = getuid();
    st->st_gid = getgid();

    st->st_atime = time(NULL);
    st->st_mtime = time(NULL);

    if (strcmp(&path[strlen(path) - 1], "/") == 0) {
        st->st_mode = S_IFDIR | 0755;
        st->st_nlink = 2;
    } else if (strcmp(&path[strlen(path) - 1], "/") != 0) {
        st->st_mode = S_IFREG | 0644;
        st->st_nlink = 1;
        st->st_size = 1024;
    } else {
        return -ENOENT;
    }

    return 0;
}

static int do_readdir(const char *path, void *buffer, fuse_fill_dir_t filler,
                      off_t offset, struct fuse_file_info *fi) {
    filler(buffer, ".", NULL, 0);
    filler(buffer, "..", NULL, 0);

    return 0;
}
