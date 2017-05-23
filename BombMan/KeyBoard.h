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
        
    LPDIRECTINPUTDEVICE8 keyboardDevice_; //�����豸
	char keyboardKeys_[256];      //Ŀǰ���̰���
    char prevKeyboardKeys_[256];  //֮ǰ���̰���

};











#endif
