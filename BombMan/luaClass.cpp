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

void LuaClass::CFuncRegister(char *cFuncName, lua_CFunction Func)
{
	lua_register(lua_state, cFuncName, Func);
}


//调用指定的lua 函数
//const char *LuaFuncName：调用的函数名
//输出参数表，d为int型整数，s为字符串，f为double类型变量
//有参数调用示例：luasubject.LuaFuncUse("luafunc(%s,%d,%f)", "string", 100, 3.14);
//无参数调用示例：luasubject.LuaFuncUse("luafunc()");


void LuaClass::LuaFuncUse(const char *LuaFuncName,...)
{
	int IntValue = 0;
	int ValuesNum = 0, loopi = 0, loopj = 0;
	char *StringValue = NULL, LuaFunc[128] = {'\0'};
	double FloatValue = 0.0f;
	va_list args;  
    va_start(args, LuaFuncName);
	while('\0' != *LuaFuncName)
	{
		switch(*LuaFuncName)
		{
		case '%':LuaFuncName++;
			switch(*LuaFuncName)
			{
			case 'd':
				{
					IntValue = va_arg(args, int);
					lua_pushinteger(lua_state,IntValue);
					ValuesNum++;
				}break;
			case 's':
				{
					StringValue = va_arg(args, char *);
					lua_pushstring(lua_state,StringValue);
					ValuesNum++;
				}break;
			case 'f':
				{
					FloatValue = va_arg(args, double);

					lua_pushnumber(lua_state,FloatValue);
					ValuesNum++;
				}break;
			}
			break;
		case '(':
			{
				for(;loopi<loopj;loopi++)LuaFunc[loopi] = *(LuaFuncName-loopj+loopi);
				lua_getglobal(lua_state, LuaFunc);
			}break;
		default:break;

		}
		loopj++;
		LuaFuncName++;
	}

	lua_call(lua_state, ValuesNum, 0);
	va_end(args); 
}








