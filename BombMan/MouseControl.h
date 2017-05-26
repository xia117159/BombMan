#ifndef __MOUSECONTROL
#define __MOUSECONTROL

#include "include.h"

#define MouseLeftDown   0x01   //����������
#define MouseLeftUp     0x02   //�������ɿ�
#define MouseRightDown  0x03   //����Ҽ�����
#define MouseRightUp    0x04   //�������ɿ�
#define MouseHover      0x05   //�����ͣ

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
        
    LPDIRECTINPUTDEVICE8 mouseDevice_;//����豸
	DIMOUSESTATE mouseState_;     //Ŀǰ���״̬
	DIMOUSESTATE prevMouseState_; //֮ǰ���״̬
	long mousePosX_;  //���x����
	long mousePosY_;  //���y����
	long mouseWheel_; //����

};















#endif


