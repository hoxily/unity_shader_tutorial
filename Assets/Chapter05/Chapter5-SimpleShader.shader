// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Chapter5/SimpleShader"
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

            //顶点着色函数是逐顶点执行的。输入参数v包含了这个顶点的位置，通过POSITION语义指定。也就是参数名可以叫别的，但是语义必须是POSITION。
            //POSITION和SV_POSITION都是CG/HLSL中的语义，它们告诉系统用户需要哪些输入值，以及用户的输出是什么。
            //此处的POSITION告诉系统，把模型的顶点坐标填充到输入参数v中；
            //此处的SV_POSITION则告诉系统，这个函数的输出是裁剪空间中的顶点坐标。
            //如果没有语义来限定输入和输出参数的话，渲染器就不知道用户的输入输出是什么。
            float4 vert (float4 v : POSITION) : SV_POSITION
            {
                return UnityObjectToClipPos(v);
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
