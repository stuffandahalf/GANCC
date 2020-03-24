cmake_minimum_required(VERSION 3.1)
project(GANCC C)

file(GLOB_RECURSE GANCPP_SOURCES "gancpp/src/*.c")
file(GLOB_RECURSE GANCPP_LOCAL_HEADERS "gancpp/src/*.h")
add_executable(gancpp ${GANCPP_SOURCES} ${GANCPP_LOCAL_HEADERS})

file(GLOB_RECURSE GANCC_SOURCES "gancc/src/*.c")
file(GLOB_RECURSE GANCC_LOCAL_HEADERS "gancc/src/*.h")
file(GLOB_RECURSE HEADERS "include/*.h")
add_executable(gancc ${GANCC_SOURCES} ${GANCC_LOCAL_HEADERS} ${GANCC_HEADERS})

install(TARGETS gancpp gancc DESTINATION ${CMAKE_INSTALL_PREFIX})
