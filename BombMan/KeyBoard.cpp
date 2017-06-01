#include "KeyBoard.h"

KeyBoard::KeyBoard() :directInput_( 0 ), keyboardDevice_( 0 )
{

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
    ZeroMemory( prevKeyboardKeys_, sizeof( prevKeyboardKeys_ ) );

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

int KeyBoard::DetectKey(int Key)
{
	int Result = 0;
	keyboardDevice_->GetDeviceState( sizeof( keyboardKeys_ ), ( LPVOID )&keyboardKeys_ );

	if( KEYDOWN( prevKeyboardKeys_, Key ) && KEYDOWN( keyboardKeys_, Key ))
	{ 
		Result = KeepPressing;
	}
	else if( !KEYDOWN( prevKeyboardKeys_, Key ) && KEYDOWN( keyboardKeys_, Key ))
	{ 
		Result = Press;
	}
	else if( KEYDOWN( prevKeyboardKeys_, Key ) && !KEYDOWN( keyboardKeys_, Key ))
	{ 
		Result = Release;
	}

	memcpy( prevKeyboardKeys_, keyboardKeys_, sizeof( keyboardKeys_ ) );

	return Result;
}






