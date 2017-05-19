#pragma once
#include "d3dclass.h"
#include "luaClass.h"

class GameStateInterface :
	public D3DCLASS
{
public:
	GameStateInterface();
	GameStateInterface(LPCWSTR path);
	~GameStateInterface(void);

	void SetImagePath(LPCWSTR Path);
	bool LoadContent(HWND hwnd);
    void UnloadContent( );
	bool DrawButton(float ButtonStartX,float ButtonStartY, float tuX, float tuY);
    void Update( float dt );
    void Render( );


	friend static void KeyControl();


private:
	LPCWSTR ImagePath;
	LuaClass LuaButtonShow;
	ID3DX11Effect* effect_;
	ID3D11Texture2D* depthTexture_;
	ID3D11DepthStencilView* depthStencilView_; //表示深度/模板视图
	ID3D11InputLayout* inputLayout_; //输入布局
	ID3D11ShaderResourceView* colorMap_;
    ID3D11SamplerState* colorMapSampler_;
	ID3D11Buffer* vertexBuffer_;
	ID3D11BlendState* alphaBlendState_;

	ID3D11VertexShader* solidColorVS_;
    ID3D11PixelShader* solidColorPS_;
};

