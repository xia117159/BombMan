#pragma once
#include "include.h"

  
#define WAVE_PAUSE                  1  
#define WAVE_RESUME                 2  
  
class CPlayMusic  
{  
public:  
    CPlayMusic(void);  
    ~CPlayMusic(void);  
  
    DWORD InitDevice();  
    DWORD TerminalDevice();  
    DWORD Play(HWND hWnd, LPCTSTR pFileName);  
    DWORD Stop();  
    DWORD Pause();  
  
protected:  
    MCIDEVICEID m_DeviceID;  
    MCIDEVICEID m_ElementID;  
}; 