--print(_VERSION)
--
--print(c_add(1, 22))
--
--print(package.path)
--print(package.cpath)

--package.cpath = "/usr/local/lib/?.so;"..package.cpath
--print("after modify:" .. package.cpath)

local pb = require "pb"
local conv = require "pb.conv"
local protoc = require "protoc"
local socket = require "socket"

--pb.option("int64_as_string")



local function get_milliseconds()
    return socket.gettime() * 1000
end

-- 直接载入schema (这么写只是方便, 生产环境推荐使用 protoc.new() 接口)
--assert(protoc:load [[
--   message Phone {
--      optional string name        = 1;
--      optional int64  phonenumber = 2;
--   }
--   message Person {
--      optional string name     = 1;
--      optional int32  age      = 2;
--      optional string address  = 3;
--      repeated Phone  contacts = 4;
--   } ]])


-- 读取hello.pb内容
local f = assert(io.open("hello.pb", "rb"))
local content = f:read "*a"
f:close()
pb.load(content)

--print("pb.types")
--for name, basename, type in pb.types() do
--    print(name, basename, type)
--end

--local data = {
--    name = "ilse",
--    age  = 18,
--    contacts = {
--        { name = "alice", phonenumber = 12312341234 },
--        { name = "bob",   phonenumber = 45645674567 }
--    }
--}

--local data1 = {
--    name = "jordan",
--    age  = 23,
--    --phone = {
--    --    "213423423",
--    --    "sdgasdgasdg",
--    --    "234234234",
--    --}
--}


-- 将Lua表编码为二进制数据
--local bytes = assert(pb.encode("person", data1))
--print(pb.tohex(bytes))
--
--print("=================================")
---- 再解码回Lua表
--local data2 = assert(pb.decode("person", bytes))
--print(require "serpent".block(data2))

local max_uint64 = 18446744073709551615
local max_int64 = 9223372036854775807
local testint = 256
--testint = testint + 2
--print(testint)

local teststr = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabc"
--print(teststr)


local data_int = {
    n1 = testint,
    n2 = testint,
    n3 = testint,
    n4 = testint,
    n5 = testint,
    n6 = testint,
}

local data_str = {
    s1 = teststr
}

local data_arr = {
    arr1 = {
        9223372036854775807,
        9223372036854775807,
        9223372036854775807,
        9223372036854775807,
        9223372036854775807,
        9223372036854775807
    },
}


local start_time = get_milliseconds()
local bytes
for i = 1, 10000000 do
    bytes = pb.encode("testarr", data_arr)
end
local end_time1 = get_milliseconds()
print("encode total spend time ".. (end_time1 - start_time) .. ' ms')


local data2
for i = 1, 10000000 do
    data2 = pb.decode("testarr", bytes)
end
local end_time2 = get_milliseconds()
print("decode total spend time ".. (end_time2 - end_time1) .. ' ms')

print(require "serpent".block(data2))

num = data2.arr1
print(num)
print("type: " .. type(num))
print(data2.arr1[3])
