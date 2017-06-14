#pragma once
#include "include.h"

class GetMatrix
{
public:
	GetMatrix(void);
	~GetMatrix(void);
    XMMATRIX GetWorldMatrix();

    void SetPosition( XMFLOAT2& position );
    void SetRotation(float tangle);
    void SetScale( XMFLOAT2& scale );
	void SetRotationPos( XMFLOAT2& RPos );

private:
	XMFLOAT2 RotationPos;
    XMFLOAT2 position_;
    float angle;
    XMFLOAT2 scale_;
	
};

