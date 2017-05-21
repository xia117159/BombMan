#include "GameStateInterface.h"
#include "luaClass.h"
#include "sysfunc.h"

static int LuaDrawButton(lua_State *L);
static int LuaInitStartViewIamgePath(lua_State *L);



struct VertexPos
{
    XMFLOAT3 pos;
    XMFLOAT2 tex0;

};


GameStateInterface::GameStateInterface() : effect_(0),inputLayout_(0),colorMap_(0),colorMapSampler_(0),
										   vertexBuffer_(0),solidColorVS_(0),solidColorPS_(0),
										   alphaBlendState_(0),BackGroundImage_(0)
{
	BackGroundImage = ImagePath = NULL;
	LuaClass setImagePath("lua/StartButton.lua");
	setImagePath.CFuncRegister("LuaInitStartViewIamgePath", LuaInitStartViewIamgePath);
	setImagePath.LuaDoFile();
	setImagePath.LuaFuncUse("SetButtonImagePath()");
	setImagePath.LuaCloseFile();
	LuaButtonShow.SetLuaFile("lua/StartButton.lua");
	LuaButtonShow.CFuncRegister("LuaDrawButton", LuaDrawButton);
	LuaButtonShow.LuaDoFile();

}


GameStateInterface::~GameStateInterface(void)
{

}

bool GameStateInterface::LoadContent(HWND hwnd)
{
	HRESULT result;
	ID3DBlob* buffer = 0;
	bool compileResult = CompileD3DShader( L"ColorInversion.fx", 0, "fx_5_0", &buffer );

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
		DXTRACE_MSG( L"Error creating the input layout!" );
		return false;
	}

	result = D3DX11CreateShaderResourceViewFromFile( d3dDevice_,
		ImagePath, 0, 0, &colorMap_, 0 );

	if( FAILED( result ) )
	{
		DXTRACE_MSG( L"Failed to load the texture image!" );
		return false;
	}

	result = D3DX11CreateShaderResourceViewFromFile( d3dDevice_,
		BackGroundImage, 0, 0, &BackGroundImage_, 0 );

	if( FAILED( result ) )
	{
		DXTRACE_MSG( L"Failed to load the texture image!" );
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
   

    VertexPos *spritePtr = ( VertexPos* )mapResource.pData;
	
	spritePtr[0].pos = XMFLOAT3(  1.0f,  1.0f, 0.9f );
	spritePtr[1].pos = XMFLOAT3(  1.0f, -1.0f, 0.9f );
	spritePtr[2].pos = XMFLOAT3( -1.0f, -1.0f, 0.9f );
	spritePtr[3].pos = XMFLOAT3( -1.0f, -1.0f, 0.9f );
	spritePtr[4].pos = XMFLOAT3( -1.0f,  1.0f, 0.9f );
	spritePtr[5].pos = XMFLOAT3(  1.0f,  1.0f, 0.9f );

	spritePtr[0].tex0 = XMFLOAT2( 1.0f, 0.0f );
	spritePtr[1].tex0 = XMFLOAT2( 1.0f, 1.0f );
	spritePtr[2].tex0 = XMFLOAT2( 0.0f, 1.0f );
	spritePtr[3].tex0 = XMFLOAT2( 0.0f, 1.0f );
	spritePtr[4].tex0 = XMFLOAT2( 0.0f, 0.0f );
	spritePtr[5].tex0 = XMFLOAT2( 1.0f, 0.0f );
	d3dContext_->Unmap( vertexBuffer_, 0 );
	d3dContext_->Draw( 6, 0 );
	return  true;
}


void GameStateInterface::UnloadContent( )
{
}

void GameStateInterface::Update( float dt )
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

    ID3DX11EffectShaderResourceVariable* colorMap;
    colorMap = effect_->GetVariableByName( "colorMap" )->AsShaderResource( );
    colorMap->SetResource( colorMap_ );

    ID3DX11EffectSamplerVariable* colorMapSampler;
    colorMapSampler = effect_->GetVariableByName( "colorSampler" )->AsSampler( );
    colorMapSampler->SetSampler( 0, colorMapSampler_ );

	ID3DX11EffectShaderResourceVariable* BackGroundMap;
    BackGroundMap = effect_->GetVariableByName( "secondMap" )->AsShaderResource( );
    BackGroundMap->SetResource( BackGroundImage_ );

    ID3DX11EffectTechnique* colorInvTechnique;
    colorInvTechnique = effect_->GetTechniqueByName( "ColorInversion" );

    D3DX11_TECHNIQUE_DESC techDesc;
    colorInvTechnique->GetDesc( &techDesc );

    for( unsigned int p = 0; p < techDesc.Passes; p++ )
    {
        ID3DX11EffectPass* pass = colorInvTechnique->GetPassByIndex( p );

        if( pass != 0 && p == 0)
        {
            pass->Apply( 0, d3dContext_ );
			DrawBackGround();
			
			//LuaButtonShow.LuaCloseFile();
        }
		if( pass != 0 && p == 1)
		{
			pass->Apply( 0, d3dContext_ );
			LuaButtonShow.LuaFuncUse("DrawButtonFunc()");
		}
    }

	
    swapChain_->Present( 0, 0 );
}

void GameStateInterface::SetButtonPath(LPCWSTR Path)
{
	ImagePath = Path;
}

void GameStateInterface::SetBackGroundPath(LPCWSTR Path)
{
	BackGroundImage = Path;
}

extern GameStateInterface demo;


//提供给Lua调用的函数的接口
//定义第一方法：返回值必须为int,参数必须为lua_State *L，（L）可变
static int LuaDrawButton(lua_State *L)
{
	 //返回栈中元素的个数  
    int n = lua_gettop(L);
    float Value[4];  
    int i;  
    for (i = 1; i <= n; i++)  
    {  
        if (!lua_isnumber(L, i))   
        {  
            lua_pushstring(L, "Incorrect argument to 'average'");  
            lua_error(L);
			return 0;
        }  
        Value[i-1] = (float)lua_tonumber(L, i);
    }
	demo.DrawButton(Value[0],Value[1],Value[2],Value[3]);
	return 1;
}


//提供给Lua调用的函数的接口
//定义第一方法：返回值必须为int,参数必须为lua_State *L，（L）可变
static int LuaInitStartViewIamgePath(lua_State *L)
{
	 //返回栈中元素的个数  
    int n = lua_gettop(L);

	const size_t newsize = 100;
	int i;  
    for (i = 1; i <= n; i++)  
    {  
        if (!lua_isstring(L, i))   
        {  
            lua_pushstring(L, "Incorrect argument to 'average'");  
            lua_error(L);
			return 0;
        }
		switch(i)
		{
			case 1:demo.SetButtonPath( AnsiToUnicode(lua_tolstring(L, i, NULL)) );break;
			case 2:demo.SetBackGroundPath( AnsiToUnicode(lua_tolstring(L, i, NULL)) );break;
			default:break;
		}
		
    }
	return 1;
}


