#ifndef __INCLUDE
#define __INCLUDE
//************�궨��************
#define WindowsWidth 1000           //���ڿ��
#define WindowsHeight 600           //���ڸ߶�
#define GameTitle L"ը���˳������"  //��������

//��ʼ�˵�ͼ��߿�
#define ButtonWidth            353.0f//391.5f
#define ButtonHeight           158.0f//177.0f
#define ButtonWidthF           ( ButtonWidth / (float) WindowsWidth )
#define ButtonHeightF          ( ButtonHeight / (float) WindowsHeight )
#define ButtonImageWidth       706.0f//783.0f
#define ButtonImageHeight      947.0f//1062.0f
#define tuWidth                ( ButtonWidth / ButtonImageWidth )
#define tuHeight               ( ButtonHeight / ButtonImageHeight )



#define KEYDOWN(name, key) ( name[key] & 0x80 )
#define BUTTONDOWN(device, key) ( device.rgbButtons[key] & 0x80 )

#define INITGUID 
//**********�궨�����**********
//************���ļ�************
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
#include <dinput.h>
#include <dinput.h>


#include <mmsystem.h>//��������ͷ�ļ�
#pragma comment(lib, "winmm.lib")

#include "resource.h"

//****lua���ļ�****
extern "C" {  
	#include "lua/lua.h"
	#include "lua/lualib.h"
	#include "lua/lauxlib.h"  
}

//********���ļ�����**********

//*********�����ռ�***********
using namespace std;


#endif