#ifndef __MOUSECONTROL
#define __MOUSECONTROL

#include "include.h"

#define MouseLeftDown   0x01   //鼠标左键按下
#define MouseLeftUp     0x02   //鼠标左键松开
#define MouseRightDown  0x03   //鼠标右键按下
#define MouseRightUp    0x04   //鼠标左键松开
#define MouseHover      0x05   //鼠标悬停

#define MOUSEDOWN(device, key) ( device.rgbButtons[key] & 0x80 )

class MouseControl
{
public:
	MouseControl();
	~MouseControl();

	bool Initialize( HINSTANCE hInstance, HWND hwnd );
	int DetectMouse(float startX, float startY, float endX, float endY);
	int GetMouseStatus();
	void UpdateMousePos();
	long GetMouseX();
	long GetMouseY();

private:

	POINT p;


	HINSTANCE hInstance_;
    HWND hwnd_;

	LPDIRECTINPUT8 directInput_;
        
    LPDIRECTINPUTDEVICE8 mouseDevice_;//鼠标设备
	DIMOUSESTATE mouseState_;     //目前鼠标状态
	DIMOUSESTATE prevMouseState_; //之前鼠标状态
	long mousePosX_;  //鼠标x坐标
	long mousePosY_;  //鼠标y坐标
	long mouseWheel_; //滚轮

};















#endif


