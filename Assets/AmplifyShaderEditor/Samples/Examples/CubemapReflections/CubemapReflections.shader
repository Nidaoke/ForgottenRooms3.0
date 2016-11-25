// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/CubemapReflections"
{
	Properties
	{
		_Metallic("Metallic", 2D) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		_Cubemap("Cubemap", CUBE) = "white" {}
		_Normals("Normals", 2D) = "bump" {}
		_Albedo("Albedo", 2D) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_Normals;
			float2 uv_Albedo;
			float3 worldRefl;
			INTERNAL_DATA
			float2 uv_Metallic;
		};

		uniform sampler2D _Normals;
		uniform sampler2D _Albedo;
		uniform samplerCUBE _Cubemap;
		uniform sampler2D _Metallic;

		void surf( Input input , inout SurfaceOutputStandard output )
		{
			float3 tex2DNode10 = UnpackNormal( tex2D( _Normals,input.uv_Normals) );
			output.Normal = tex2DNode10;
			float4 FLOATToFLOAT430=0.5;
			output.Albedo = ( tex2D( _Albedo,input.uv_Albedo) * FLOATToFLOAT430 ).xyz;
			float4 FLOATToFLOAT470=( 1.0 - 0.5 );
			output.Emission = ( FLOATToFLOAT470 * texCUBE( _Cubemap,WorldReflectionVector( input , tex2DNode10 )) ).xyz;
			output.Metallic = tex2D( _Metallic,input.uv_Metallic).x;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=21
509;157;1214;765;977.3164;225.4564;1;True;False
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-151.5,-27;0.0,0,0,0;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-150.5,174;0.0;0.0,0,0,0
Node;AmplifyShaderEditor.OneMinusNode;6;-292.5,81;0.0
Node;AmplifyShaderEditor.RangedFloatNode;4;-466.5,11;Constant;_Float0;Float 0;-1;0.5;0;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;71,2;True;Standard;ASESampleShaders/CubemapReflections;False;False;False;False;False;False;False;False;False;False;False;False;Back;On;LEqual;Opaque;0.5;True;True;0;False;Opaque;Geometry;0,0,0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0,0,0;0,0,0;0,0,0
Node;AmplifyShaderEditor.WorldReflectionVector;9;-844.6999,324.6002;0,0,0
Node;AmplifyShaderEditor.SamplerNode;1;-497.5,242;Property;_Cubemap;Cubemap;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;13;-210.7001,302.3;Property;_Metallic;Metallic;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;2;-636.5,-254;Property;_Albedo;Albedo;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;10;-1193.5,-7.000012;Property;_Normals;Normals;-1;None;True;0;True;bump;Auto;True;Object;-1;0,0;1.0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;7;0;6;0
WireConnection;7;1;1;0
WireConnection;6;0;4;0
WireConnection;0;0;3;0
WireConnection;0;1;10;0
WireConnection;0;2;7;0
WireConnection;0;3;13;0
WireConnection;9;0;10;0
WireConnection;1;0;9;0
ASEEND*/
//CHKSM=B91D7931D96E508AECE3BA3C9879BAA34527240E