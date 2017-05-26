#include "luaClass.h"
#include "MouseControl.h"
#include "KeyBoard.h"
#include "GameStateInterface.h"
#include "sysfunc.h"

//lua���õĽӿں�������
static int LuaDrawImage(lua_State *L);
static int SetViewIamgePath(lua_State *L);
static int KeyControl(lua_State *L);
static int LuaMessageBox(lua_State *L);
static int LuaDetectMouse(lua_State *L);
static int PlayMusic(lua_State *L);
static int ReleaseImageData(lua_State *L);
static int LuaGetMouseStatus(lua_State *L);
//ȫ�ֶ�������
extern GameStateInterface demo;

extern LuaClass LuaConnect;
extern KeyBoard TempKeyDetect;
extern MouseControl MouseDetect;



extern HWND hwnd;
//lua��ʼ�������������ӿں���ޚע��
void LuaInterfaceInit()
{
	LuaConnect.SetLuaFile("lua/MainLua.lua");
	LuaConnect.CFuncRegister("SetViewIamgePath", SetViewIamgePath);
	LuaConnect.CFuncRegister("LuaDrawImage", LuaDrawImage);
	LuaConnect.CFuncRegister("KeyDetect", KeyControl);
	LuaConnect.CFuncRegister("MessageBox", LuaMessageBox);
	LuaConnect.CFuncRegister("MouseDetect", LuaDetectMouse);
	LuaConnect.CFuncRegister("GetMouseStatus", LuaGetMouseStatus);
	LuaConnect.CFuncRegister("PlayMusic", PlayMusic);
	LuaConnect.CFuncRegister("ReleaseImageData", ReleaseImageData);

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
	
	demo.SetImagePath( AnsiToUnicode(lua_tolstring(L, 1, NULL)), lua_tolstring(L, 2, NULL), lua_tolstring(L, 3, NULL));
	return 1;
}


//�ṩ��Lua���õĺ����Ľӿ�
//�����һ����������ֵ����Ϊint,��������Ϊlua_State *L����L���ɱ�
static int KeyControl(lua_State *L)
{
	 //����ջ��Ԫ�صĸ���  
    int n = lua_gettop(L);
	lua_pushnumber(LuaConnect.lua_state, TempKeyDetect.DetectKey((int)lua_tonumber(L, 1)));

	return 1;
}


//�ṩ��Lua���õĺ����Ľӿ�
//�����һ����������ֵ����Ϊint,��������Ϊlua_State *L����L���ɱ�
static int LuaDetectMouse(lua_State *L)
{
	 //����ջ��Ԫ�صĸ���  
    int n = lua_gettop(L);
	int Result = MouseDetect.DetectMouse((int)lua_tonumber(L, 1), (int)lua_tonumber(L, 2), (int)lua_tonumber(L, 3), (int)lua_tonumber(L, 4));
	lua_pushnumber(LuaConnect.lua_state, Result);

	return 1;
}
//�ṩ��Lua���õĺ����Ľӿ�
//�����һ����������ֵ����Ϊint,��������Ϊlua_State *L����L���ɱ�
static int LuaGetMouseStatus(lua_State *L)
{
	 //����ջ��Ԫ�صĸ���  
    int n = lua_gettop(L);

	int Result = MouseDetect.GetMouseStatus();
	lua_pushnumber(LuaConnect.lua_state, Result);

	return 1;
}

//�ṩ��Lua���õĺ����Ľӿ�
//�����һ����������ֵ����Ϊint,��������Ϊlua_State *L����L���ɱ�
static int ReleaseImageData(lua_State *L)
{
	 //����ջ��Ԫ�صĸ���  
    int n = lua_gettop(L);

	demo.ReleseImageData();

	return 1;
}



//�ṩ��Lua���õĺ����Ľӿ�
//�����һ����������ֵ����Ϊint,��������Ϊlua_State *L����L���ɱ�
static int PlayMusic(lua_State *L)
{
	 //����ջ��Ԫ�صĸ���  
    int n = lua_gettop(L);

	PlaySound ( AnsiToUnicode(lua_tostring(L, 1)), NULL, SND_FILENAME | SND_ASYNC );

	return 1;
}


//�ṩ��Lua���õĺ����Ľӿ�
//�����һ����������ֵ����Ϊint,��������Ϊlua_State *L����L���ɱ�
static int LuaMessageBox(lua_State *L)
{
	 //����ջ��Ԫ�صĸ���  
    int n = lua_gettop(L);

	lua_pushnumber(LuaConnect.lua_state, MessageBox(NULL,  AnsiToUnicode(lua_tolstring(L, 1, NULL)),  AnsiToUnicode(lua_tolstring(L, 2, NULL)), lua_tonumber(L, 3)) );
	return 1;
}











