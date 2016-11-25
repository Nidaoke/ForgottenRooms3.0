// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/NormalExtrusion"
{
	Properties
	{
		_ExtrusionAmount("Extrusion Amount", Range( -1 , 20)) = 0.5
		[HideInInspector] __dirty( "", Int ) = 1
		_Albedo("Albedo", 2D) = "white" {}
		_ExtrusionPoint("ExtrusionPoint", Float) = 0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc
		struct Input
		{
			float2 uv_Albedo;
		};

		uniform sampler2D _Albedo;
		uniform float _ExtrusionPoint;
		uniform float _ExtrusionAmount;

		void vertexDataFunc(inout appdata_full vertexData, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			float3 FLOATToFLOAT340=max( ( sin( ( ( vertexData.vertex.y + _Time[0] ) / _ExtrusionPoint ) ) / _ExtrusionAmount ) , 0.0 );
			vertexData.vertex.xyz += ( vertexData.normal * FLOATToFLOAT340 );
		}

		void surf( Input input , inout SurfaceOutputStandard output )
		{
			output.Albedo = tex2D( _Albedo,input.uv_Albedo).xyz;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=21
509;157;1214;765;1339.04;337.2006;1.3;True;False
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;154,-266;True;Standard;ASESampleShaders/NormalExtrusion;False;False;False;False;False;False;False;False;False;False;False;False;Back;On;LEqual;Opaque;0.5;True;True;0;False;Opaque;Geometry;0,0,0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0,0,0;0,0,0;0,0,0
Node;AmplifyShaderEditor.SamplerNode;1;-349.5,-300;Property;_Albedo;Albedo;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.TimeNode;25;-981.2358,327.3
Node;AmplifyShaderEditor.SimpleDivideOpNode;24;-299.237,166.3993;0.0;10.0
Node;AmplifyShaderEditor.RangedFloatNode;3;-550.2001,333.0997;Property;_ExtrusionAmount;Extrusion Amount;-1;0.5;-1;20
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;3.5,1;0.0,0,0;0.0
Node;AmplifyShaderEditor.SimpleDivideOpNode;19;-624.0369,223.2994;0.0;5.0
Node;AmplifyShaderEditor.RangedFloatNode;21;-767.0372,392.2995;Property;_ExtrusionPoint;ExtrusionPoint;-1;0;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;18;-980.0377,98.29941
Node;AmplifyShaderEditor.SimpleAddOpNode;22;-776.0372,190.0994;0.0;0.0
Node;AmplifyShaderEditor.SinOpNode;20;-479.9368,132.2993;0.0
Node;AmplifyShaderEditor.NormalVertexDataNode;2;-237.2496,-72.3555
Node;AmplifyShaderEditor.SimpleMaxOp;26;-140.5377,221.3996;0.0;0.0
WireConnection;0;0;1;0
WireConnection;0;8;4;0
WireConnection;24;0;20;0
WireConnection;24;1;3;0
WireConnection;4;0;2;0
WireConnection;4;1;26;0
WireConnection;19;0;22;0
WireConnection;19;1;21;0
WireConnection;22;0;18;2
WireConnection;22;1;25;1
WireConnection;20;0;19;0
WireConnection;26;0;24;0
ASEEND*/
//CHKSM=11F2AF463AF6CF7347F26B35D97BAEEC7B523483