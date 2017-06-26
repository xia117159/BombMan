#include"D3DCLASS.h"

D3DCLASS::D3DCLASS( ) : driverType_( D3D_DRIVER_TYPE_NULL ), featureLevel_( D3D_FEATURE_LEVEL_11_0 ),
                                d3dDevice_( 0 ), d3dContext_( 0 ), swapChain_( 0 ), backBufferTarget_( 0 ),
								pD2DFactory_(NULL),pRT_(NULL)//,directInput_( 0 ), keyboardDevice_( 0 ), mouseDevice_( 0 )
{

}


D3DCLASS::~D3DCLASS( )
{
    Shutdown( );
}


bool D3DCLASS::Initialize( HINSTANCE hInstance, HWND hwnd )
{
    hInstance_ = hInstance;
    hwnd_ = hwnd;

    RECT dimensions;
    GetClientRect( hwnd, &dimensions );

    unsigned int width = dimensions.right - dimensions.left;
    unsigned int height = dimensions.bottom - dimensions.top;

	//驱动类型枚举
    D3D_DRIVER_TYPE driverTypes[] =
    {
        D3D_DRIVER_TYPE_HARDWARE, D3D_DRIVER_TYPE_WARP,
        D3D_DRIVER_TYPE_REFERENCE, D3D_DRIVER_TYPE_SOFTWARE
    };

    unsigned int totalDriverTypes = ARRAYSIZE( driverTypes );

	//Direct3D设备的功能级别
    D3D_FEATURE_LEVEL featureLevels[] =
    {
        D3D_FEATURE_LEVEL_11_0,
        D3D_FEATURE_LEVEL_10_1,
        D3D_FEATURE_LEVEL_10_0
    };

    unsigned int totalFeatureLevels = ARRAYSIZE( featureLevels );

	//设置交换链
    DXGI_SWAP_CHAIN_DESC swapChainDesc;
    ZeroMemory( &swapChainDesc, sizeof( swapChainDesc ) );
    swapChainDesc.BufferCount = 1; //交换链缓存数量
    swapChainDesc.BufferDesc.Width = width; //宽度
    swapChainDesc.BufferDesc.Height = height; //高度
    swapChainDesc.BufferDesc.Format = DXGI_FORMAT_B8G8R8A8_UNORM; //DXGI_FORMAT结构描述的显示格式
    swapChainDesc.BufferDesc.RefreshRate.Numerator = 60;   //赫兹刷新率
    swapChainDesc.BufferDesc.RefreshRate.Denominator = 1;  //赫兹刷新率
    swapChainDesc.BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT; //描述后台缓存的表面用法和CPU访问设置
    swapChainDesc.OutputWindow = hwnd; //输出Window的窗口句柄
    swapChainDesc.Windowed = TRUE; //窗口模式显示
    swapChainDesc.SampleDesc.Count = 1;  //每个像素的多采样数
    swapChainDesc.SampleDesc.Quality = 0; //图像质量等级

    unsigned int creationFlags = 0;

#ifdef _DEBUG
    creationFlags |= D3D11_CREATE_DEVICE_DEBUG;
#endif

    HRESULT result;
    unsigned int driver = 0;
	//创建Direct2D资源的工厂对象
	D2D1CreateFactory(D2D1_FACTORY_TYPE_SINGLE_THREADED, &pD2DFactory_);

    for( driver = 0; driver < totalDriverTypes; ++driver )
    {
		//创建Direct设备
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
        DXTRACE_MSG( L"Failed to create the Direct3D device!" );
        return false;
    }

	IDXGIDevice *pDxgiDevice(NULL);  
	d3dDevice_->QueryInterface(&pDxgiDevice);  
	IDXGIAdapter *pDxgiAdapter(NULL);  
	pDxgiDevice->GetAdapter(&pDxgiAdapter);  
	IDXGIFactory *pDxgiFactory(NULL);  
	pDxgiAdapter->GetParent(IID_PPV_ARGS(&pDxgiFactory)); 

	//创建交换链
	result = pDxgiFactory->CreateSwapChain(d3dDevice_,&swapChainDesc,&swapChain_);

	IDXGISurface *pBackBuffer = NULL;

	if(SUCCEEDED(result))
	{
		//获取缓存指针
		result = swapChain_->GetBuffer(0,IID_PPV_ARGS(&pBackBuffer));
	}

	FLOAT dpiX;
	FLOAT dpiY;
	pD2DFactory_->GetDesktopDpi(&dpiX,&dpiY); //获取桌面DPI

	//渲染目标的渲染选项（硬件或软件），像素格式，DPI信息，远程处理选项和Direct3D支持要求
	D2D1_RENDER_TARGET_PROPERTIES props = 
		D2D1::RenderTargetProperties(
			D2D1_RENDER_TARGET_TYPE_DEFAULT,
			D2D1::PixelFormat(DXGI_FORMAT_UNKNOWN,D2D1_ALPHA_MODE_PREMULTIPLIED),
			dpiX,
			dpiY);
	//创建绘制到DirectX图形基础架构（DXGI）曲面的渲染目标
	result = pD2DFactory_->CreateDxgiSurfaceRenderTarget(
		pBackBuffer,
		&props,
		&pRT_);

	if( FAILED( result ) )
	{
		DXTRACE_MSG( L"Failed to create!" );
		return false;
	}
	
	ID3D11Texture2D* backBufferTexture;

	result = swapChain_->GetBuffer( 0, __uuidof( ID3D11Texture2D ), ( LPVOID* )&backBufferTexture );

	if( FAILED( result ) )
	{
		DXTRACE_MSG( L"Failed to get the swap chain back buffer!" );
		return false;
	}
	//创建渲染目标视图
	result = d3dDevice_->CreateRenderTargetView( backBufferTexture, 0, &backBufferTarget_ );

	if( backBufferTexture )
		backBufferTexture->Release( );

	if( FAILED( result ) )
	{
		DXTRACE_MSG( L"Failed to create the render target view!" );
		return false;
	}
	//2D纹理
	D3D11_TEXTURE2D_DESC depthTexDesc;
    ZeroMemory( &depthTexDesc, sizeof( depthTexDesc ) );
    depthTexDesc.Width = width;
    depthTexDesc.Height = height;
    depthTexDesc.MipLevels = 1;
    depthTexDesc.ArraySize = 1;
    depthTexDesc.Format = DXGI_FORMAT_D24_UNORM_S8_UINT;
    depthTexDesc.SampleDesc.Count = 1;
    depthTexDesc.SampleDesc.Quality = 0;
    depthTexDesc.Usage = D3D11_USAGE_DEFAULT;
    depthTexDesc.BindFlags = D3D11_BIND_DEPTH_STENCIL;
    depthTexDesc.CPUAccessFlags = 0;
    depthTexDesc.MiscFlags = 0;
	//创建2D纹理
    result = d3dDevice_->CreateTexture2D( &depthTexDesc, NULL, &depthTexture_ );

    if( FAILED( result ) )
    {
        DXTRACE_MSG( L"Failed to create the depth texture!" );
        return false;
    }

    // 创建深度模板视图
    D3D11_DEPTH_STENCIL_VIEW_DESC descDSV;
    ZeroMemory( &descDSV, sizeof( descDSV ) );
    descDSV.Format = depthTexDesc.Format;
    descDSV.ViewDimension = D3D11_DSV_DIMENSION_TEXTURE2D;
    descDSV.Texture2D.MipSlice = 0;

    result = d3dDevice_->CreateDepthStencilView( depthTexture_, &descDSV, &depthStencilView_ );

    if( FAILED( result ) )
    {
        DXTRACE_MSG( L"Failed to create the depth stencil target view!" );
        return false;
    }
	
	d3dContext_->OMSetRenderTargets( 1, &backBufferTarget_, depthStencilView_ );
	//定义视口的尺寸
	D3D11_VIEWPORT viewport;
	viewport.Width = static_cast<float>( width );
	viewport.Height = static_cast<float>( height );
	viewport.MinDepth = 0.0f;
	viewport.MaxDepth = 1.0f;
	viewport.TopLeftX = 0.0f;
	viewport.TopLeftY = 0.0f;

	d3dContext_->RSSetViewports( 1, &viewport );


	return LoadContent(hwnd);;
}



