#include "sysfunc.h"


//�ַ�ת�����������ַ�charת��Ϊ���ַ�wchar_t
wchar_t * AnsiToUnicode( const char* szStr)
{
    int nLen = MultiByteToWideChar( CP_ACP, MB_PRECOMPOSED, szStr, -1, NULL, 0 );
    if (nLen == 0)
    {
            return NULL;
    }
    wchar_t* pResult = new wchar_t[nLen];
    MultiByteToWideChar( CP_ACP, MB_PRECOMPOSED, szStr, -1, pResult, nLen );
    return pResult;
}

//�ַ�ת�������������ַ�wchar_tת��Ϊ�ַ�char
char* UnicodeToAnsi( const wchar_t* szStr )
{
       int nLen = WideCharToMultiByte( CP_ACP, 0, szStr, -1, NULL, 0, NULL, NULL );
       if (nLen == 0)
       { 
            return NULL;
       }
       char* pResult = new char[nLen];
       WideCharToMultiByte( CP_ACP, 0, szStr, -1, pResult, nLen, NULL, NULL );
       return pResult;
}
























