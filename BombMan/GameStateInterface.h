#pragma once
#include "d3dclass.h"
#include "luaClass.h"
#include "GetMatrix.h"

#define MaxView 20
#define MaxNode 20


struct ImageData
{
	LPCWSTR ImagePath;
	ID3D11ShaderResourceView* ImageMap_;
	const char * DrawImageFunc;
	const char * effectMap;
};




class GameStateInterface :
	public D3DCLASS
{
public:
	GameStateInterface();
	~GameStateInterface(void);

	void SetImagePath(int View, LPCWSTR Path, const char * DrawImageFunc, const char * effectMap);
	void SetBackGroundPath(LPCWSTR Path);
	bool LoadContent(HWND hwnd);
    void UnloadContent( );
	bool DrawImage(float StartX,float StartY, float Width, float Height,float tuStartX, float tuEndX, float tuStartY, float tuEndY, float Priority);
    void Update( float dt );
    void Render( );
	void SetWindowView(int View);
	void ReleaseViewImagePath(int View);
	int GetNode(){return Node[NowView];};
private:




	ImageData ImageData_[MaxView][MaxNode];
	int Node[MaxView];
	int NowView;

	LPCWSTR ImagePath;
	LPCWSTR BackGroundImage;

	ID3DX11Effect* effect_;

	ID3D11InputLayout* inputLayout_; // ‰»Î≤ºæ÷

	ID3D11ShaderResourceView* ImageMap_;
    ID3D11SamplerState* colorMapSampler_;
	ID3D11Buffer* vertexBuffer_;
	ID3D11BlendState* alphaBlendState_;

	ID3D11Buffer* mvpCB_;
    XMMATRIX vpMatrix_;

	GetMatrix image[1];
};

