#include"D3DCLASS.h"
static const WCHAR sc_helloWorld[] = L"Œ“ «À≠!";

D3DCLASS::D3DCLASS( ) : driverType_( D3D_DRIVER_TYPE_NULL ), featureLevel_( D3D_FEATURE_LEVEL_11_0 ),
                                d3dDevice_( 0 ), d3dContext_( 0 ), swapChain_( 0 ), backBufferTarget_( 0 ),
								pDWriteFactory_(NULL),pTextFormat_(NULL),
								wszText_(NULL),cTextLength_(NULL),
								pD2DFactory_(NULL),pRT_(NULL),
								pBlackBrush_(NULL)
{

}


D3DCLASS::~D3DCLASS( )
{
    Shutdown( );
}


bool D3DCLASS::Initialize( HINSTANCE hInstance, HWND hwnd )
{
	CreateDeviceIndependentResources();

    hInstance_ = hInstance;
    hwnd_ = hwnd;

    RECT dimensions;
    GetClientRect( hwnd, &dimensions );

    unsigned int width = dimensions.right - dimensions.left;
    unsigned int height = dimensions.bottom - dimensions.top;

    D3D_DRIVER_TYPE driverTypes[] =
    {
        D3D_DRIVER_TYPE_HARDWARE, D3D_DRIVER_TYPE_WARP,
        D3D_DRIVER_TYPE_REFERENCE, D3D_DRIVER_TYPE_SOFTWARE
    };

    unsigned int totalDriverTypes = ARRAYSIZE( driverTypes );

    D3D_FEATURE_LEVEL featureLevels[] =
    {
        D3D_FEATURE_LEVEL_11_0,
        D3D_FEATURE_LEVEL_10_1,
        D3D_FEATURE_LEVEL_10_0
    };

    unsigned int totalFeatureLevels = ARRAYSIZE( featureLevels );

    DXGI_SWAP_CHAIN_DESC swapChainDesc;
    ZeroMemory( &swapChainDesc, sizeof( swapChainDesc ) );
    swapChainDesc.BufferCount = 1;
    swapChainDesc.BufferDesc.Width = width;
    swapChainDesc.BufferDesc.Height = height;
    swapChainDesc.BufferDesc.Format = DXGI_FORMAT_B8G8R8A8_UNORM;
    swapChainDesc.BufferDesc.RefreshRate.Numerator = 60;
    swapChainDesc.BufferDesc.RefreshRate.Denominator = 1;
    swapChainDesc.BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT;
    swapChainDesc.OutputWindow = hwnd;
    swapChainDesc.Windowed = TRUE;
    swapChainDesc.SampleDesc.Count = 1;
    swapChainDesc.SampleDesc.Quality = 0;

    unsigned int creationFlags = 0;

#ifdef _DEBUG
    creationFlags |= D3D11_CREATE_DEVICE_DEBUG;
#endif

    HRESULT result;
    unsigned int driver = 0;

    for( driver = 0; driver < totalDriverTypes; ++driver )
    {
        result = D3D11CreateDevice(0,driverTypes[driver],0,
			D3D11_CREATE_DEVICE_BGRA_SUPPORT,
			featureLevels,totalFeatureLevels,
			D3D11_SDK_VERSION,&d3dDevice_,&featureLevel_,&d3dContext_);
        if( SUCCEEDED( result ) )
        {
            driverType_ = driverTypes[driver];
            break;
        }
    }

    if( FAILED( result ) )
    {
        DXTRACE_MSG( "Failed to create the Direct3D device!" );
        return false;
    }

	IDXGIDevice *pDxgiDevice(NULL);  
	d3dDevice_->QueryInterface(&pDxgiDevice);  
	IDXGIAdapter *pDxgiAdapter(NULL);  
	pDxgiDevice->GetAdapter(&pDxgiAdapter);  
	IDXGIFactory *pDxgiFactory(NULL);  
	pDxgiAdapter->GetParent(IID_PPV_ARGS(&pDxgiFactory)); 

	result = pDxgiFactory->CreateSwapChain(d3dDevice_,&swapChainDesc,&swapChain_);

	IDXGISurface *pBackBuffer = NULL;

	if(SUCCEEDED(result))
	{
		result = swapChain_->GetBuffer(0,IID_PPV_ARGS(&pBackBuffer));
	}


	FLOAT dpiX;
	FLOAT dpiY;
	pD2DFactory_->GetDesktopDpi(&dpiX,&dpiY);

	D2D1_RENDER_TARGET_PROPERTIES props = 
		D2D1::RenderTargetProperties(
			D2D1_RENDER_TARGET_TYPE_DEFAULT,
			D2D1::PixelFormat(DXGI_FORMAT_UNKNOWN,D2D1_ALPHA_MODE_PREMULTIPLIED),
			dpiX,
			dpiY);

	result = pD2DFactory_->CreateDxgiSurfaceRenderTarget(
		pBackBuffer,
		&props,
		&pRT_);

	result = pRT_->CreateSolidColorBrush(
            D2D1::ColorF(D2D1::ColorF::Red),
            &pBlackBrush_
            );

	return true;
}


bool D3DCLASS::LoadContent( )
{
    return true;
}


void D3DCLASS::UnloadContent( )
{
}


void D3DCLASS::Shutdown( )
{
    UnloadContent( );
	SafeRelease(&backBufferTarget_);
	SafeRelease(&swapChain_);
	SafeRelease(&pDWriteFactory_);
	SafeRelease(&d3dContext_);
	SafeRelease(&d3dDevice_);
	SafeRelease(&pTextFormat_);
	SafeRelease(&pD2DFactory_);
	SafeRelease(&pRT_);
	SafeRelease(&pBlackBrush_);
}

void D3DCLASS::Update( float dt )
{

}


void D3DCLASS::Render( )
{
    if( d3dContext_ == 0 )
        return;

    float clearColor[4] = { 0.0f, 0.0f, 0.25f, 1.0f };
    d3dContext_->ClearRenderTargetView( backBufferTarget_, clearColor );
    swapChain_->Present( 0, 0 );
}

HRESULT D3DCLASS::CreateDeviceIndependentResources()
{

	static const WCHAR msc_fontName[] = L"Verdana";
    static const FLOAT msc_fontSize = 50;
	HRESULT hr;

    hr = D2D1CreateFactory(D2D1_FACTORY_TYPE_SINGLE_THREADED, &pD2DFactory_);

	if (SUCCEEDED(hr))
    {
        hr = DWriteCreateFactory(
            DWRITE_FACTORY_TYPE_SHARED,
            __uuidof(pDWriteFactory_),
            reinterpret_cast<IUnknown **>(&pDWriteFactory_)
            );
    }

	if (SUCCEEDED(hr))
    {
        hr = pDWriteFactory_->CreateTextFormat(
            msc_fontName,
            NULL,
            DWRITE_FONT_WEIGHT_NORMAL,
            DWRITE_FONT_STYLE_NORMAL,
            DWRITE_FONT_STRETCH_NORMAL,
            msc_fontSize,
            L"en-us", 
            &pTextFormat_
            );
    }

	if (SUCCEEDED(hr))
    {
        pTextFormat_->SetTextAlignment(DWRITE_TEXT_ALIGNMENT_CENTER);
        pTextFormat_->SetParagraphAlignment(DWRITE_PARAGRAPH_ALIGNMENT_CENTER);

    }
	return true;
}