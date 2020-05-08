// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Chapter5/SimpleShader3"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            //使用#pragma vertex <name> 来指定顶点着色函数
            #pragma vertex vert
            //使用#pragma fragment <name>来指定片元着色函数
            #pragma fragment frag

            //对于顶点着色器，unity支持的语义有：POSITION, TANGENT, NORMAL, COLOR, TEXCOORD0, TEXCOORD1, TEXCOORD2, TEXCOORD3等。
            //填充到POSITION,TANGENT,NORMAL等语义的数据的来源是使用该材质的Renderer组件提供的。通常是MeshRenderer。
            //在每帧调用DrawCall时，MeshRenderer组件负责把模型数据发送给unity shader。
            struct appdata_t
            {
                //POSITION语义告诉unity，用模型空间的顶点坐标填充vertex变量
                float4 vertex: POSITION;
                //NORMAL语义告诉unity，用模型空间的法线方向填充normal变量。
                float3 normal: NORMAL;
                //TEXCOORD0语义告诉unity，用模型的第一套纹理坐标填充texcoord变量。
                float4 texcoord: TEXCOORD0;
            };

            //使用一个结构体来定义顶点着色器的输出
            struct vertexoutput_t
            {
                //SV_POSITION语义告诉unity，pos里包含了顶点在裁剪空间中的位置
                float4 pos : SV_POSITION;
                //COLOR0语义可以用于存储颜色信息。
                fixed3 color: COLOR0;
            };

            vertexoutput_t vert (appdata_t v)
            {
                vertexoutput_t o;
                o.pos = UnityObjectToClipPos(v.vertex);
                //归一化的法线，每个分量的范围在[-1, 1]
                //通过下面的缩放和偏移，映射到了[0, 1]
                //存储到color中传递给片元着色器。
                o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
                return o;
            }
            
            //此frag函数没有输入参数。
            //此函数的输出是一个fixed4类型，并且使用了SV_Target.
            //SV_Target是HLSL的一个语义。它告诉系统，把用户的输出颜色存储到一个渲染目标（render target）中。
            fixed4 frag (vertexoutput_t i) : SV_Target
            {
                //将插值后的i.color显示到屏幕上
                return fixed4(i.color, 1.0);
            }
            ENDCG
        }
    }
}
