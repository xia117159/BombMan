Texture2D colorMap : register( t0 );
Texture2D secondMap : register( t1 );
SamplerState colorSampler : register( s0 );


struct VS_Input
{
    float4 pos  : POSITION;
    float2 tex0 : TEXCOORD0;
};

struct PS_Input
{
    float4 pos  : SV_POSITION;
    float2 tex0 : TEXCOORD0;
};


PS_Input VS_Main( VS_Input vertex )
{
    PS_Input vsOut = ( PS_Input )0;
    vsOut.pos = vertex.pos;
    vsOut.tex0 = vertex.tex0;

    return vsOut;
}

float4 PS_Main1( PS_Input frag ) : SV_TARGET
{
    return colorMap.Sample( colorSampler, frag.tex0 );
}

float4 PS_Main2( PS_Input frag ) : SV_TARGET
{
    return secondMap.Sample( colorSampler, frag.tex0 );
}


technique11 ColorInversion
{
    pass P0
    {
        SetVertexShader( CompileShader( vs_5_0, VS_Main() ) );
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_5_0, PS_Main1() ) );
    }
    pass P1
    {
        SetVertexShader( CompileShader( vs_5_0, VS_Main() ) );
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_5_0, PS_Main2() ) );
    }
    
}