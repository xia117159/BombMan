#include "luaClass.h"



//默认构造函数
LuaClass::LuaClass()
{

}
//自定义构造函数
LuaClass::LuaClass(char *pFileName)
{
	LuaFileName = pFileName;
	lua_state = NULL;
	lua_state = lua_open();
	luaL_openlibs(lua_state);  
}
//析构函数
LuaClass::~LuaClass()
{

}

void LuaClass::LuaDoFile()
{
	if(lua_state)
	{
		luaL_dofile(lua_state, LuaFileName); 
	}
}


void LuaClass::LuaCloseFile()
{
	if(lua_state)
	{
		lua_close(lua_state);
	}
}

void LuaClass::LuaFuncRegister(char *cFuncName, lua_CFunction Func)
{
	lua_register(lua_state, cFuncName, Func);
}










