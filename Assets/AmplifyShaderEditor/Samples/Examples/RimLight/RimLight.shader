// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/RimLight"
{
	Properties
	{
		_Metallic("Metallic", 2D) = "white" {}
		_Occlusion("Occlusion", 2D) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		_RimColor("RimColor", Color) = (0,0,0,0)
		_Normals("Normals", 2D) = "bump" {}
		_Albedo("Albedo", 2D) = "white" {}
		_RimPower("RimPower", Range( 0 , 10)) = 0
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
			float3 viewDir;
			float2 uv_Metallic;
			float2 uv_Occlusion;
		};

		uniform sampler2D _Normals;
		uniform sampler2D _Albedo;
		uniform float _RimPower;
		uniform float4 _RimColor;
		uniform sampler2D _Metallic;
		uniform sampler2D _Occlusion;

		void surf( Input input , inout SurfaceOutputStandard output )
		{
			float3 tex2DNode3 = UnpackNormal( tex2D( _Normals,input.uv_Normals) );
			output.Normal = tex2DNode3;
			output.Albedo = tex2D( _Albedo,input.uv_Albedo).xyz;
			float4 FLOATToCOLOR270=pow( ( 1.0 - saturate( dot( normalize( input.viewDir ) , tex2DNode3 ) ) ) , _RimPower );
			output.Emission = ( FLOATToCOLOR270 * _RimColor ).rgb;
			output.Metallic = tex2D( _Metallic,input.uv_Metallic).x;
			output.Occlusion = tex2D( _Occlusion,input.uv_Occlusion).x;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=21
509;157;1214;765;1346.615;-37.53402;1.3;True;False
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;136,320;True;Standard;ASESampleShaders/RimLight;False;False;False;False;False;False;False;False;False;False;False;False;Back;On;LEqual;Opaque;0.5;True;True;0;False;Opaque;Geometry;0,0,0;0;0;0;0;0;0;0;0;0,0,0;0,0,0;0,0,0
Node;AmplifyShaderEditor.ColorNode;25;-1108.403,751.2996;Property;_RimColor;RimColor;-1;0,0,0,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-525.4033,582.2996;0;0.0,0,0,0
Node;AmplifyShaderEditor.DotProductOpNode;21;-1135.403,277.2996;0.0,0,0;0.0,0,0
Node;AmplifyShaderEditor.SaturateNode;20;-984.404,259.3994;1.23
Node;AmplifyShaderEditor.OneMinusNode;5;-815.401,301.6987;0
Node;AmplifyShaderEditor.PowerNode;26;-697.4033,459.2996;0.0;0.0
Node;AmplifyShaderEditor.SamplerNode;3;-1578.5,-28;Property;_Normals;Normals;-1;None;True;0;True;bump;Auto;True;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.NormalizeNode;23;-1324.903,256.7;0,0,0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;22;-1461.802,212.8997
Node;AmplifyShaderEditor.SamplerNode;1;-159.9004,147.0001;Property;_Albedo;Albedo;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1
Node;AmplifyShaderEditor.RangedFloatNode;28;-1191.403,606.2996;Property;_RimPower;RimPower;-1;0;0;10
Node;AmplifyShaderEditor.SamplerNode;2;-510.5002,325.1999;Property;_Metallic;Metallic;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1
Node;AmplifyShaderEditor.SamplerNode;4;-208.9012,673.0024;Property;_Occlusion;Occlusion;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1
WireConnection;0;0;1;0
WireConnection;0;1;3;0
WireConnection;0;2;27;0
WireConnection;0;3;2;0
WireConnection;0;5;4;0
WireConnection;27;0;26;0
WireConnection;27;1;25;0
WireConnection;21;0;23;0
WireConnection;21;1;3;0
WireConnection;20;0;21;0
WireConnection;5;0;20;0
WireConnection;26;0;5;0
WireConnection;26;1;28;0
WireConnection;23;0;22;0
ASEEND*/
//CHKSM=9AC1E5A00A7102A5859B4DA7D2D168E18BF8DC68