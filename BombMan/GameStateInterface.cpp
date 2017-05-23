#include "GameStateInterface.h"
#include "luaClass.h"
#include "sysfunc.h"


extern LuaClass LuaConnect;


struct VertexPos
{
    XMFLOAT3 pos;
    XMFLOAT2 tex0;

};


GameStateInterface::GameStateInterface() : effect_(0),inputLayout_(0),ImageMap_(0),colorMapSampler_(0),
										   vertexBuffer_(0),alphaBlendState_(0),/*,BackGroundImage_(0),*/mvpCB_(0)
{
	ImagePath = NULL;
}







GameStateInterface::~GameStateInterface(void)
{


}

bool GameStateInterface::LoadContent(HWND hwnd)
{
	HRESULT result;
	ID3DBlob* buffer = 0;
	bool compileResult = CompileD3DShader( L"StartInterface.fx", 0, "fx_5_0", &buffer );

	if( compileResult == false )
	{
		DXTRACE_MSG( L"Error compiling the effect shader!" );
		return false;
	}

	result = D3DX11CreateEffectFromMemory( buffer->GetBufferPointer( ),
		buffer->GetBufferSize( ), 0, d3dDevice_, &effect_ );
    
	if( FAILED( result ) )
	{
		DXTRACE_MSG( L"Error creating the effect shader!" );

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
	colorInvTechnique = effect_->GetTechniqueByName( "StartInterface" );
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
		DXTRACE_MSG( L"Error creating the input layout!" );
		return false;
	}

	result = D3DX11CreateShaderResourceViewFromFile( d3dDevice_,
		ImagePath, 0, 0, &ImageMap_, 0 );

	if( FAILED( result ) )
	{
		DXTRACE_MSG( L"Failed to load the texture image!" );
		return false;
	}

	//result = D3DX11CreateShaderResourceViewFromFile( d3dDevice_,
	//	BackGroundImage, 0, 0, &BackGroundImage_, 0 );

	//if( FAILED( result ) )
	//{
	//	DXTRACE_MSG( L"Failed to load the texture image!" );
	//	return false;
	//}

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
		DXTRACE_MSG( L"Failed to create color map sampler state!" );
		return false;
	}

	D3D11_BUFFER_DESC vertexDesc;
	ZeroMemory( &vertexDesc, sizeof( vertexDesc ) );
	vertexDesc.Usage = D3D11_USAGE_DYNAMIC;
	vertexDesc.CPUAccessFlags = D3D11_CPU_ACCESS_WRITE;
	vertexDesc.BindFlags = D3D11_BIND_VERTEX_BUFFER;

	const int sizeOfSprite = sizeof( VertexPos ) * 6;
	vertexDesc.ByteWidth = sizeOfSprite * 7;

	result = d3dDevice_->CreateBuffer( &vertexDesc, 0, &vertexBuffer_ );

	if( FAILED( result ) )
	{
		DXTRACE_MSG( L"Failed to create vertex buffer!" );
		return false;
	}

	D3D11_BUFFER_DESC constDesc;
	ZeroMemory( &constDesc, sizeof( constDesc ) );
	constDesc.BindFlags = D3D11_BIND_CONSTANT_BUFFER;
	constDesc.ByteWidth = sizeof( XMMATRIX );
	constDesc.Usage = D3D11_USAGE_DEFAULT;

	result = d3dDevice_->CreateBuffer( &constDesc, 0, &mvpCB_ );

	if( FAILED( result ) )
    {
        return false;
    }

	XMMATRIX view = XMMatrixIdentity( );
    XMMATRIX projection = XMMatrixOrthographicOffCenterLH( 0.0f, 1000.0f, 0.0f, 600.0f, 0.1f, 100.0f );
    vpMatrix_ = XMMatrixMultiply( view, projection );

	D3D11_BLEND_DESC blendDesc;
	ZeroMemory( &blendDesc, sizeof( blendDesc ) );
	blendDesc.RenderTarget[0].BlendEnable = TRUE;
	blendDesc.RenderTarget[0].BlendOp = D3D11_BLEND_OP_ADD;
	blendDesc.RenderTarget[0].SrcBlend = D3D11_BLEND_ONE;
	blendDesc.RenderTarget[0].DestBlend = D3D11_BLEND_ZERO;
	blendDesc.RenderTarget[0].BlendOpAlpha = D3D11_BLEND_OP_ADD;
	blendDesc.RenderTarget[0].SrcBlendAlpha = D3D11_BLEND_ZERO;
	blendDesc.RenderTarget[0].DestBlendAlpha = D3D11_BLEND_ZERO;
	blendDesc.RenderTarget[0].RenderTargetWriteMask = 0x0F;

	float blendFactor[4] = { 0.0f, 0.0f, 0.0f, 0.0f };

	d3dDevice_->CreateBlendState( &blendDesc, &alphaBlendState_ );
	d3dContext_->OMSetBlendState( alphaBlendState_, blendFactor, 0xFFFFFFFF );

	return true;
}

