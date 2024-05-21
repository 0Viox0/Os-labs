cmake_minimum_required(VERSION 3.10)

project(fuseFileSystem)

find_package(PkgConfig REQUIRED)
pkg_check_modules(FUSE REQUIRED fuse)

include_directories(${FUSE_INCLUDE_DIRS} ${PROJECT_SOURCE_DIR}/include)

file(GLOB SRC_FILES "src/*.c")
add_executable(main ${SRC_FILES})

target_link_libraries(main ${FUSE_LIBRARIES})

target_compile_options(main PRIVATE ${FUSE_CFLAGS_OTHER})

set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
