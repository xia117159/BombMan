#include "KeyBoard.h"

KeyBoard::KeyBoard() :directInput_( 0 ), keyboardDevice_( 0 )
{
	int i=0;
	for(i=0;i<256;i++)
	{
		Keys[i] = Release;
	}
}

KeyBoard::~KeyBoard()
{

}



bool KeyBoard::Initialize( HINSTANCE hInstance, HWND hwnd )
{

	hInstance_ = hInstance;
	hwnd_ = hwnd;
	HRESULT result;

	ZeroMemory( keyboardKeys_, sizeof( keyboardKeys_ ) );
	
	result = DirectInput8Create( hInstance_, DIRECTINPUT_VERSION, IID_IDirectInput8, ( void** )&directInput_, 0 );

    if( FAILED( result ) )
    { 
        return false;
    }


	result = directInput_->CreateDevice( GUID_SysKeyboard, &keyboardDevice_, 0 );

    if( FAILED( result ) )
    { 
        return false;
    }

	 result = keyboardDevice_->SetDataFormat( &c_dfDIKeyboard );

    if( FAILED( result ) )
    { 
        return false;
    }

    result = keyboardDevice_->SetCooperativeLevel( hwnd_, DISCL_FOREGROUND | DISCL_NONEXCLUSIVE );

    if( FAILED( result ) )
    { 
        return false;
    }

    result = keyboardDevice_->Acquire( );

    if( FAILED( result ) )
    { 
        return false;
    }
	return true;
}
extern HWND hwnd;
extern HINSTANCE GlobalhInstance;
int KeyBoard::DetectKey(int Key)
{
	int Result = 0;
	keyboardDevice_->GetDeviceState( sizeof( keyboardKeys_ ), ( LPVOID )&keyboardKeys_ );

	if( Keys[Key] == Press && KEYDOWN( keyboardKeys_, Key ))
	{ 
		Result = KeepPressing;
	}
	else if( Keys[Key] == Release  && KEYDOWN( keyboardKeys_, Key ))
	{ 
		Result = Press;
		Keys[Key] = Press;
	}
	else if( Keys[Key] == Press  && !KEYDOWN( keyboardKeys_, Key ))
	{ 
		Result = Release;
		Keys[Key] = Release;
	}

	return Result;
}






