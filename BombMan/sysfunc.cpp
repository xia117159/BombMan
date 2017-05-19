#include "sysfunc.h"


//×Ö·û×ª»»º¯Êý£¬½«×Ö·ûchar×ª»»Îª¿í×Ö·ûwchar_t
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

//×Ö·û×ª»»º¯Êý£¬½«¿í×Ö·ûwchar_t×ª»»Îª×Ö·ûchar
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
























