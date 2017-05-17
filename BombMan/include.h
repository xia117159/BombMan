#ifndef __INCLUDE
#define __INCLUDE
//************�궨��************
#define WindowsWidth 1000           //���ڿ��
#define WindowsHeight 600           //���ڸ߶�
#define GameTitle "ը���˳������"  //��������

//��ʼ�˵�ͼ��߿�
#define ButtonWidth            353.0f//391.5f
#define ButtonHeight           158.0f//177.0f
#define ButtonWidthF           ( ButtonWidth / (float) WindowsWidth )
#define ButtonHeightF          ( ButtonHeight / (float) WindowsHeight )
#define ButtonImageWidth       706.0f//783.0f
#define ButtonImageHeight      947.0f//1062.0f
#define tuWidth                ( ButtonWidth / ButtonImageWidth )
#define tuHeight               ( ButtonHeight / ButtonImageHeight )


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


//**********lua���ļ�************
extern "C" {  
	#include "lua/lua.h"
	#include "lua/lualib.h"
	#include "lua/lauxlib.h"  
}
#include "lua/lua.hpp"


//**********�����ռ�************
using namespace std;


#endif