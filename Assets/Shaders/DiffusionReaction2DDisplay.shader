Shader "Unlit/DiffusionReaction2DDisplay"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _RampTex("RampTex", 2D) = "white" {}
        _Q("Data Texture", 2D) = "white" {}
        _Rows ("Rows", Int) = 128
        _Cols ("Cols", Int) = 128

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 5.0

            #include "UnityCG.cginc"
            #include "Include/misc_defines.hlsl"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;

                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex, _RampTex;
            float4 _MainTex_ST;

            int _Rows, _Cols;

            sampler2D _Q;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {

                int2 dimensions = int2(_Rows, _Cols);
                float2 uv = i.uv * aspect_ratio_factor;
                float4 cell = cell_coordinates(uv, dimensions);
                fixed4 color = 0.0;

                float f = 1 - tex2D(_Q, i.uv).r ;
                //return 1-f;
                f += .5;
                return tex2D(_RampTex, float2( saturate(f), 0)) *  (f * f);
                //return color / 9;
            }
            ENDCG
        }
    }
}
