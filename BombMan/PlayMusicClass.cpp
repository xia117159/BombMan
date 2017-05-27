#include "PlayMusicClass.h"  

  
#pragma comment(lib, "winmm.lib")  
  
CPlayMusic::CPlayMusic(void)  
{  
    m_DeviceID  = 0;  
    m_ElementID = 0;  
    InitDevice();  
}  
  
CPlayMusic::~CPlayMusic(void)  
{  
    if (m_ElementID)  
    {  
        Stop();  
    }  
  
    if (m_DeviceID)  
    {  
        TerminalDevice();  
    }  
}  
  
DWORD CPlayMusic::InitDevice()  
{  
    DWORD dwResult = 0;  
    if (m_DeviceID == 0)  
    {  
        MCI_OPEN_PARMS mciInitParms;  
        mciInitParms.lpstrDeviceType = (LPTSTR)MCI_DEVTYPE_WAVEFORM_AUDIO;  
        dwResult = mciSendCommand(NULL, MCI_OPEN, MCI_OPEN_TYPE | MCI_OPEN_TYPE_ID | MCI_WAIT,   
            (DWORD)(LPVOID)&mciInitParms);  
        m_DeviceID = mciInitParms.wDeviceID;  
    }  
  
    return dwResult;  
}  
  
DWORD CPlayMusic::TerminalDevice()  
{  
    DWORD dwResult = 0;  
      
    if (m_DeviceID)  
    {  
        dwResult = mciSendCommand(m_DeviceID, MCI_CLOSE, NULL, NULL);  
    }  
  
    m_DeviceID = 0;  
    return dwResult;  
}  
  
DWORD CPlayMusic::Play(HWND hWnd, LPCTSTR pFileName)  
{  
    MCI_OPEN_PARMS mciOpenParms;  
    memset(&mciOpenParms, 0, sizeof(MCI_OPEN_PARMS));  
    mciOpenParms.lpstrElementName = pFileName;  
      
    DWORD dwResult = 0;  
    dwResult = mciSendCommand(m_DeviceID, MCI_OPEN, MCI_OPEN_ELEMENT,  
        (DWORD)(LPVOID)&mciOpenParms);  
	if (!dwResult)  
    {  
        m_ElementID = mciOpenParms.wDeviceID;  
          
        MCI_PLAY_PARMS mciPlayParms;  
        mciPlayParms.dwCallback = (DWORD)hWnd;
        dwResult = mciSendCommand(m_ElementID, MCI_PLAY, 0, (DWORD)(LPVOID)&mciPlayParms);  
    }  
  
    return dwResult;  
}  
  
DWORD CPlayMusic::Stop()  
{  
    DWORD dwResult = 0;  
  
    if (m_ElementID)  
    {  
        dwResult = mciSendCommand(m_ElementID, MCI_CLOSE, NULL, NULL);  
        m_ElementID = 0;  
    }  
  
    return dwResult;  
}  
  
DWORD CPlayMusic::Pause()  
{  
    DWORD dwResult = 0;  
    static BOOL bPlayMode = TRUE;  
  
    if (m_ElementID)  
    {  
        if (bPlayMode)  
        {     
            dwResult = mciSendCommand(m_ElementID, MCI_PAUSE, NULL, NULL);  
            dwResult = WAVE_PAUSE;  
        }  
        else  
        {  
            dwResult = mciSendCommand(m_ElementID, MCI_RESUME, NULL, NULL);  
            dwResult = WAVE_RESUME;  
        }  
  
        bPlayMode = !bPlayMode;       
    }  
  
    return dwResult;  
}  