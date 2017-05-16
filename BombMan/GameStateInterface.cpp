#include "GameStateInterface.h"


struct VertexPos
{
    XMFLOAT3 pos;
    XMFLOAT2 tex0;
};

GameStateInterface::GameStateInterface(LPCSTR path)
{
	ImagePath = path;
}


GameStateInterface::~GameStateInterface(void)
{

}

bool GameStateInterface::LoadContent(HWND hwnd)
{

	RECT WindowSize;
    GetClientRect(hwnd,&WindowSize );

    unsigned int width = WindowSize.right - WindowSize.left;
    unsigned int height = WindowSize.bottom - WindowSize.top;
	HRESULT result;
	
	ID3D11Texture2D* backBufferTexture;

    result = swapChain_->GetBuffer( 0, __uuidof( ID3D11Texture2D ), ( LPVOID* )&backBufferTexture );

    if( FAILED( result ) )
    {
        DXTRACE_MSG( "Failed to get the swap chain back buffer!" );
        return false;
    }
	//创建渲染目标视图
    result = d3dDevice_->CreateRenderTargetView( backBufferTexture, 0, &backBufferTarget_ );

    if( backBufferTexture )
        backBufferTexture->Release( );

    if( FAILED( result ) )
    {
        DXTRACE_MSG( "Failed to create the render target view!" );
        return false;
    }
	//纹理细节
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

    result = d3dDevice_->CreateTexture2D( &depthTexDesc, NULL, &depthTexture_ );
	if( FAILED( result ) )
    {
        DXTRACE_MSG( "CreateTexture2D 失败!" );
        return false;
    }
	//创建深度/模板视图
	D3D11_DEPTH_STENCIL_VIEW_DESC descDSV;
    ZeroMemory( &descDSV, sizeof( descDSV ) );
    descDSV.Format = depthTexDesc.Format;
    descDSV.ViewDimension = D3D11_DSV_DIMENSION_TEXTURE2D;
    descDSV.Texture2D.MipSlice = 0;
	
	result = d3dDevice_->CreateDepthStencilView( depthTexture_, &descDSV, &depthStencilView_ );
	if( FAILED( result ) )
    {
        DXTRACE_MSG( "CreateDepthStencilView 失败!" );
        return false;
    }
	d3dContext_->OMSetRenderTargets( 1, &backBufferTarget_, depthStencilView_ );

    D3D11_VIEWPORT viewport;
    viewport.Width = static_cast<float>( width );
    viewport.Height = static_cast<float>( height );
    viewport.MinDepth = 0.0f;
    viewport.MaxDepth = 1.0f;
    viewport.TopLeftX = 0.0f;
    viewport.TopLeftY = 0.0f;

    d3dContext_->RSSetViewports( 1, &viewport );

	ID3DBlob* buffer = 0;
	bool compileResult = CompileD3DShader( "ColorInversion.fx", 0, "fx_5_0", &buffer );

    if( compileResult == false )
    {
        DXTRACE_MSG( "Error compiling the effect shader!" );
        return false;
    }

    result = D3DX11CreateEffectFromMemory( buffer->GetBufferPointer( ),
        buffer->GetBufferSize( ), 0, d3dDevice_, &effect_ );
    
    if( FAILED( result ) )
    {
        DXTRACE_MSG( "Error creating the effect shader!" );

        if( buffer )
            buffer->Release( );

        return false;
    }
	//着色器布局
	D3D11_INPUT_ELEMENT_DESC solidColorLayout[] =
    {
        { "POSITION", 0, DXGI_FORMAT_R32G32B32_FLOAT, 0, 0, D3D11_INPUT_PER_VERTEX_DATA, 0 },
        { "TEXCOORD", 0, DXGI_FORMAT_R32G32_FLOAT, 0, 12, D3D11_INPUT_PER_VERTEX_DATA, 0 }
    };

	unsigned int totalLayoutElements = ARRAYSIZE( solidColorLayout );

    ID3DX11EffectTechnique* colorInvTechnique;
    colorInvTechnique = effect_->GetTechniqueByName( "ColorInversion" );
    ID3DX11EffectPass* effectPass = colorInvTechnique->GetPassByIndex( 0 );

    D3DX11_PASS_SHADER_DESC passDesc;
    D3DX11_EFFECT_SHADER_DESC shaderDesc;
    effectPass->GetVertexShaderDesc( &passDesc );
    passDesc.pShaderVariable->GetShaderDesc( passDesc.ShaderIndex, &shaderDesc );

    result = d3dDevice_->CreateInputLayout( solidColorLayout, totalLayoutElements,
        shaderDesc.pBytecode, shaderDesc.BytecodeLength, &inputLayout_ );

    buffer->Release( );

    if( FAILED( result ) )
    {
        DXTRACE_MSG( "Error creating the input layout!" );
        return false;
    }

	result = D3DX11CreateShaderResourceViewFromFile( d3dDevice_,
        ImagePath, 0, 0, &colorMap_, 0 );

    if( FAILED( result ) )
    {
        DXTRACE_MSG( "Failed to load the texture image!" );
        return false;
    }

	D3D11_SAMPLER_DESC colorMapDesc;
    ZeroMemory( &colorMapDesc, sizeof( colorMapDesc ) );
    colorMapDesc.AddressU = D3D11_TEXTURE_ADDRESS_WRAP;
    colorMapDesc.AddressV = D3D11_TEXTURE_ADDRESS_WRAP;
    colorMapDesc.AddressW = D3D11_TEXTURE_ADDRESS_WRAP;
    colorMapDesc.ComparisonFunc = D3D11_COMPARISON_NEVER;
    colorMapDesc.Filter = D3D11_FILTER_MIN_MAG_MIP_LINEAR;
    colorMapDesc.MaxLOD = D3D11_FLOAT32_MAX;

    result = d3dDevice_->CreateSamplerState( &colorMapDesc, &colorMapSampler_ );

    if( FAILED( result ) )
    {
        DXTRACE_MSG( "Failed to create color map sampler state!" );
        return false;
    }

	D3D11_BUFFER_DESC vertexDesc;
    ZeroMemory( &vertexDesc, sizeof( vertexDesc ) );
    vertexDesc.Usage = D3D11_USAGE_DYNAMIC;
    vertexDesc.CPUAccessFlags = D3D11_CPU_ACCESS_WRITE;
    vertexDesc.BindFlags = D3D11_BIND_VERTEX_BUFFER;

	const int sizeOfSprite = sizeof( VertexPos ) * 6;
	vertexDesc.ByteWidth = sizeOfSprite * 6;

	result = d3dDevice_->CreateBuffer( &vertexDesc, 0, &vertexBuffer_ );

    if( FAILED( result ) )
    {
        DXTRACE_MSG( "Failed to create vertex buffer!" );
        return false;
    }

	viewMatrix_ = XMMatrixIdentity( );
    projMatrix_ = XMMatrixPerspectiveFovLH( XM_PIDIV4, 1000.0f / 600.0f, 0.01f, 100.0f );

    return true;
}

