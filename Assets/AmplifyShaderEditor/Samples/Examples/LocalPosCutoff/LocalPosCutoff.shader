Shader "ASESampleShaders/LocalPosCutoff"
{
	Properties
	{
		_Metallic("Metallic", 2D) = "white" {}
		_UnderwaterInfluence("UnderwaterInfluence", Range( 0 , 1)) = 0
		_SmoothnessFactor("SmoothnessFactor", Range( 0 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
		_Occlusion("Occlusion", 2D) = "white" {}
		_Tint("Tint", Color) = (0.5294118,0.4264289,0,0)
		_Normals("Normals", 2D) = "bump" {}
		_Albedo("Albedo", 2D) = "white" {}
		_Distribution("Distribution", Range( 0.1 , 10)) = 1
		_StartPoint("StartPoint", Range( -10 , 10)) = 0.75
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc
		struct Input
		{
			float2 uv_Normals;
			float2 uv_Albedo;
			float3 localVertexPos;
			float2 uv_Metallic;
			float2 uv_Occlusion;
		};

		uniform sampler2D _Normals;
		uniform float4 _Tint;
		uniform sampler2D _Albedo;
		uniform float _StartPoint;
		uniform float _Distribution;
		uniform float _UnderwaterInfluence;
		uniform sampler2D _Metallic;
		uniform float _SmoothnessFactor;
		uniform sampler2D _Occlusion;

		void vertexDataFunc(inout appdata_full vertexData, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			o.localVertexPos = vertexData.vertex.xyz ;
		}

		void surf( Input input , inout SurfaceOutputStandard output )
		{
			output.Normal = UnpackNormal( tex2D( _Normals,input.uv_Normals) );
			float saturate15 = saturate( ( ( input.localVertexPos.y + _StartPoint ) / _Distribution ) );
			output.Albedo = lerp( _Tint , tex2D( _Albedo,input.uv_Albedo) , clamp( saturate15 , _UnderwaterInfluence , 1.0 ) ).xyz;
			float4 FLOATToFLOAT41=( 1.0 - saturate15 );
			float4 Node49Port0FLOAT4=( tex2D( _Metallic,input.uv_Metallic) + FLOATToFLOAT41 );
			output.Metallic = Node49Port0FLOAT4.x;
			float4 FLOATToFLOAT43=( 1.0 - saturate15 );
			output.Smoothness = ( ( tex2D( _Metallic,input.uv_Metallic) + FLOATToFLOAT43 ) * _SmoothnessFactor ).x;
			output.Occlusion = tex2D( _Occlusion,input.uv_Occlusion).x;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=12
242;100;1391;704;1164.707;409.5154;1.3;True;False
Node;AmplifyShaderEditor.CommentaryNode;27;-1268.119,489.6995;1032.899;469.7996;Cutoff;9;15;2;16;5;14;30;54;47;50
Node;AmplifyShaderEditor.CommentaryNode;21;-914.6158,-533.7644;719.1993;440.2003;Color Stuff;4;20;19;18;17
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;432.1003,45.80003;True;Standard;ASESampleShaders/LocalPosCutoff;False;False;False;False;False;False;False;False;False;False;False;False;Back;On;LEqual;Opaque;0.5;True;True;0;False;Opaque;Geometry;0,0,0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0,0,0;0,0,0;0,0,0
Node;AmplifyShaderEditor.SimpleDivideOpNode;16;-876.0185,742.7026;0.0;0.0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1254.918,841.5022;Property;_Distribution;Distribution;1;0.1;10
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;182.0511,215.8345;0.0,0,0,0;0.0
Node;AmplifyShaderEditor.RangedFloatNode;34;-108.9506,481.5498;Property;_SmoothnessFactor;SmoothnessFactor;0;0;1
Node;AmplifyShaderEditor.LerpOp;52;-233.6482,-23.06393;0.0,0,0,0;0,0,0,0;0.0
Node;AmplifyShaderEditor.ClampOpNode;30;-492.2693,530.6258;0.0;0.0;1.0
Node;AmplifyShaderEditor.SimpleAddOpNode;49;0.6511464,115.0344;0.0,0,0,0;0.0
Node;AmplifyShaderEditor.LocalVertexPosNode;47;-1234.361,543.9348
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-997.0165,635.501;0.0;0.0
Node;AmplifyShaderEditor.SaturateNode;15;-712.8203,722.0024;0.0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1247.918,722.3019;Property;_StartPoint;StartPoint;0.75;-10;10
Node;AmplifyShaderEditor.RangedFloatNode;54;-851.6987,535.1356;Property;_UnderwaterInfluence;UnderwaterInfluence;0;0;1
Node;AmplifyShaderEditor.OneMinusNode;50;-422.1988,688.3354;0.0
Node;AmplifyShaderEditor.ColorNode;53;-519.748,-93.96416;Property;_Tint;Tint;0.5294118,0.4264289,0,0
Node;AmplifyShaderEditor.WorldPosInputsNode;59;-1229.238,316.9132
Node;AmplifyShaderEditor.SamplerNode;19;-864.6157,-466.2642;Property;_Normals;Normals;None;True;0;True;bump;Auto;True;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;17;-512.4171,-483.7644;Property;_Albedo;Albedo;None;True;0;False;white;Auto;False;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;20;-838.4163,-314.6636;Property;_Occlusion;Occlusion;None;True;0;False;white;Auto;False;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;18;-526.317,-278.5635;Property;_Metallic;Metallic;None;True;0;False;white;Auto;False;0,0;1.0
WireConnection;0;0;52;0
WireConnection;0;1;19;0
WireConnection;0;3;49;0
WireConnection;0;4;51;0
WireConnection;0;5;20;0
WireConnection;16;0;14;0
WireConnection;16;1;5;0
WireConnection;51;0;49;0
WireConnection;51;1;34;0
WireConnection;52;0;53;0
WireConnection;52;1;17;0
WireConnection;52;2;30;0
WireConnection;30;0;15;0
WireConnection;30;1;54;0
WireConnection;49;0;18;0
WireConnection;49;1;50;0
WireConnection;14;0;47;2
WireConnection;14;1;2;0
WireConnection;15;0;16;0
WireConnection;50;0;15;0
ASEEND*/
//CHKSM=544C72E3E3449CD9D9F7CA3AE501EE65E9606E27