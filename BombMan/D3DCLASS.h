#ifndef _D3DCLASS_H_
#define _D3DCLASS_H_

#include <d3d11.h>
#include <d3dx11.h>
#include <DxErr.h>
#include <D2D1.h>  
#include <DWrite.h>


template<class Interface>
inline void
SafeRelease(
    Interface **ppInterfaceToRelease
    )
{
    if (*ppInterfaceToRelease != NULL)
    {
        (*ppInterfaceToRelease)->Release();

        (*ppInterfaceToRelease) = NULL;
    }
}

class D3DCLASS
{
    public:
        D3DCLASS();
        ~D3DCLASS();

		HRESULT CreateDeviceIndependentResources();
        bool Initialize( HINSTANCE hInstance, HWND hwnd );
        void Shutdown( );

        bool LoadContent( );
        void UnloadContent( );

        void Update( float dt );
        void Render( );

    protected:
        HINSTANCE hInstance_;
        HWND hwnd_;

        D3D_DRIVER_TYPE driverType_;
        D3D_FEATURE_LEVEL featureLevel_;

        ID3D11Device* d3dDevice_;
        ID3D11DeviceContext* d3dContext_;
        IDXGISwapChain* swapChain_;
        ID3D11RenderTargetView* backBufferTarget_;


		IDWriteFactory *pDWriteFactory_; //����DirectWrite����ĸ������ӿ�
		IDWriteTextFormat *pTextFormat_; //��������������ƣ���С����������ʽ���������ڸ�ʽ���ı�
		const wchar_t *wszText_; //�ı��ַ���
		UINT32 cTextLength_; //�ַ�������

		ID2D1Factory *pD2DFactory_; //���и������ӿ�
		ID2D1RenderTarget *pRT_;
		ID2D1SolidColorBrush *pBlackBrush_;
};

#endif