bool GameStateInterface::DrawButton( )
{
	HRESULT result;
	D3D11_MAPPED_SUBRESOURCE mapResource;
    result = d3dContext_->Map( vertexBuffer_, 0, D3D11_MAP_WRITE_DISCARD, 0, &mapResource );

	if( FAILED( result ) )
    {
        DXTRACE_MSG( "Failed to map resource!" );
        return false;
    }

    // Point to our vertex buffer's internal data.
    VertexPos *spritePtr = ( VertexPos* )mapResource.pData;
	for( int i = 0; i < 6; ++i )
    {
        float thisStartY = 100 + ( 170 * static_cast<float>( i ) );
        float thisEndX = 600;
        float thisEndY = 270;
		float thisStartX = 210;

        spritePtr[0].pos = XMFLOAT3( thisEndX,   thisEndY, 1.0f );
        spritePtr[1].pos = XMFLOAT3( thisEndX,   thisStartY,   1.0f );
        spritePtr[2].pos = XMFLOAT3( thisStartX, thisStartY,   1.0f );
        spritePtr[3].pos = XMFLOAT3( thisStartX, thisStartY,   1.0f );
        spritePtr[4].pos = XMFLOAT3( thisStartX, thisEndY, 1.0f );
        spritePtr[5].pos = XMFLOAT3( thisEndX,   thisEndY, 1.0f );

        
        float tuStartU = 0.0f + ( 390 * static_cast<float>( i ) );
        float tuEndU = tuStartU + 390;

		float tuStartV = 0.0f + ( 170 * static_cast<float>( i ) );
        float tuEndV = tuStartV + 170;

        spritePtr[0].tex0 = XMFLOAT2( tuEndU, 0.0f );
        spritePtr[1].tex0 = XMFLOAT2( tuEndU, 1.0f );
        spritePtr[2].tex0 = XMFLOAT2( tuStartU, 1.0f );
        spritePtr[3].tex0 = XMFLOAT2( tuStartU, 1.0f );
        spritePtr[4].tex0 = XMFLOAT2( tuStartU, 0.0f );
        spritePtr[5].tex0 = XMFLOAT2( tuEndU, 0.0f );

        spritePtr += 6;
    }

	d3dContext_->Unmap( vertexBuffer_, 0 );
    d3dContext_->Draw( 6 * 6, 0 );
}

