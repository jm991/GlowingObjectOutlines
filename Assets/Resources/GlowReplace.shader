Shader "Hidden/GlowReplace"
{
	Properties
	{
		_MainTex("Albedo", 2D) = "white" {}
	}
	SubShader
	{

		Tags
		{
		"RenderType"="Opaque"
		"Glowable" = "True"
		}

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv0 : TEXCOORD0;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);

				o.uv0 = v.uv;

				return o;
			}
			
			fixed4 _GlowColor;
			sampler2D _MainTex;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv0);
				return _GlowColor * col.a;
			}
			ENDCG
		}
	}
}
