cmake_minimum_required(VERSION 3.22)
project(build_system)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_VERBOSE_BUILD TRUE)
message(${CMAKE_INSTALL_PREFIX})
add_custom_target(fetch)

add_subdirectory(platforms)
add_subdirectory(platform)
add_subdirectory(core)
add_subdirectory(features)


install(SCRIPT ${CMAKE_SOURCE_DIR}/PostInstall.cmake)
