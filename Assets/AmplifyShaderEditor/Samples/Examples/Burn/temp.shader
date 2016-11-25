// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/temp"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_TextureSample1;
			float2 uv_TextureSample0;
		};

		uniform sampler2D _TextureSample1;
		uniform sampler2D _TextureSample0;

		void surf( Input input , inout SurfaceOutputStandardSpecular output )
		{
			output.Normal = tex2D( _TextureSample1,input.uv_TextureSample1).xyz;
			output.Albedo = tex2D( _TextureSample0,input.uv_TextureSample0).xyz;
			float3 FLOATToFLOAT30=0.0;
			output.Specular = FLOATToFLOAT30;
			output.Smoothness = 0.0;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=13
8;100;996;366;957.8998;333.2002;1.6;True;False
Node;AmplifyShaderEditor.SamplerNode;4;-516.5,101;Property;_TextureSample1;Texture Sample 1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;2;-544.5,-223;Property;_TextureSample0;Texture Sample 0;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.LerpOp;3;-18.5,67;0.0;0.0;0.0
Node;AmplifyShaderEditor.RangedFloatNode;5;42.5,-113;Constant;_Float1;Float 1;0;0;0
Node;AmplifyShaderEditor.RangedFloatNode;6;172.5,34;Constant;_Float0;Float 0;0;0;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;459,-186;True;StandardSpecular;ASESampleShaders/temp;False;False;False;False;False;False;False;False;False;False;False;False;Back;On;LEqual;Opaque;0.5;True;True;0;False;Opaque;Geometry;0,0,0;0,0,0;0,0,0;0,0,0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0,0,0
WireConnection;0;0;2;0
WireConnection;0;1;4;0
WireConnection;0;3;5;0
WireConnection;0;4;6;0
ASEEND*/
//CHKSM=C0EE77AB07DB9838098F3F1D7AF0868880F12CF0