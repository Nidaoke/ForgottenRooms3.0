// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/SnowAccum"
{
	Properties
	{
		_snow_specular("snow_specular", 2D) = "white" {}
		_Metallic("Metallic", 2D) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		_Occlusion("Occlusion", 2D) = "white" {}
		_snow_albedo("snow_albedo", 2D) = "white" {}
		_snow_normal("snow_normal", 2D) = "bump" {}
		_Normal("Normal", 2D) = "bump" {}
		_Albedo("Albedo", 2D) = "white" {}
		_SnowAmount("SnowAmount", Range( 0 , 2)) = 0.13
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
			float2 uv_Normal;
			float2 uv_snow_normal;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_Albedo;
			float2 uv_snow_albedo;
			float2 uv_Metallic;
			float2 uv_snow_specular;
			float2 uv_Occlusion;
		};

		uniform sampler2D _Normal;
		uniform sampler2D _snow_normal;
		uniform float _SnowAmount;
		uniform sampler2D _Albedo;
		uniform sampler2D _snow_albedo;
		uniform sampler2D _Metallic;
		uniform sampler2D _snow_specular;
		uniform sampler2D _Occlusion;

		void surf( Input input , inout SurfaceOutputStandard output )
		{
			output.Normal = lerp( UnpackNormal( tex2D( _Normal,input.uv_Normal) ) , UnpackNormal( tex2D( _snow_normal,input.uv_snow_normal) ) , saturate( ( WorldNormalVector( input , output.Normal ).y * _SnowAmount ) ) );
			output.Albedo = lerp( tex2D( _Albedo,input.uv_Albedo) , tex2D( _snow_albedo,input.uv_snow_albedo) , saturate( ( WorldNormalVector( input , output.Normal ).y * _SnowAmount ) ) ).xyz;
			output.Metallic = lerp( tex2D( _Metallic,input.uv_Metallic) , tex2D( _snow_specular,input.uv_snow_specular) , saturate( ( WorldNormalVector( input , output.Normal ).y * _SnowAmount ) ) ).x;
			output.Occlusion = tex2D( _Occlusion,input.uv_Occlusion).x;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=21
509;157;1214;765;1796.305;746.4951;1.9;True;False
Node;AmplifyShaderEditor.SamplerNode;14;-901.4,190.8999;Property;_snow_normal;snow_normal;-1;None;True;0;True;bump;Auto;True;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;16;-783.6018,624.7004;Property;_snow_specular;snow_specular;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.LerpOp;17;-343.8018,471.8007;0.0,0,0,0;0,0,0,0;0.0
Node;AmplifyShaderEditor.LerpOp;15;-222.4,23.8999;0.0,0,0;0,0,0;0.0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;146.9001,42.89999;True;Standard;ASESampleShaders/SnowAccum;False;False;False;False;False;False;False;False;False;False;False;False;Back;On;LEqual;Opaque;0.5;True;True;0;False;Opaque;Geometry;0,0,0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0,0,0;0,0,0;0,0,0
Node;AmplifyShaderEditor.LerpOp;10;-292.4,-356.1001;0.0,0,0,0;0.0,0,0,0;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-731.1985,-265.9;0.0;0.0
Node;AmplifyShaderEditor.SaturateNode;18;-538.1042,-157.1975;0.0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1039.799,-125.9001;Property;_SnowAmount;SnowAmount;-1;0.13;0;2
Node;AmplifyShaderEditor.SamplerNode;1;-811.4,-722.1001;Property;_Albedo;Albedo;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;4;-902.6,30.49988;Property;_Normal;Normal;-1;None;True;0;True;bump;Auto;True;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;2;-813.4,407.8999;Property;_Metallic;Metallic;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;3;-242.4,627.8999;Property;_Occlusion;Occlusion;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.WorldNormalVector;19;-1055.104,-375.7964;0,0,0
Node;AmplifyShaderEditor.SamplerNode;9;-891.8005,-532.0003;Property;_snow_albedo;snow_albedo;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
WireConnection;17;0;2;0
WireConnection;17;1;16;0
WireConnection;17;2;18;0
WireConnection;15;0;4;0
WireConnection;15;1;14;0
WireConnection;15;2;18;0
WireConnection;0;0;10;0
WireConnection;0;1;15;0
WireConnection;0;3;17;0
WireConnection;0;5;3;0
WireConnection;10;0;1;0
WireConnection;10;1;9;0
WireConnection;10;2;18;0
WireConnection;11;0;19;2
WireConnection;11;1;12;0
WireConnection;18;0;11;0
ASEEND*/
//CHKSM=300B5E00A94A8C40D19ED013D996652D562F9BAD