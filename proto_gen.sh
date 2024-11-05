#!/bin/bash

#protoc --proto_path=. --descriptor_set_out=hello.pb hello.proto
protoc -o hello.pb hello.proto