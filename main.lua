--print(_VERSION)
--
--print(c_add(1, 22))
--
--print(package.path)
--print(package.cpath)

--package.cpath = "/usr/local/lib/?.so;"..package.cpath
--print("after modify:" .. package.cpath)

local pb = require "pb"
local protoc = require "protoc"
local socket = require "socket"

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

local data1 = {
    name = "jordan",
    age  = 23,
    --phone = {
    --    "213423423",
    --    "sdgasdgasdg",
    --    "234234234",
    --}
}


-- 将Lua表编码为二进制数据
--local bytes = assert(pb.encode("person", data1))
--print(pb.tohex(bytes))
--
--print("=================================")
---- 再解码回Lua表
--local data2 = assert(pb.decode("person", bytes))
--print(require "serpent".block(data2))


local start_time = get_milliseconds()
for i = 1, 1000000 do
    bytes = pb.encode("person", data1)
    data2 = pb.decode("person", bytes)
end

print("total spend time ".. (get_milliseconds() - start_time) .. ' ms')

print(require "serpent".block(data2))
