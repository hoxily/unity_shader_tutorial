//这里使用了假彩色图像来可视化模型的数据。但是不够直观。
//网上有shader可以直接将法线用线条的方式画出来的办法。
Shader "Custom/ModelDataVisulizer"
{
    Properties
    {
        _NormalToggle("Normal Toggle", Float) = 0
        _TangentToggle("Tangent Toggle", Float) = 0
        _UvVisualizeType("UV Visualize Type", Float) = 0
        _Uv0Toggle("Uv0 Toggle", Float) = 0
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct v2f
            {
                float4 pos : SV_POSITION;
                fixed4 color : COLOR0;
            };
            float _NormalToggle;
            float _TangentToggle;
            float _UvVisualizeType;
            float _Uv0Toggle;

            fixed4 VisualizeNormalizedDirection(float3 dir)
            {
                return fixed4(dir * 0.5 + fixed3(0.5, 0.5, 0.5), 1.0);
            }

            fixed4 VisualizeUv(float4 uv)
            {
                if (_UvVisualizeType <= 0)
                {
                    return fixed4(uv.xy, 0.0, 1.0);
                }
                else
                {
                    //使用frac截取小数部分
                    fixed4 color = frac(uv);
                    if (any(saturate(uv) - uv))
                    {
                        //如果UV值超出[0, 1]，那么给他附加一个额外的蓝色分量
                        color.b = 0.5;
                    }
                    color.a = 1.0;
                    return color;
                }
            }

            v2f vert (appdata_full v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                if (_NormalToggle > 0)
                {
                    //可视化法线方向。因为是单位向量，所以各个分量的值在[-1, 1]之间。将它们缩放到颜色的[0, 1]之间加以展示。
                    o.color = VisualizeNormalizedDirection(v.normal);
                }
                else if (_TangentToggle > 0)
                {
                    //可视化切线方向。原理同法线。
                    o.color = VisualizeNormalizedDirection(v.tangent);
                }
                else if (_Uv0Toggle > 0)
                {
                    o.color = VisualizeUv(v.texcoord);
                }
                else
                {
                    o.color = fixed4(1.0, 0.0, 1.0, 1.0);
                }
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return i.color;
            }
            ENDCG
        }
    }
}
