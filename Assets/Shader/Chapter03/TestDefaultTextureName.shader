//这段代码修改自Unlit模板。
Shader "Chapter03/TestDefaultTextureName"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_NormalTex ("NormalMap", 2D) = "bump" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" "PreviewType" = "Plane" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			sampler2D _NormalTex;
			float4 _NormalTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = fixed4(1, 1, 1, 1);
				if (i.uv.x > 0.5)
				{
					col = tex2D(_MainTex, i.uv);
				}
				else
				{
					col = tex2D(_NormalTex, i.uv);
				}
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
}
