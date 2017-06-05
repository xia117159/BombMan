#ifndef __KEYBOARD
#define __KEYBOARD

#include "include.h"
#include "luaClass.h"






#define KeepPressing 101  //һֱ����
#define Press        102  //���µ���һ˲��
#define Release      103  //�ɿ�����һ˲��


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
        
    LPDIRECTINPUTDEVICE8 keyboardDevice_; //�����豸
	char keyboardKeys_[256];      //Ŀǰ���̰���
    char Keys[256];  //֮ǰ���̰���

};











#endif
