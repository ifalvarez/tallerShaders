	sampler2D _MainTex;

	struct Input {
		float2 uv_MainTex;
		float3 worldPos;
	};

	half _Glossiness;
	half _Metallic;
	fixed4 _Color;
	float4 _ColorerPosition;
	float _ColorerRadius;

	void surf (Input IN, inout SurfaceOutputStandard o) {
		// Albedo comes from a texture tinted by color
		fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
		float lum = c.r*.3 + c.g*.59 + c.b*.11;
		if(distance(_ColorerPosition, IN.worldPos) > _ColorerRadius){
			o.Albedo = lum;
		}else{
			o.Albedo = c.rgb;
		}

		// Metallic and smoothness come from slider variables
		o.Metallic = _Metallic;
		o.Smoothness = _Glossiness;
		o.Alpha = c.a;
	}

	