#pragma once
#include "d3dclass.h"
#include "luaClass.h"
#include "GetMatrix.h"




class GameStateInterface :
	public D3DCLASS
{
public:
	GameStateInterface();
	~GameStateInterface(void);

	void SetImagePath(LPCWSTR Path);
	void SetBackGroundPath(LPCWSTR Path);
	bool LoadContent(HWND hwnd);
    void UnloadContent( );
	bool DrawButton(float ButtonStartX,float ButtonStartY, float tuX, float tuY);
	bool DrawBackGround();
	bool DrawImage(float StartX,float StartY, float Width, float Height,float tuStartX, float tuEndX, float tuStartY, float tuEndY, float Priority);
    void Update( float dt );
    void Render( );


	friend static void KeyControl();


private:

	LPCWSTR ImagePath;
	LPCWSTR BackGroundImage;

	ID3DX11Effect* effect_;
	
	
	ID3D11InputLayout* inputLayout_; //���벼��

	ID3D11ShaderResourceView* ImageMap_;
	//ID3D11ShaderResourceView* BackGroundImage_;
    ID3D11SamplerState* colorMapSampler_;
	ID3D11Buffer* vertexBuffer_;
	ID3D11BlendState* alphaBlendState_;

	ID3D11Buffer* mvpCB_;
    XMMATRIX vpMatrix_;

	GetMatrix image[1];

	GameStateInterface *Next;
};

