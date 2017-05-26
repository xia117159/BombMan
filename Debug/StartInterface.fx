cbuffer cbChangesPerFrame : register( b0 )
{
    matrix mvp_;
};

Texture2D Image_0 : register( t0 );
Texture2D Image_1 : register( t1 );
Texture2D Image_2 : register( t2 );
Texture2D Image_3 : register( t3 );
Texture2D Image_4 : register( t4 );
Texture2D Image_5 : register( t5 );
Texture2D Image_6 : register( t6 );
Texture2D Image_7 : register( t7 );
Texture2D Image_8 : register( t8 );
Texture2D Image_9 : register( t9 );


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
    vsOut.pos = mul( vertex.pos, mvp_ );
    vsOut.tex0 = vertex.tex0;

    return vsOut;
}

float4 PS_Main0( PS_Input frag ) : SV_TARGET
{
    return Image_0.Sample( colorSampler, frag.tex0 );
}

float4 PS_Main1( PS_Input frag ) : SV_TARGET
{
    return Image_1.Sample( colorSampler, frag.tex0 );
}

float4 PS_Main2( PS_Input frag ) : SV_TARGET
{
    return Image_2.Sample( colorSampler, frag.tex0 );
}

float4 PS_Main3( PS_Input frag ) : SV_TARGET
{
    return Image_3.Sample( colorSampler, frag.tex0 );
}

float4 PS_Main4( PS_Input frag ) : SV_TARGET
{
    return Image_4.Sample( colorSampler, frag.tex0 );
}

float4 PS_Main5( PS_Input frag ) : SV_TARGET
{
    return Image_5.Sample( colorSampler, frag.tex0 );
}

float4 PS_Main6( PS_Input frag ) : SV_TARGET
{
    return Image_6.Sample( colorSampler, frag.tex0 );
}

float4 PS_Main7( PS_Input frag ) : SV_TARGET
{
    return Image_7.Sample( colorSampler, frag.tex0 );
}

float4 PS_Main8( PS_Input frag ) : SV_TARGET
{
    return Image_8.Sample( colorSampler, frag.tex0 );
}

float4 PS_Main9( PS_Input frag ) : SV_TARGET
{
    return Image_9.Sample( colorSampler, frag.tex0 );
}

technique11 StartInterface
{
    pass P0
    {
        SetVertexShader( CompileShader( vs_5_0, VS_Main() ) );
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_5_0, PS_Main0() ) );
    }
    pass P1
    {
        SetVertexShader( CompileShader( vs_5_0, VS_Main() ) );
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_5_0, PS_Main1() ) );
    }
    pass P2
    {
        SetVertexShader( CompileShader( vs_5_0, VS_Main() ) );
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_5_0, PS_Main2() ) );
    }
    pass P3
    {
        SetVertexShader( CompileShader( vs_5_0, VS_Main() ) );
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_5_0, PS_Main3() ) );
    }
    pass P4
    {
        SetVertexShader( CompileShader( vs_5_0, VS_Main() ) );
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_5_0, PS_Main4() ) );
    }
    pass P5
    {
        SetVertexShader( CompileShader( vs_5_0, VS_Main() ) );
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_5_0, PS_Main5() ) );
    }
    pass P6
    {
        SetVertexShader( CompileShader( vs_5_0, VS_Main() ) );
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_5_0, PS_Main6() ) );
    }
    pass P7
    {
        SetVertexShader( CompileShader( vs_5_0, VS_Main() ) );
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_5_0, PS_Main7() ) );
    }
    pass P8
    {
        SetVertexShader( CompileShader( vs_5_0, VS_Main() ) );
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_5_0, PS_Main8() ) );
    }
    pass P9
    {
        SetVertexShader( CompileShader( vs_5_0, VS_Main() ) );
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_5_0, PS_Main9() ) );
    }
}