bool GameStateInterface::DrawButton(float ButtonStartX,float ButtonStartY, float tuX, float tuY)
{
	HRESULT result;
	D3D11_MAPPED_SUBRESOURCE mapResource;
    result = d3dContext_->Map( vertexBuffer_, 0, D3D11_MAP_WRITE_DISCARD, 0, &mapResource );

	if( FAILED( result ) )
    {
        DXTRACE_MSG( L"Failed to map resource!" );
        return false;
    }
   

    VertexPos *spritePtr = ( VertexPos* )mapResource.pData;


	float thisStartX = ButtonStartX + ( ButtonWidthF * static_cast<float>( 0 ) );
	float thisEndX = thisStartX + ButtonWidthF;

	float thisStartY = ButtonStartY + ( ButtonHeightF * static_cast<float>( 0 ) );
	float thisEndY = thisStartY + ButtonHeightF;

	spritePtr[0].pos = XMFLOAT3( thisEndX,   thisEndY,   0.0f );
	spritePtr[1].pos = XMFLOAT3( thisEndX,   thisStartY, 0.0f );
	spritePtr[2].pos = XMFLOAT3( thisStartX, thisStartY, 0.0f );
	spritePtr[3].pos = XMFLOAT3( thisStartX, thisStartY, 0.0f );
	spritePtr[4].pos = XMFLOAT3( thisStartX, thisEndY,   0.0f );
	spritePtr[5].pos = XMFLOAT3( thisEndX,   thisEndY,   0.0f );
  
	float tuStartU = tuX + ( tuWidth * static_cast<float>( 0 ) );
	float tuEndU = tuStartU + tuWidth;

	float tuStartV = tuY + ( tuHeight * static_cast<float>( 0 ) );
	float tuEndV = tuStartV + tuHeight;

	spritePtr[0].tex0 = XMFLOAT2( tuEndU,   tuStartV);
	spritePtr[1].tex0 = XMFLOAT2( tuEndU,   tuEndV);
	spritePtr[2].tex0 = XMFLOAT2( tuStartU, tuEndV );
	spritePtr[3].tex0 = XMFLOAT2( tuStartU, tuEndV );
	spritePtr[4].tex0 = XMFLOAT2( tuStartU, tuStartV );
	spritePtr[5].tex0 = XMFLOAT2( tuEndU,   tuStartV );
	d3dContext_->Unmap( vertexBuffer_, 0 );
	d3dContext_->Draw( 6, 0 );
	return true;
}

bool GameStateInterface::DrawBackGround()
{
	HRESULT result;
	D3D11_MAPPED_SUBRESOURCE mapResource;
    result = d3dContext_->Map( vertexBuffer_, 0, D3D11_MAP_WRITE_DISCARD, 0, &mapResource );

	if( FAILED( result ) )
    {
        DXTRACE_MSG( L"Failed to map resource!" );
        return false;
    }

	XMFLOAT2 sprite1Pos( 0.0f, 0.0f );
    image[0].SetPosition( sprite1Pos );

    float halfWidth = 1000;
    float halfHeight = 600;

    VertexPos *spritePtr = ( VertexPos* )mapResource.pData;
	
	spritePtr[0].pos =XMFLOAT3(  halfWidth, halfHeight, 1.0f );
    spritePtr[1].pos =XMFLOAT3(  halfWidth, 0,          1.0f );
    spritePtr[2].pos =XMFLOAT3(  0,         0,          1.0f );

    spritePtr[3].pos =XMFLOAT3(  0,         0,          1.0f );
    spritePtr[4].pos =XMFLOAT3(  0,         halfHeight, 1.0f );
    spritePtr[5].pos =XMFLOAT3(  halfWidth, halfHeight, 1.0f );

	spritePtr[0].tex0 = XMFLOAT2( 1.0f, 0.0f );
	spritePtr[1].tex0 = XMFLOAT2( 1.0f, 1.0f );
	spritePtr[2].tex0 = XMFLOAT2( 0.0f, 1.0f );
	spritePtr[3].tex0 = XMFLOAT2( 0.0f, 1.0f );
	spritePtr[4].tex0 = XMFLOAT2( 0.0f, 0.0f );
	spritePtr[5].tex0 = XMFLOAT2( 1.0f, 0.0f );

	XMMATRIX world = image[0].GetWorldMatrix( );
    XMMATRIX mvp = XMMatrixMultiply( world, vpMatrix_ );
    mvp = XMMatrixTranspose( mvp );

    d3dContext_->UpdateSubresource( mvpCB_, 0, 0, &mvp, 0, 0 );
    d3dContext_->VSSetConstantBuffers( 0, 1, &mvpCB_ );

	d3dContext_->Unmap( vertexBuffer_, 0 );
	d3dContext_->Draw( 6, 0 );
	return  true;
}

