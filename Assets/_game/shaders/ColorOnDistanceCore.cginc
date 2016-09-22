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

float2 sinusoid (float2 x, float2 m, float2 M, float2 p) {
	float2 e   = M - m;
	float2 c = 3.1415 * 2.0 / p;
	return e / 2.0 * (1.0 + sin(x * c)) + m;
}

void surf (Input IN, inout SurfaceOutputStandard o) {
	// Albedo comes from a texture tinted by color
	fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;

	// Calculate the grayscale equivalent
	float lum = c.r*.3 + c.g*.59 + c.b*.11;

	// Calculate an animated radius
	float3 localPos = normalize(IN.worldPos - _ColorerPosition);
	float colorRadius = _ColorerRadius 
		+ sinusoid(localPos.x * _SinTime / 5, -0.1, 0.1, 0.05) 
		+ sinusoid(localPos.z * _SinTime / 5, -0.1, 0.1, 0.05) 
		+ sinusoid(localPos.y * _SinTime / 5, -0.1, 0.1, 0.05);

	// Recolor to grayscale if the pixel is outside the radius
	if(distance(_ColorerPosition, IN.worldPos) > colorRadius){
		o.Albedo = lum;
	}else{
		o.Albedo = c.rgb;
	}

	// Metallic and smoothness come from slider variables
	o.Metallic = _Metallic;
	o.Smoothness = _Glossiness;
	o.Alpha = c.a;
}



	