#ifndef __KEYBOARD
#define __KEYBOARD

#include "include.h"
#include "luaClass.h"






#define KeepPressing 101  //一直按下
#define Press        102  //按下的那一瞬间
#define Release      103  //松开的那一瞬间


class KeyBoard
{
public:
	KeyBoard();
	~KeyBoard();

	bool Initialize( HINSTANCE hInstance, HWND hwnd );
	int DetectKey(int Key);

private:

	

	HINSTANCE hInstance_;
    HWND hwnd_;

	LPDIRECTINPUT8 directInput_;
        
    LPDIRECTINPUTDEVICE8 keyboardDevice_; //键盘设备
	char keyboardKeys_[256];      //目前键盘按键
    char Keys[256];  //之前键盘按键

};











#endif
