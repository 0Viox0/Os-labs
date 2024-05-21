cmake_minimum_required(VERSION 3.10)

project(fuseFileSystem)

set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)

find_package(PkgConfig REQUIRED)
find_package(CURL REQUIRED)

pkg_check_modules(FUSE REQUIRED fuse)

include_directories(${FUSE_INCLUDE_DIRS} ${PROJECT_SOURCE_DIR}/include)

file(GLOB_RECURSE SRC_FILES "src/**.c")
add_executable(main ${SRC_FILES})

target_link_libraries(main ${FUSE_LIBRARIES} CURL::libcurl)

target_compile_options(main PRIVATE ${FUSE_CFLAGS_OTHER})
