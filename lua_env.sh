#!/bin/bash

# 下载 编译 安装 lua
curl -L -R -O https://www.lua.org/ftp/lua-5.4.7.tar.gz\
tar zxf lua-5.4.7.tar.gz
cd lua-5.4.7/
make
sudo make install

# 下载安装 luarocks
wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz
tar zxpf luarocks-3.11.1.tar.gz
cd luarocks-3.11.1/
./configure && make && sudo make install

# 安装 lua-protobuf
sudo luarocks install lua-protobuf
# 安装 luasocket
sudo luarocks install luasocket




