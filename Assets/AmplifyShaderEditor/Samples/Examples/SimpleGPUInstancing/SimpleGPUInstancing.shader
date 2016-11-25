// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/SimpleGPUInstancing"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Color("Color", Color) = (1,1,1,1)
		_Checkers("Checkers", 2D) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_Checkers;
		};

		uniform sampler2D _Checkers;

		UNITY_INSTANCING_CBUFFER_START(ASESampleShadersSimpleGPUInstancing)
			UNITY_DEFINE_INSTANCED_PROP(float4, _Color)
		UNITY_INSTANCING_CBUFFER_END

		void surf( Input input , inout SurfaceOutputStandard output )
		{
			output.Albedo = ( tex2D( _Checkers,input.uv_Checkers) * UNITY_ACCESS_INSTANCED_PROP(_Color) ).rgb;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=21
509;157;1214;765;888.5;303.5;1;True;False
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;23,-97;True;Standard;ASESampleShaders/SimpleGPUInstancing;False;False;False;False;False;False;False;False;False;False;False;False;Back;On;LEqual;Opaque;0.5;True;True;0;False;Opaque;Geometry;0,0,0;0,0,0;0,0,0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0,0,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-153.5,-50.5;0.0,0,0,0;0.0,0,0,0
Node;AmplifyShaderEditor.SamplerNode;1;-518.5,-163.5;Property;_Checkers;Checkers;-1;Assets/AmplifyShaderEditor/Samples/Textures/Misc/Checkers.png;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.ColorNode;2;-464.5,65.5;InstancedProperty;_Color;Color;-1;1,1,1,1
WireConnection;0;0;3;0
WireConnection;3;0;1;0
WireConnection;3;1;2;0
ASEEND*/
//CHKSM=199D3038BA82F8B4BDAC5D27039770E814F2FA51