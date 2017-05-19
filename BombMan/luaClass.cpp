#include "luaClass.h"



//Ĭ�Ϲ��캯��
LuaClass::LuaClass()
{

}
//�Զ��幹�캯��
LuaClass::LuaClass(char *pFileName)
{
	LuaFileName = pFileName;
	lua_state = NULL;
	lua_state = lua_open();
	luaL_openlibs(lua_state);  
}
//��������
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


//����ָ����lua ����
//const char *LuaFuncName�����õĺ�����
//���������dΪint��������sΪ�ַ�����fΪdouble���ͱ���
//�в�������ʾ����luasubject.LuaFuncUse("luafunc(%s,%d,%f)", "string", 100, 3.14);
//�޲�������ʾ����luasubject.LuaFuncUse("luafunc()");


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








