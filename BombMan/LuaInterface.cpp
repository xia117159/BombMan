#include "luaClass.h"
#include "MouseControl.h"
#include "KeyBoard.h"
#include "GameStateInterface.h"
#include "sysfunc.h"

//lua���õĽӿں�������
static int LuaDrawImage(lua_State *L);
static int SetViewIamgePath(lua_State *L);
static int KeyControl(lua_State *L);
//ȫ�ֶ�������
extern GameStateInterface demo;

extern LuaClass LuaConnect;
extern KeyBoard TempKeyDetect;
extern MouseControl MouseDetect;

//lua��ʼ�������������ӿں���ޚע��
void LuaInterfaceInit()
{
	LuaConnect.SetLuaFile("lua/MainLua.lua");
	LuaConnect.CFuncRegister("SetViewIamgePath", SetViewIamgePath);
	LuaConnect.CFuncRegister("LuaDrawImage", LuaDrawImage);
	LuaConnect.CFuncRegister("KeyDetect", KeyControl);
	LuaConnect.LuaDoFile();
}




//�ṩ��Lua���õĺ����Ľӿ�
//�����һ����������ֵ����Ϊint,��������Ϊlua_State *L����L���ɱ�
static int LuaDrawImage(lua_State *L)
{
	 //����ջ��Ԫ�صĸ���  
    int n = lua_gettop(L);
    float Value[9];  
    int i;  
    for (i = 1; i <= n; i++)  
    {  
        if (!lua_isnumber(L, i))   
        {  
            lua_pushstring(L, "Incorrect argument to 'average'");  
            lua_error(L);
			return 0;
        }  
        Value[i-1] = (float)lua_tonumber(L, i);
    }
	demo.DrawImage(Value[0],Value[1],Value[2],Value[3],Value[4],Value[5],Value[6],Value[7],Value[8]);
	return 1;
}


//�ṩ��Lua���õĺ����Ľӿ�
//�����һ����������ֵ����Ϊint,��������Ϊlua_State *L����L���ɱ�
static int SetViewIamgePath(lua_State *L)
{
	 //����ջ��Ԫ�صĸ���  
    int n = lua_gettop(L);

	int i;  
    for (i = 1; i <= n; i++)  
    {  
        if (!lua_isstring(L, i))   
        {  
            lua_pushstring(L, "Incorrect argument to 'average'");  
            lua_error(L);
			return 0;
        }
		demo.SetImagePath( AnsiToUnicode(lua_tolstring(L, i, NULL)) );
    }
	return 1;
}


//�ṩ��Lua���õĺ����Ľӿ�
//�����һ����������ֵ����Ϊint,��������Ϊlua_State *L����L���ɱ�
static int KeyControl(lua_State *L)
{
	 //����ջ��Ԫ�صĸ���  
    int n = lua_gettop(L);

	int i;  
    for (i = 1; i <= n; i++)  
    {  
        if (!lua_isstring(L, i))   
        {  
            lua_pushstring(L, "Incorrect argument to 'average'");  
            lua_error(L);
			return 0;
        }
		if(TempKeyDetect.DetectKey((int)lua_tonumber(L, i))) lua_pushnumber(LuaConnect.lua_state,1);
    }
	return 1;
}












