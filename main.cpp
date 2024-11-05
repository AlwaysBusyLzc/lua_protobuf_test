#include <iostream>
#include <lua.hpp>

int add(lua_State* lua)
{
    int stackSize = lua_gettop(lua);
    if (stackSize != 2)
    {
        lua_pushstring(lua, "add() expects 2 arguments");
        lua_error(lua);
        return 0;
    }

    int a = lua_tonumber(lua, 1);
    int b = lua_tonumber(lua, 2);
    lua_pushnumber(lua, a + b);
    return 1;
}



int main() {
    std::cout << "Hello, World!" << std::endl;

    lua_State* lua = luaL_newstate();
    luaL_openlibs(lua);


    lua_register(lua, "c_add", add);

//    if (luaL_dostring(lua, "require \"pb\""))
//    {
//        std::cout << lua_tostring(lua, -1) << std::endl;
//    }

    if (luaL_dofile(lua, "./main.lua")) {
        std::cout << lua_tostring(lua, -1) << std::endl;
    }



    return 0;
}
