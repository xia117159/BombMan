#include "include.h"
#include "MouseControl.h"
#include "KeyBoard.h"
#include "GameStateInterface.h"
#include "sysfunc.h"
#include "PlayMusicClass.h"

//*******************ȫ�ֱ���������*******************
//���ھ������
HWND hwnd = NULL;
GameStateInterface demo;

LuaClass LuaConnect;//ȫ��lua�ӿ����Ӷ���
KeyBoard TempKeyDetect;
MouseControl MouseDetect;
CPlayMusic BGMPlayMusicDevice;
CPlayMusic SEPlayMusicDevice;

const char * KeyFunc = NULL;
const char * MouseSetPosFunc = NULL;

//************************����************************
//*********************����������*********************
LRESULT CALLBACK WndProc( HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam );
HRESULT InitWindow(HINSTANCE hInstance, int nCmdShow);
static void MainMenuLoop();
static void KeyControl();
void LuaInterfaceInit();

//************************����************************

int WINAPI wWinMain( HINSTANCE hInstance, HINSTANCE prevInstance, LPWSTR cmdLine, int cmdShow )
{
	

	if (FAILED(InitWindow(hInstance, cmdShow)))
        return 0;

    // Demo Initialize
    bool result = demo.Initialize( hInstance, hwnd );

	if( result == false )
        return -1;

	SEPlayMusicDevice.InitDevice();
	BGMPlayMusicDevice.InitDevice();

	LuaInterfaceInit();

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
			const int constFps = 100;
			float timeInOneFps = 1000.0f/constFps;    // ÿ��60֡����1֡����Լ16����
			DWORD timeBegin = GetTickCount();
			
		    //��ѭ������
			MainMenuLoop();
 
			// ��֡
			DWORD timeTotal = GetTickCount() - timeBegin;
			if (timeTotal < timeInOneFps)
				Sleep(DWORD(timeInOneFps-timeTotal));
		}
    }
    // Demo Shutdown
    demo.Shutdown( );

    return static_cast<int>( msg.wParam );
}

//���˵�ѭ������
static void MainMenuLoop()
{
	MouseDetect.UpdateMousePos();
	if(demo.GetNode() != 0)
	{
		KeyControl();
		// Update and Draw
		demo.Update( 0.0f );
		demo.Render( );
	}
}



static void KeyControl()
{
	LuaConnect.LuaFuncUse("KeyFunc()");
	LuaConnect.LuaFuncUse("MousePosSet(%d%d)", MouseDetect.GetMouseX(), MouseDetect.GetMouseY());
}


HRESULT InitWindow(HINSTANCE hInstance, int nCmdShow)
{


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