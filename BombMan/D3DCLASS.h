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


		IDWriteFactory *pDWriteFactory_; //所有DirectWrite对象的根工厂接口
		IDWriteTextFormat *pTextFormat_; //描述字体家族名称，大小，重量，样式和拉伸用于格式化文本
		const wchar_t *wszText_; //文本字符串
		UINT32 cTextLength_; //字符串长度

		ID2D1Factory *pD2DFactory_; //所有根工厂接口
		ID2D1RenderTarget *pRT_;
		ID2D1SolidColorBrush *pBlackBrush_;
};

#endif