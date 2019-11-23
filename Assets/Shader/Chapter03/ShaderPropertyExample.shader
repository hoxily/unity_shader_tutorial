Shader "Chapter03/ShaderPropertyExample"
{
    Properties {
        //数值以及滑动条
        _Int("Int", Int) = 2
        _Float("Float", Float) = 1.5
        _Range("Range", Range(0.0, 5.0)) = 3.0
        //颜色和向量
        _Color("Color", Color) = (1.0, 1.0, 1.0, 1.0)
        _Vector("Vector", Vector) = (1.0, 2.0, -3.0, 4.0)
        //纹理
        _2D("2D", 2D) = "" {}
        _2D_2("2D_2", 2D) = "white" {}
        _2D_3("2D_3", 2D) = "black" {}
        _2D_4("2D_4", 2D) = "gray" {}
        _2D_5("2D_5", 2D) = "bump" {}
        _Cube("Cube", Cube) = "white" {}
        _3D("3D", 3D) = "black" {}
    }

	Fallback "Diffuse"
}
