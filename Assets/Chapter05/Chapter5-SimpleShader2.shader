// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Chapter5/SimpleShader2"
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

            float4 vert (appdata_t v) : SV_POSITION
            {
                return UnityObjectToClipPos(v.vertex);
            }
            
            //此frag函数没有输入参数。
            //此函数的输出是一个fixed4类型，并且使用了SV_Target.
            //SV_Target是HLSL的一个语义。它告诉系统，把用户的输出颜色存储到一个渲染目标（render target）中。
            fixed4 frag () : SV_Target
            {
                return fixed4(1.0, 1.0, 1.0, 1.0);
            }
            ENDCG
        }
    }
}
