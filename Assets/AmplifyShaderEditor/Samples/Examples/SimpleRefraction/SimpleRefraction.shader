// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/SimpleRefraction"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Distortion("Distortion", Range( 0 , 1)) = 0.292
		_BrushedMetalNormal("BrushedMetalNormal", 2D) = "bump" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		GrabPass{ "_ScreenGrab0" }
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard alpha:premul keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float4 screenPos;
			float2 uv_BrushedMetalNormal;
		};

		uniform sampler2D _ScreenGrab0;
		uniform sampler2D _BrushedMetalNormal;
		uniform float _Distortion;

		void surf( Input input , inout SurfaceOutputStandard output )
		{
			float2 FLOATToFLOAT270=input.screenPos.w;
			float2 normalizedClip = ( float2( input.screenPos.x , input.screenPos.y ) / FLOATToFLOAT270 );
			float3 FLOATToFLOAT3320=_Distortion;
			output.Emission = tex2D( _ScreenGrab0,( float3( normalizedClip ,  0.0 ) + ( UnpackNormal( tex2D( _BrushedMetalNormal,input.uv_BrushedMetalNormal) ) * FLOATToFLOAT3320 ) ).xy).rgb;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=21
509;157;1214;765;527.6804;137.4014;1;True;False
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;536.7999,-33.8;True;Standard;ASESampleShaders/SimpleRefraction;False;False;False;False;False;False;False;False;False;False;False;False;Back;On;LEqual;Transparent;0.5;True;True;0;False;Transparent;Transparent;0,0,0;0,0,0;0,0,0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0,0,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-128.7738,261.0988;0.0,0,0;0.0
Node;AmplifyShaderEditor.SamplerNode;29;-542.58,195.399;Property;_BrushedMetalNormal;BrushedMetalNormal;-1;Assets/AmplifyShaderEditor/Samples/Textures/SceneTextures/BrushedMetalNormal.tif;True;0;True;bump;Auto;True;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.RangedFloatNode;31;-437.0751,361.6983;Property;_Distortion;Distortion;-1;0.292;0;1
Node;AmplifyShaderEditor.ScreenPosInputsNode;4;-759.695,4.999985
Node;AmplifyShaderEditor.SimpleDivideOpNode;7;-393.4968,67.79983;0.0,0;0.0
Node;AmplifyShaderEditor.AppendNode;6;-556.3964,-18.99996;FLOAT2;0;0;0;0;0.0;0.0;0.0;0.0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;36.62508,137.2995;0.0,0;0.0,0,0
Node;AmplifyShaderEditor.RegisterLocalVarNode;21;-221.7862,36.49838;normalizedClip;-1;0.0,0
Node;AmplifyShaderEditor.ScreenColorNode;8;224.0004,85.8997;Uniform;_ScreenGrab0;Screen Grab 0;-1;Object;-1;0,0
WireConnection;0;11;8;0
WireConnection;32;0;29;0
WireConnection;32;1;31;0
WireConnection;7;0;6;0
WireConnection;7;1;4;4
WireConnection;6;0;4;1
WireConnection;6;1;4;2
WireConnection;30;0;21;0
WireConnection;30;1;32;0
WireConnection;21;0;7;0
WireConnection;8;0;30;0
ASEEND*/
//CHKSM=2045B9A4FC342A4770E8BEDB4593444DD20128F6