bool D3DCLASS::CompileD3DShader( LPCWSTR filePath, char* entry, char* shaderModel, ID3DBlob** buffer )
{
    DWORD shaderFlags = D3DCOMPILE_ENABLE_STRICTNESS;

#if defined( DEBUG ) || defined( _DEBUG )
    shaderFlags |= D3DCOMPILE_DEBUG;
#endif

    ID3DBlob* errorBuffer = 0;
    HRESULT result;
	//编译着色器和效果
    result = D3DX11CompileFromFile( filePath, 0, 0, entry, shaderModel,
        shaderFlags, 0, 0, buffer, &errorBuffer, 0 );

    if( FAILED( result ) )
    {
        if( errorBuffer != 0 )
        {
            OutputDebugStringA( ( char* )errorBuffer->GetBufferPointer( ) );
            errorBuffer->Release( );
        }

        return false;
    }
    
    if( errorBuffer != 0 )
        errorBuffer->Release( );

    return true;
}

bool D3DCLASS::LoadContent(HWND hwnd)
{
    return true;
}


void D3DCLASS::UnloadContent( )
{
}


void D3DCLASS::Shutdown( )
{
	SafeRelease(&backBufferTarget_);
	SafeRelease(&swapChain_);
	SafeRelease(&d3dContext_);
	SafeRelease(&d3dDevice_);
	SafeRelease(&pD2DFactory_);
	SafeRelease(&pRT_);
	SafeRelease(&depthStencilView_);
	SafeRelease(&depthTexture_);
}

void D3DCLASS::Update( float dt )
{

}


void D3DCLASS::Render( )
{
}
