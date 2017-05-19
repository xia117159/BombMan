#ifndef __INCLUDE
#define __INCLUDE
//************宏定义************
#define WindowsWidth 1000           //窗口宽度
#define WindowsHeight 600           //窗口高度
#define GameTitle L"炸弹人超好玩版"  //窗口名字

//开始菜单图标高宽
#define ButtonWidth            353.0f//391.5f
#define ButtonHeight           158.0f//177.0f
#define ButtonWidthF           ( ButtonWidth / (float) WindowsWidth )
#define ButtonHeightF          ( ButtonHeight / (float) WindowsHeight )
#define ButtonImageWidth       706.0f//783.0f
#define ButtonImageHeight      947.0f//1062.0f
#define tuWidth                ( ButtonWidth / ButtonImageWidth )
#define tuHeight               ( ButtonHeight / ButtonImageHeight )


//************库文件************
#define KeyUp       'W'
#define KeyUpLua    99
#define KeyDown     'S'
#define KeyDownLua  100
#define KeyRight    'A'
#define KeyRightLua 101
#define KeyLeft     'D'
#define KeyLeftLua  102
//**********宏定义结束**********
//************库文件************
#include <Windows.h>
#include <WinError.h>
#include <memory.h>

#include <d3d11.h>
#include <d3dx11.h>
#include <DxErr.h>
#include <D2D1.h>  
#include <DWrite.h>
#include <D3Dcompiler.h>
#include <xnamath.h>
#include <d3dx11effect.h>
#include <iostream>
#include <stdlib.h>
#include <string>
#include <DXUT.h>
#include <DXUTcamera.h>
#include <DXUTgui.h>
#include <DXUTsettingsDlg.h>

//****lua库文件****
extern "C" {  
	#include "lua/lua.h"
	#include "lua/lualib.h"
	#include "lua/lauxlib.h"  
}

//********库文件结束**********

//*********命名空间***********
using namespace std;


#endif