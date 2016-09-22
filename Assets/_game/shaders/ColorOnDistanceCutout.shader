Shader "Custom/ColorOnDistanceCutout" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB) Alpha(A)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
		_ColorerRadius ("Colorer Radius", Float) = 3.0
		_ColorerPosition("Colorer Position", Vector) = (0,0,0,1)

	}

	SubShader {
		Tags { "RenderType"="TransparentCutout" "IgnoreProjector"="True"}
		LOD 200
		CGPROGRAM

		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard alphatest:_Cutoff addshadow

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		#include "ColorOnDistanceCore.cginc"
	
		ENDCG
	}
	FallBack "Diffuse"
}
