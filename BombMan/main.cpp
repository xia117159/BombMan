#include "include.h"
#include "MouseControl.h"
#include "KeyBoard.h"
#include "GameStateInterface.h"
#include "sysfunc.h"
//*******************全局变量定义区*******************
//窗口句柄定义
HWND hwnd = NULL;
GameStateInterface demo;
LuaClass LuaConnect;//全局lua接口连接对象
KeyBoard TempKeyDetect;
MouseControl MouseDetect;
//************************结束************************
//*********************函数声明区*********************
LRESULT CALLBACK WndProc( HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam );
HRESULT InitWindow(HINSTANCE hInstance, int nCmdShow);
static void MainMenuLoop();
static void KeyControl();
void LuaInterfaceInit();
//************************结束************************

int WINAPI wWinMain( HINSTANCE hInstance, HINSTANCE prevInstance, LPWSTR cmdLine, int cmdShow )
{
    
	LuaInterfaceInit();

	if (FAILED(InitWindow(hInstance, cmdShow)))
        return 0;

    // Demo Initialize
    bool result = demo.Initialize( hInstance, hwnd );

	if( result == false )
        return -1;

	TempKeyDetect.Initialize(hInstance, hwnd);
	MouseDetect.Initialize(hInstance, hwnd);

	
    MSG msg = { 0 };
    while( msg.message != WM_QUIT )
    {
        if( PeekMessage( &msg, 0, 0, 0, PM_REMOVE ) )
        {
            TranslateMessage( &msg );
            DispatchMessage( &msg );
        }
		else
		{
			const int constFps = 60;
			float timeInOneFps = 1000.0f/constFps;    // 每秒60帧，则1帧就是约16毫秒
			DWORD timeBegin = GetTickCount();
			
		    //主循环函数
			MainMenuLoop();
 
			// 限帧
			DWORD timeTotal = GetTickCount() - timeBegin;
			if (timeTotal < timeInOneFps)
				Sleep(DWORD(timeInOneFps-timeTotal));
		}
    }
    // Demo Shutdown
    demo.Shutdown( );

    return static_cast<int>( msg.wParam );
}

//主菜单循环函数
static void MainMenuLoop()
{
	KeyControl();
	// Update and Draw
	demo.Update( 0.0f );
	demo.Render( );
}

static void KeyControl()
{
	LuaConnect.LuaFuncUse("FirstButtonMove()");
}


HRESULT InitWindow(HINSTANCE hInstance, int nCmdShow)
{

	/*UNREFERENCED_PARAMETER( prevInstance );
    UNREFERENCED_PARAMETER( cmdLine );

    WNDCLASSEX wndClass = { 0 };
    wndClass.cbSize = sizeof( WNDCLASSEX ) ;
    wndClass.style = CS_HREDRAW | CS_VREDRAW;
    wndClass.lpfnWndProc = WndProc;
    wndClass.hInstance = hInstance;
    wndClass.hCursor = LoadCursor( NULL, IDC_ARROW );
    wndClass.hbrBackground = ( HBRUSH )( COLOR_WINDOW + 1 );
    wndClass.lpszMenuName = NULL;
    wndClass.lpszClassName = "DX11BookWindowClass";

    if( !RegisterClassEx( &wndClass ) )
        return -1;

    RECT rc = { 0, 0, WindowsWidth,WindowsHeight };
    AdjustWindowRect( &rc, WS_OVERLAPPEDWINDOW, FALSE );

    hwnd = CreateWindowA( "DX11BookWindowClass", "炸弹人超好玩版", WS_OVERLAPPEDWINDOW,
                                CW_USEDEFAULT, CW_USEDEFAULT, rc.right - rc.left, rc.bottom - rc.top,
                                NULL, NULL, hInstance, NULL );

    if( !hwnd )
        return -1;

    ShowWindow( hwnd, cmdShow );*/

    WNDCLASSEX wcex;
    wcex.cbClsExtra = 0;
    wcex.cbSize = sizeof(WNDCLASSEX);
    wcex.cbWndExtra = 0;
    wcex.hbrBackground = (HBRUSH)GetStockObject(BLACK_BRUSH);
    wcex.hCursor = LoadCursor(NULL,IDC_ARROW);
    wcex.hIcon = LoadIcon(hInstance,MAKEINTRESOURCE(IDI_ICON1));
	wcex.hIconSm = LoadIcon(hInstance,MAKEINTRESOURCE(IDI_ICON1));
    wcex.hInstance = hInstance;
    wcex.lpfnWndProc = WndProc;
    wcex.lpszClassName = GameTitle;
    wcex.lpszMenuName = NULL;
    wcex.style = CS_HREDRAW | CS_VREDRAW;
    if (!RegisterClassEx(&wcex))
        return E_FAIL;

    RECT rc = { 0, 0, WindowsWidth,WindowsHeight };
    AdjustWindowRect(&rc, WS_OVERLAPPEDWINDOW, FALSE);
    hwnd = CreateWindowEx(WS_EX_APPWINDOW, GameTitle, GameTitle, WS_OVERLAPPEDWINDOW^WS_THICKFRAME^WS_MAXIMIZEBOX, CW_USEDEFAULT, CW_USEDEFAULT,
        rc.right - rc.left, rc.bottom - rc.top, NULL, NULL, hInstance, NULL);
    if (!hwnd)
        return E_FAIL;
	
    ShowWindow(hwnd, nCmdShow);
    return S_OK;
}

LRESULT CALLBACK WndProc( HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam )
{
    PAINTSTRUCT paintStruct;
    HDC hDC;

    switch( message )
    {
        case WM_PAINT:
            hDC = BeginPaint( hwnd, &paintStruct );
            EndPaint( hwnd, &paintStruct );
            break;

        case WM_DESTROY:
            PostQuitMessage( 0 );
            break;

        default:
            return DefWindowProc( hwnd, message, wParam, lParam );
    }

    return 0;
}