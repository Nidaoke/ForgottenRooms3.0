// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/ScreenSpaceCurvature"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_ScaleFactor("ScaleFactor", Float) = 4
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
			float3 worldNormal;
			INTERNAL_DATA
			float3 localVertexPos;
		};

		uniform float _ScaleFactor;

		void vertexDataFunc(inout appdata_full vertexData, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			o.localVertexPos = vertexData.vertex.xyz ;
		}

		void surf( Input input , inout SurfaceOutputStandard output )
		{
			float3 normalValue33 = WorldNormalVector( input , output.Normal );
			float3 Node2Port0FLOAT3=ddx( normalValue33 );
			float3 Node7Port0FLOAT3=ddy( normalValue33 );
			float3 FLOATToFLOAT3290=( ( ( cross( ( normalValue33 - Node2Port0FLOAT3 ) , ( normalValue33 + Node2Port0FLOAT3 ) ).y - cross( ( normalValue33 - Node7Port0FLOAT3 ) , ( normalValue33 + Node7Port0FLOAT3 ) ).x ) * _ScaleFactor ) / length( input.localVertexPos ) );
			output.Emission = ( FLOATToFLOAT3290 + float3(0.5,0.5,0.5) );
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=21
509;157;1214;765;242.501;133.4995;1;True;False
Node;AmplifyShaderEditor.SimpleSubtractOpNode;19;-531.6992,126.5998;0.0,0,0;0.0,0,0
Node;AmplifyShaderEditor.CrossProductOpNode;21;-373.0967,-141.1999;0,0,0;0,0,0
Node;AmplifyShaderEditor.SimpleAddOpNode;20;-536.899,289.1003;0.0,0,0;0.0,0,0
Node;AmplifyShaderEditor.BreakToComponentsNode;24;-212.5965,203.3003;FLOAT3;0.0,0,0
Node;AmplifyShaderEditor.BreakToComponentsNode;23;-206.0973,-189.2997;FLOAT3;0.0,0,0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;25;8.402822,-21.59954;0.0;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;173.5023,10.90066;0.0;0.0
Node;AmplifyShaderEditor.LengthOpNode;16;92.40041,431.3006;0,0,0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;479.1028,217.2994;0.0;0.0,0,0
Node;AmplifyShaderEditor.DdyOpNode;7;-820.8997,285.6999;0.0,0,0
Node;AmplifyShaderEditor.DdxOpNode;2;-835.1998,-79.59997;0.0,0,0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;17;-573.0988,-142.6001;0.0,0,0;0.0,0,0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-575.8983,-12.50004;0.0,0,0;0.0,0,0
Node;AmplifyShaderEditor.CrossProductOpNode;22;-375.2969,147;0,0,0;0,0,0
Node;AmplifyShaderEditor.WorldNormalVector;33;-1093.197,86.89935;0,0,0
Node;AmplifyShaderEditor.RangedFloatNode;27;19.00231,144.3006;Property;_ScaleFactor;ScaleFactor;-1;4;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;28;305.8015,139.5998;0.0;0.0
Node;AmplifyShaderEditor.Vector3Node;30;288.9025,325.6991;Constant;_Vector0;Vector 0;-1;0.5,0.5,0.5
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;652.9998,-97.9001;True;Standard;ASESampleShaders/ScreenSpaceCurvature;False;False;False;False;False;False;False;False;False;False;False;False;Back;On;LEqual;Opaque;0.5;True;True;0;False;Opaque;Geometry;0,0,0;0,0,0;0,0,0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0,0,0
Node;AmplifyShaderEditor.LocalVertexPosNode;14;-108.1999,367.4005
WireConnection;19;0;33;0
WireConnection;19;1;7;0
WireConnection;21;0;17;0
WireConnection;21;1;18;0
WireConnection;20;0;33;0
WireConnection;20;1;7;0
WireConnection;24;0;22;0
WireConnection;23;0;21;0
WireConnection;25;0;23;1
WireConnection;25;1;24;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;16;0;14;0
WireConnection;29;0;28;0
WireConnection;29;1;30;0
WireConnection;7;0;33;0
WireConnection;2;0;33;0
WireConnection;17;0;33;0
WireConnection;17;1;2;0
WireConnection;18;0;33;0
WireConnection;18;1;2;0
WireConnection;22;0;19;0
WireConnection;22;1;20;0
WireConnection;28;0;26;0
WireConnection;28;1;16;0
WireConnection;0;11;29;0
ASEEND*/
//CHKSM=1EE7E50B3A1C95FA7CAE3D8ABFCA1A4BC7053D59