// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/SimpleLambert"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Lambert keepalpha addshadow fullforwardshadows 
		struct Input
		{
			fixed filler;
		};

		void surf( Input input , inout SurfaceOutput output )
		{
			float3 FLOATToFLOAT310=1.0;
			output.Albedo = FLOATToFLOAT310;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=21
509;157;1214;765;775.6002;217.6;1;True;True
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;True;Lambert;ASESampleShaders/SimpleLambert;False;False;False;False;False;False;False;False;False;False;False;False;Back;On;LEqual;Opaque;0.5;True;True;0;False;Opaque;Geometry;0,0,0;0,0,0;0,0,0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0,0,0
Node;AmplifyShaderEditor.RangedFloatNode;1;-123,39.5;Constant;_Float0;Float 0;-1;1;0;0
WireConnection;0;0;1;0
ASEEND*/
//CHKSM=87E2A8596D06CC230EC9008276A16DF8A1C0FCD9