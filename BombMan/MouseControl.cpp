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


extern HWND hwnd;
int MouseControl::DetectMouse(float startX, float startY, float endX, float endY)
{
	int Result = 0;

	
	
	
	//char buff[20];
	//sprintf(buff,"X:%ld   Y:%ld",p.x,p.y);

	//MessageBox(NULL,AnsiToUnicode(buff),TEXT("Î»ÖÃ"),MB_OK);



	mouseDevice_->GetDeviceState( sizeof ( mouseState_ ), ( LPVOID ) &mouseState_ );

	mousePosX_ += mouseState_.lX;
	mousePosY_ += mouseState_.lY;
	mouseWheel_ += mouseState_.lZ;

	startY = 600.0 - startY;
	endY = 600.0 - endY;

	if( ( startX < p.x  && p.x  < endX ) && ( endY < p.y  && p.y < startY ) )
	{
		if( MOUSEDOWN( prevMouseState_, 0 ) && !MOUSEDOWN( mouseState_, 0 ) ) 
		{
			Result = MouseLeftUp;
		}
		else if( !MOUSEDOWN( prevMouseState_, 0 ) && MOUSEDOWN( mouseState_, 0) )
		{
			Result = MouseLeftDown;
		}
		else if( !MOUSEDOWN( prevMouseState_, 1 ) && MOUSEDOWN( mouseState_, 1) )
		{
			Result = MouseRightDown;
		}
		else if( MOUSEDOWN( prevMouseState_, 1 ) && !MOUSEDOWN( mouseState_, 1) )
		{
			Result = MouseRightUp;
		}
		else if( !MOUSEDOWN( prevMouseState_, 0 ) && !MOUSEDOWN( mouseState_, 0) )
		{
			Result = MouseHover;
		}
	}
	memcpy( &prevMouseState_, &mouseState_, sizeof( mouseState_ ) );
	return Result;
}

int MouseControl::GetMouseStatus()
{
	int Result = 0;

	mouseDevice_->GetDeviceState( sizeof ( mouseState_ ), ( LPVOID ) &mouseState_ );

	mousePosX_ += mouseState_.lX;
	mousePosY_ += mouseState_.lY;
	mouseWheel_ += mouseState_.lZ;


	if( MOUSEDOWN( prevMouseState_, 0 ) && !MOUSEDOWN( mouseState_, 0 ) ) 
	{
		Result = MouseLeftUp;
	}
	else if( !MOUSEDOWN( prevMouseState_, 0 ) && MOUSEDOWN( mouseState_, 0) )
	{
		Result = MouseLeftDown;
	}
	else if( !MOUSEDOWN( prevMouseState_, 1 ) && MOUSEDOWN( mouseState_, 1) )
	{
		Result = MouseRightDown;
	}
	else if( MOUSEDOWN( prevMouseState_, 1 ) && !MOUSEDOWN( mouseState_, 1) )
	{
		Result = MouseRightUp;
	}
	else if( !MOUSEDOWN( prevMouseState_, 0 ) && !MOUSEDOWN( mouseState_, 0) )
	{
		Result = MouseHover;
	}
	memcpy( &prevMouseState_, &mouseState_, sizeof( mouseState_ ) );


	return Result;
}



void MouseControl::UpdateMousePos()
{
	GetCursorPos(&p);
	ScreenToClient(hwnd,&p);
}

long MouseControl::GetMouseX()
{
	return p.x;
}

long MouseControl::GetMouseY()
{
	return p.y;
}

