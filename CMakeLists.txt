cmake_minimum_required(VERSION 3.22)
project(lua_test)

set(CMAKE_CXX_STANDARD 20)

# 增加连接器选项
#set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-E")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
add_executable(lua_test main.cpp)
target_link_options(lua_test PRIVATE "-Wl,-E")
target_link_libraries(lua_test lua)
