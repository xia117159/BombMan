#include "MouseControl.h"
#include "sysfunc.h"
MouseControl::MouseControl() : directInput_( 0 ), mouseDevice_( 0 )
{

}

MouseControl::~MouseControl()
{

}



bool MouseControl::Initialize( HINSTANCE hInstance, HWND hwnd )
{
	hInstance_ = hInstance;
	hwnd_ = hwnd;
	HRESULT result;

	POINT p;
	GetCursorPos(&p);
	ScreenToClient(hwnd,&p);
	mousePosX_ = p.x;
	mousePosY_ = p.y;
	mouseWheel_ = 0;



	result = DirectInput8Create( hInstance_, DIRECTINPUT_VERSION, IID_IDirectInput8, ( void** )&directInput_, 0 );

    if( FAILED( result ) )
    { 
        return false;
    }


    result = directInput_->CreateDevice( GUID_SysMouse, &mouseDevice_, 0 );

    if( FAILED( result ) )
    { 
        return false;
    }

    result = mouseDevice_->SetDataFormat( &c_dfDIMouse );

    if( FAILED( result ) )
    { 
        return false;
    }

    result = mouseDevice_->SetCooperativeLevel( hwnd_, DISCL_FOREGROUND | DISCL_NONEXCLUSIVE );

    if( FAILED( result ) )
    { 
        return false;
    }

    result = mouseDevice_->Acquire( );

    if( FAILED( result ) )
    { 
        return false;
    }

	return true;
}

int MouseControl::DetectMouse(float startX, float startY, float endX, float endY)
{
	mouseDevice_->GetDeviceState( sizeof ( mouseState_ ), ( LPVOID ) &mouseState_ );

	mousePosX_ += mouseState_.lX;
	mousePosY_ += mouseState_.lY;
	mouseWheel_ += mouseState_.lZ;

	//MessageBox(NULL, mousePosX_, mousePosY_, MB_OK);
	/*char buf1[100];
	sprintf(buf1,"mousePosX_£º%ld£¬mouseState_.lX£º%ld",mousePosX_,mouseState_.lX);*/

	if( ( startX < mousePosX_  && mousePosX_ < endX ) && ( startY < mousePosY_  && mousePosY_< endY ) )
	{
		//MessageBox(NULL, AnsiToUnicode(buf1), TEXT("±êÌâ"), MB_OK);
		if( MOUSEDOWN( prevMouseState_, 0 ) && !MOUSEDOWN( mouseState_, 0 ) ) 
		{
			return MouseLeftUp;
		}
		else if( !MOUSEDOWN( prevMouseState_, 0 ) && MOUSEDOWN( mouseState_, 0) )
		{
			return MouseLeftDown;
		}
		else if( !MOUSEDOWN( prevMouseState_, 1 ) && MOUSEDOWN( mouseState_, 1) )
		{
			return MouseRightDown;
		}
		else if( MOUSEDOWN( prevMouseState_, 1 ) && !MOUSEDOWN( mouseState_, 1) )
		{
			return MouseRightUp;
		}
		else if( !MOUSEDOWN( prevMouseState_, 0 ) && !MOUSEDOWN( mouseState_, 0) )
		{
			return MouseHover;
		}
	}

	memcpy( &prevMouseState_, &mouseState_, sizeof( mouseState_ ) );
	return 0;
}






