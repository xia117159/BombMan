#ifndef __KEYBOARD
#define __KEYBOARD

#include "include.h"
#include "luaClass.h"

class KeyBoard
{
public:
	KeyBoard();
	~KeyBoard();

	bool Initialize( HINSTANCE hInstance, HWND hwnd );
	bool DetectKey(int Key);

private:

	

	HINSTANCE hInstance_;
    HWND hwnd_;

	LPDIRECTINPUT8 directInput_;
        
    LPDIRECTINPUTDEVICE8 keyboardDevice_; //键盘设备
	char keyboardKeys_[256];      //目前键盘按键
    char prevKeyboardKeys_[256];  //之前键盘按键

};











#endif
