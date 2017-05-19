#ifndef _D3DCLASS_H_
#define _D3DCLASS_H_

#include "include.h"



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

		bool CompileD3DShader( LPCWSTR filePath, char* entry, char* shaderModel, ID3DBlob** buffer );

        virtual bool LoadContent(HWND hwnd);
        virtual void UnloadContent( );

        virtual void Update( float dt );
        virtual void Render( );

    protected:
        HINSTANCE hInstance_;
        HWND hwnd_;

        D3D_DRIVER_TYPE driverType_;
        D3D_FEATURE_LEVEL featureLevel_;

        ID3D11Device* d3dDevice_;
        ID3D11DeviceContext* d3dContext_;
        IDXGISwapChain* swapChain_;
        ID3D11RenderTargetView* backBufferTarget_;
		ID2D1Factory *pD2DFactory_; //所有根工厂接口
		ID2D1RenderTarget *pRT_;
};

#endif