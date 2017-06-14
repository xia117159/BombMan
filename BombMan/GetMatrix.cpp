#include "GetMatrix.h"

GetMatrix::GetMatrix( )
{
    scale_.x = scale_.y = 1.0f;
	position_.x = position_.y = 0.0f;
	XMFLOAT3 Axis(0.0f,0.0f,0.0f);
	RotationPos.x = RotationPos.y = 0.0f;
	angle = 0.0f;
}


GetMatrix::~GetMatrix( )
{

}


XMMATRIX GetMatrix::GetWorldMatrix()
{
	XMMATRIX translationXY = XMMatrixTranslation( -RotationPos.x, -RotationPos.y, 0.0f );
	XMMATRIX translationNXY = XMMatrixTranslation( RotationPos.x, RotationPos.y, 0.0f );
    XMMATRIX rotationZ = XMMatrixRotationZ( angle );
	rotationZ = translationXY*rotationZ*translationNXY;
	XMMATRIX translation = XMMatrixTranslation( position_.x, position_.y, 0.0f );
    XMMATRIX scale = XMMatrixScaling( scale_.x, scale_.y, 1.0f );

    return rotationZ *  scale * translation ;
}

//平移
void GetMatrix::SetPosition( XMFLOAT2& position )
{
    position_ = position;
}

//旋转
void GetMatrix::SetRotation(float tangle)
{
	angle = tangle;
}

//缩放
void GetMatrix::SetScale( XMFLOAT2& scale )
{
    scale_ = scale;
}


//缩放
void GetMatrix::SetRotationPos( XMFLOAT2& RPos )
{
    RotationPos = RPos;
}