bool GameStateInterface::DrawImage(float StartX,float StartY, float Width, float Height,float tuStartX, float tuEndX, float tuStartY, float tuEndY, float Priority)
{
	HRESULT result;
	D3D11_MAPPED_SUBRESOURCE mapResource;
    result = d3dContext_->Map( vertexBuffer_, 0, D3D11_MAP_WRITE_DISCARD, 0, &mapResource );

	if( FAILED( result ) )
    {
        DXTRACE_MSG( L"Failed to map resource!" );
        return false;
    }

	XMFLOAT2 sprite1Pos( StartX, StartY);
    image[0].SetPosition( sprite1Pos );

    VertexPos *spritePtr = ( VertexPos* )mapResource.pData;
	
	spritePtr[0].pos =XMFLOAT3(  Width, Height, Priority );
    spritePtr[1].pos =XMFLOAT3(  Width, 0,      Priority );
    spritePtr[2].pos =XMFLOAT3(  0,     0,      Priority );
    spritePtr[3].pos =XMFLOAT3(  0,     0,      Priority );
    spritePtr[4].pos =XMFLOAT3(  0,     Height, Priority );
    spritePtr[5].pos =XMFLOAT3(  Width, Height, Priority );


	spritePtr[0].tex0 = XMFLOAT2( tuEndX,   tuStartY);
	spritePtr[1].tex0 = XMFLOAT2( tuEndX,   tuEndY);
	spritePtr[2].tex0 = XMFLOAT2( tuStartX,	tuEndY );
	spritePtr[3].tex0 = XMFLOAT2( tuStartX,	tuEndY );
	spritePtr[4].tex0 = XMFLOAT2( tuStartX, tuStartY );
	spritePtr[5].tex0 = XMFLOAT2( tuEndX,   tuStartY );

	XMMATRIX world = image[0].GetWorldMatrix( );
    XMMATRIX mvp = XMMatrixMultiply( world, vpMatrix_ );
    mvp = XMMatrixTranspose( mvp );

    d3dContext_->UpdateSubresource( mvpCB_, 0, 0, &mvp, 0, 0 );
    d3dContext_->VSSetConstantBuffers( 0, 1, &mvpCB_ );

	d3dContext_->Unmap( vertexBuffer_, 0 );
	d3dContext_->Draw( 6, 0 );

	return  true;
}



void GameStateInterface::UnloadContent( )
{
}

void GameStateInterface::Update( float dt)
{

}


float tempUD = 0.0, tempLR = 0.0;


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

    

    ID3DX11EffectSamplerVariable* colorMapSampler;
    colorMapSampler = effect_->GetVariableByName( "colorSampler" )->AsSampler( );
    colorMapSampler->SetSampler( 0, colorMapSampler_ );

	

    ID3DX11EffectTechnique* colorInvTechnique;
    colorInvTechnique = effect_->GetTechniqueByName( "StartInterface" );

    D3DX11_TECHNIQUE_DESC techDesc;
    colorInvTechnique->GetDesc( &techDesc );

    for( unsigned int p = 0; p < techDesc.Passes; p++ )
    {
        ID3DX11EffectPass* pass = colorInvTechnique->GetPassByIndex( p );
		pass->Apply( 0, d3dContext_ );
        if( pass != 0 && p == 0)
        {
			//DrawBackGround();
			/*ID3DX11EffectShaderResourceVariable* BackGroundMap;
			BackGroundMap = effect_->GetVariableByName( "secondMap" )->AsShaderResource( );
			BackGroundMap->SetResource( BackGroundImage_ );
			DrawImage(0, 0, 1000, 600, 1.0f, 1.0f, 0.3f);*/

			//LuaButtonShow.LuaCloseFile();
        }
		if( pass != 0 && p == 1)
		{
			ID3DX11EffectShaderResourceVariable* colorMap;
			colorMap = effect_->GetVariableByName( "firstMap" )->AsShaderResource( );
			colorMap->SetResource( ImageMap_ );
			//DrawImage(0, 0, 500, 300, 1.0f, 1.0f, 0.2f);
			LuaConnect.LuaFuncUse("DrawButtonFunc()");
		}
    }
    swapChain_->Present( 0, 0 );
}

void GameStateInterface::SetImagePath(LPCWSTR Path)
{
	ImagePath = Path;

}

void GameStateInterface::SetBackGroundPath(LPCWSTR Path)
{
	BackGroundImage = Path;
}





