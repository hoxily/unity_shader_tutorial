Shader "Custom/SimpleSurfaceShader" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        struct Input {
            float4 color: COLOR;
        };
        fixed4 _Color;
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = _Color;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
