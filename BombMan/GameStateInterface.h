#pragma once
#include "d3dclass.h"
#include "luaClass.h"

class GameStateInterface :
	public D3DCLASS
{
public:
	GameStateInterface();
	~GameStateInterface(void);

	void SetButtonPath(LPCWSTR Path);
	void SetBackGroundPath(LPCWSTR Path);
	bool LoadContent(HWND hwnd);
    void UnloadContent( );
	bool DrawButton(float ButtonStartX,float ButtonStartY, float tuX, float tuY);
	bool DrawBackGround();
    void Update( float dt );
    void Render( );


	friend static void KeyControl();


private:
	LPCWSTR ImagePath;
	LPCWSTR BackGroundImage;

	LuaClass LuaButtonShow;

	ID3DX11Effect* effect_;
	
	
	ID3D11InputLayout* inputLayout_; // ‰»Î≤ºæ÷

	ID3D11ShaderResourceView* colorMap_;
	ID3D11ShaderResourceView* BackGroundImage_;
    ID3D11SamplerState* colorMapSampler_;
	ID3D11Buffer* vertexBuffer_;
	ID3D11BlendState* alphaBlendState_;

	ID3D11VertexShader* solidColorVS_;
    ID3D11PixelShader* solidColorPS_;
};