void GameStateInterface::UnloadContent( )
{
}

void GameStateInterface::Update( float dt )
{
}

void GameStateInterface::Render()
{
	if( d3dContext_ == 0 )
        return;

    float clearColor[4] = { 0.0f, 0.0f, 0.25f, 1.0f };
    d3dContext_->ClearRenderTargetView( backBufferTarget_, clearColor );
    d3dContext_->ClearDepthStencilView( depthStencilView_, D3D11_CLEAR_DEPTH, 1.0f, 0 );

    unsigned int stride = sizeof( VertexPos );
    unsigned int offset = 0;

    d3dContext_->IASetInputLayout( inputLayout_ );
    d3dContext_->IASetVertexBuffers( 0, 1, &vertexBuffer_, &stride, &offset );
    d3dContext_->IASetPrimitiveTopology( D3D11_PRIMITIVE_TOPOLOGY_TRIANGLELIST );

    XMMATRIX rotationMat = XMMatrixRotationRollPitchYaw( 0.0f, 0.0f, 0.0f );
    XMMATRIX translationMat = XMMatrixTranslation( 0.0f, 0.0f, 0.0f );
    XMMATRIX worldMat = rotationMat * translationMat;

    ID3DX11EffectShaderResourceVariable* colorMap;
    colorMap = effect_->GetVariableByName( "colorMap" )->AsShaderResource( );
    colorMap->SetResource( colorMap_ );

    ID3DX11EffectSamplerVariable* colorMapSampler;
    colorMapSampler = effect_->GetVariableByName( "colorSampler" )->AsSampler( );
    colorMapSampler->SetSampler( 0, colorMapSampler_ );

    ID3DX11EffectMatrixVariable* worldMatrix;
    worldMatrix = effect_->GetVariableByName( "worldMatrix" )->AsMatrix( );
    worldMatrix->SetMatrix( ( float* )&worldMat );

    ID3DX11EffectMatrixVariable* viewMatrix;
    viewMatrix = effect_->GetVariableByName( "viewMatrix" )->AsMatrix( );
    viewMatrix->SetMatrix( ( float* )&viewMatrix_ );

    ID3DX11EffectMatrixVariable* projMatrix;
    projMatrix = effect_->GetVariableByName( "projMatrix" )->AsMatrix( );
    projMatrix->SetMatrix( ( float* )&projMatrix_ );

    ID3DX11EffectTechnique* colorInvTechnique;
    colorInvTechnique = effect_->GetTechniqueByName( "ColorInversion" );

    D3DX11_TECHNIQUE_DESC techDesc;
    colorInvTechnique->GetDesc( &techDesc );

    for( unsigned int p = 0; p < techDesc.Passes; p++ )
    {
        ID3DX11EffectPass* pass = colorInvTechnique->GetPassByIndex( p );

        if( pass != 0 )
        {
            pass->Apply( 0, d3dContext_ );
            DrawButton();
        }
    }

    swapChain_->Present( 0, 0 );
}
