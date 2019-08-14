// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/HalfLambert" {
    Properties {
        _Diffuse ("Diffuse", Color) = (1, 1, 1, 1)
    }
    SubShader {
        Pass {
            Tags { "LightMode" = "ForwardBase" }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Lighting.cginc"

            fixed4 _Diffuse;

            struct a2v {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f {
                float4 pos : SV_POSITION;
                float3 worldNormal : TEXCOORD0;
            };
            //顶点着色器不需要计算光照模型，只需要把世界空间下的法线传递给片元着色器即可。
            v2f vert(a2v v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldNormal = normalize(mul(v.normal, (float3x3)unity_WorldToObject));
                return o;
            }
            //在片元着色器中计算漫反射光照模型
            fixed4 frag(v2f i) : SV_TARGET {
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
                fixed halfLambert = 0.5 * dot(i.worldNormal, worldLightDir) + 0.5;
                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * halfLambert;
                fixed3 color = ambient + diffuse;
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
