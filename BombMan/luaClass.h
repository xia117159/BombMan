#ifndef __LUACLASS
#define __LUACLASS

#include "include.h"


class LuaClass
{
public:
	LuaClass();
	LuaClass(char * pFileName);
	~LuaClass();

	void LuaFuncRegister(char *cFuncName, lua_CFunction Func);
	void LuaDoFile();
	void LuaCloseFile();


	lua_State *lua_state;
private:
	char *LuaFileName;

};




#endif