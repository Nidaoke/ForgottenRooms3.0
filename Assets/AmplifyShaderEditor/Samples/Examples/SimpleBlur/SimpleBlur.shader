// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/SimpleBlur"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_MainSample("MainSample", 2D) = "white" {}
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
			float2 texcoord_0;
			float2 texcoord_1;
			float2 texcoord_2;
			float2 texcoord_3;
		};

		uniform sampler2D _MainSample;

		void vertexDataFunc(inout appdata_full vertexData, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			o.texcoord_0.xy = vertexData.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
			o.texcoord_1.xy = vertexData.texcoord.xy * float2( 1,1 ) + float2( 0,0.01 );
			o.texcoord_2.xy = vertexData.texcoord.xy * float2( 1,1 ) + float2( 0.01,0 );
			o.texcoord_3.xy = vertexData.texcoord.xy * float2( 1,1 ) + float2( 0.01,0.01 );
		}

		void surf( Input input , inout SurfaceOutputStandard output )
		{
			float4 FLOATToFLOAT4210=0.4;
			float4 FLOATToFLOAT4220=0.2;
			float4 FLOATToFLOAT4230=0.2;
			float4 FLOATToFLOAT4240=0.2;
			output.Emission = ( ( ( ( tex2D( _MainSample,input.texcoord_0) * FLOATToFLOAT4210 ) + ( tex2D( _MainSample,input.texcoord_1) * FLOATToFLOAT4220 ) ) + ( tex2D( _MainSample,input.texcoord_2) * FLOATToFLOAT4230 ) ) + ( tex2D( _MainSample,input.texcoord_3) * FLOATToFLOAT4240 ) ).xyz;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=21
509;157;1214;765;1501.901;940.198;1;True;False
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;152,17;True;Standard;ASESampleShaders/SimpleBlur;False;False;False;False;False;False;False;False;False;False;False;False;Back;On;LEqual;Opaque;0.5;True;True;0;False;Opaque;Geometry;0,0,0;0,0,0;0,0,0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0,0,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-525.3992,219.1006;0.0,0,0,0;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-509.7991,483.0006;0.0,0,0,0;0.0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-346.0005,-372.3999;0,0,0,0;0,0,0,0
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-110,104.6;0.0,0,0,0;0,0,0,0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1153.901,-581.9991;0;1,1;0,0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-1168.701,-290.3001;0;1,1;0,0.01
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-1114.1,-2.479553E-05;0;1,1;0.01,0
Node;AmplifyShaderEditor.SamplerNode;8;-940.7994,448.3;Property;_TextureSample2;Texture Sample 2;-1;None;True;0;False;white;Auto;False;Instance;0;0,0;1.0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1165.801,406.3;0;1,1;0.01,0.01
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-515.0012,-569.9993;0.0,0,0,0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-521.4998,-241.0996;0.0,0,0,0;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-690.4989,-456.8986;Constant;_Float0;Float 0;-1;0.4;0;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-657.999,-112.3987;Constant;_Float1;Float 1;-1;0.2;0;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-682.6975,319.201;Constant;_Float2;Float 2;-1;0.2;0;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-618.9985,632.5013;Constant;_Float3;Float 3;-1;0.2;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-274.2003,-49.30003;0.0,0,0,0;0,0,0,0
Node;AmplifyShaderEditor.SamplerNode;7;-898.8001,53.70006;Property;_TextureSample1;Texture Sample 1;-1;None;True;0;False;white;Auto;False;Instance;0;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;29;-904.9965,-660.8977;Property;_TextureSample3;Texture Sample 3;-1;None;True;0;False;white;Auto;False;Instance;0;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;6;-947.9997,-324.3;Property;_TextureSample0;Texture Sample 0;-1;None;True;0;False;white;Auto;False;Instance;0;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;5;-1185.401,-944.6984;Property;_MainSample;MainSample;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
WireConnection;0;2;15;0
WireConnection;23;0;7;0
WireConnection;23;1;27;0
WireConnection;24;0;8;0
WireConnection;24;1;28;0
WireConnection;13;0;21;0
WireConnection;13;1;22;0
WireConnection;15;0;14;0
WireConnection;15;1;24;0
WireConnection;8;0;12;0
WireConnection;21;0;29;0
WireConnection;21;1;25;0
WireConnection;22;0;6;0
WireConnection;22;1;26;0
WireConnection;14;0;13;0
WireConnection;14;1;23;0
WireConnection;7;0;11;0
WireConnection;29;0;9;0
WireConnection;6;0;10;0
ASEEND*/
//CHKSM=E3F4D43C956993F9F3AB3CBBDD8417AA886497E9