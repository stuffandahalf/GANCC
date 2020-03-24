cmake_minimum_required(VERSION 3.1)
project(GANCC C)

find_package(BISON)
find_package(FLEX)

#flex_target(
file(GLOB_RECURSE GANCPP_SOURCES "gancpp/src/*.c")
file(GLOB_RECURSE GANCPP_LOCAL_HEADERS "gancpp/src/*.h")
add_executable(gancpp ${GANCPP_SOURCES} ${GANCPP_LOCAL_HEADERS})

bison_target(lang_parser gancc/src/c.y ${CMAKE_CURRENT_BINARY_DIR}/lang_parser.c)
flex_target(lang_scanner gancc/src/c.l ${CMAKE_CURRENT_BINARY_DIR}/lang_scanner.c)
add_flex_bison_dependency(lang_scanner lang_parser)
file(GLOB_RECURSE GANCC_SOURCES "gancc/src/*.c")
file(GLOB_RECURSE GANCC_LOCAL_HEADERS "gancc/src/*.h")
file(GLOB_RECURSE HEADERS "include/*.h")
add_executable(gancc ${GANCC_SOURCES} ${GANCC_LOCAL_HEADERS} ${GANCC_HEADERS} ${BISON_lang_parser_OUTPUTS} ${FLEX_lang_scanner_OUTPUTS})
target_include_directories(gancc PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/)

install(TARGETS gancpp gancc DESTINATION ${CMAKE_INSTALL_PREFIX})
