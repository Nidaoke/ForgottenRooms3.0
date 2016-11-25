// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/AnimatedFire"
{
	Properties
	{
		_Specular("Specular", 2D) = "white" {}
		_FireIntensity("FireIntensity", Range( 0 , 2)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
		_Smoothness("Smoothness", Float) = 1
		_Albedo("Albedo", 2D) = "white" {}
		_Normals("Normals", 2D) = "bump" {}
		_TileableFire("TileableFire", 2D) = "white" {}
		_Mask("Mask", 2D) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf StandardSpecular keepalpha noshadow vertex:vertexDataFunc
		struct Input
		{
			float2 texcoord_0;
		};

		uniform sampler2D _Normals;
		uniform sampler2D _Albedo;
		uniform sampler2D _Mask;
		uniform sampler2D _TileableFire;
		uniform float _FireIntensity;
		uniform sampler2D _Specular;
		uniform float _Smoothness;

		void vertexDataFunc(inout appdata_full vertexData, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			o.texcoord_0.xy = vertexData.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
		}

		void surf( Input input , inout SurfaceOutputStandardSpecular output )
		{
			output.Normal = UnpackNormal( tex2D( _Normals,input.texcoord_0) );
			output.Albedo = tex2D( _Albedo,input.texcoord_0).xyz;
			float4 FLOATToFLOAT480=( _FireIntensity * ( _SinTime[3] + 1.5 ) );
			output.Emission = ( ( tex2D( _Mask,input.texcoord_0) * tex2D( _TileableFire,frac(abs( input.texcoord_0+_Time[0] * float2(-1,0 )))) ) * FLOATToFLOAT480 ).xyz;
			output.Specular = tex2D( _Specular,input.texcoord_0).xyz;
			output.Smoothness = _Smoothness;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=21
509;157;1214;765;608.203;259.2167;1;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-602,262.5;Property;_TileableFire;TileableFire;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-283,123.5;0.0,0,0,0;0.0,0,0,0
Node;AmplifyShaderEditor.TimeNode;5;-1183,291.5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-138,509.5;0.0;0.0
Node;AmplifyShaderEditor.RangedFloatNode;7;-453,470.5;Property;_FireIntensity;FireIntensity;-1;0;0;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-96,123.5;0.0,0,0,0;0.0
Node;AmplifyShaderEditor.RangedFloatNode;15;20.09985,210.9048;Property;_Smoothness;Smoothness;-1;1;0;0
Node;AmplifyShaderEditor.SinTimeNode;9;-508,600.5
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-306,616.5;0.0;1.5
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;171,-60;True;StandardSpecular;ASESampleShaders/AnimatedFire;False;False;False;False;False;False;False;False;False;False;False;False;Back;On;LEqual;Opaque;0.5;True;False;0;False;Opaque;Geometry;0,0,0;0,0,0;0,0,0;0,0,0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0,0,0
Node;AmplifyShaderEditor.SamplerNode;13;-563,-448.5;Property;_Specular;Specular;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-1236,81.5;0;1,1;0,0
Node;AmplifyShaderEditor.PannerNode;4;-954,212.5;-1;0;0,0;0.0
Node;AmplifyShaderEditor.SamplerNode;12;-556,-625.5;Property;_Albedo;Albedo;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;14;-691,31.5;Property;_Normals;Normals;-1;None;True;0;True;bump;Auto;True;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;2;-615,-237.5;Property;_Mask;Mask;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
WireConnection;1;0;4;0
WireConnection;3;0;2;0
WireConnection;3;1;1;0
WireConnection;10;0;7;0
WireConnection;10;1;11;0
WireConnection;8;0;3;0
WireConnection;8;1;10;0
WireConnection;11;0;9;4
WireConnection;0;0;12;0
WireConnection;0;1;14;0
WireConnection;0;2;8;0
WireConnection;0;3;13;0
WireConnection;0;4;15;0
WireConnection;13;0;6;0
WireConnection;4;0;6;0
WireConnection;4;1;5;1
WireConnection;12;0;6;0
WireConnection;14;0;6;0
WireConnection;2;0;6;0
ASEEND*/
//CHKSM=4C01EC6D932C1B0AA9985F4009B08F8275019D37