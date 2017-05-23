#include "GetMatrix.h"

GetMatrix::GetMatrix( ) : rotation_( 0 )
{
    scale_.x = scale_.y = 1.0f;
}


GetMatrix::~GetMatrix( )
{

}


XMMATRIX GetMatrix::GetWorldMatrix( )
{
    XMMATRIX translation = XMMatrixTranslation( position_.x, position_.y, 0.0f );
    XMMATRIX rotationZ = XMMatrixRotationZ( rotation_ );
    XMMATRIX scale = XMMatrixScaling( scale_.x, scale_.y, 1.0f );

    return translation * rotationZ * scale;
}


void GetMatrix::SetPosition( XMFLOAT2& position )
{
    position_ = position;
}


void GetMatrix::SetRotation( float rotation )
{
    rotation_ = rotation;
}


void GetMatrix::SetScale( XMFLOAT2& scale )
{
    scale_ = scale;
}