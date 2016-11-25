// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "UserSamples/DissolveBurn"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Albedo("Albedo", 2D) = "white" {}
		_Normal("Normal", 2D) = "white" {}
		_DisolveGuide("Disolve Guide", 2D) = "white" {}
		_BurnRamp("Burn Ramp", 2D) = "white" {}
		_DisolveAmount("Disolve Amount", Range( 0 , 1)) = 0
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_Normal;
			float2 uv_Albedo;
			float2 uv_DisolveGuide;
		};

		uniform sampler2D _Normal;
		uniform sampler2D _Albedo;
		uniform float _DisolveAmount;
		uniform sampler2D _DisolveGuide;
		uniform sampler2D _BurnRamp;

		void surf( Input input , inout SurfaceOutputStandard output )
		{
			output.Normal = tex2D( _Normal,input.uv_Normal).xyz;
			output.Albedo = tex2D( _Albedo,input.uv_Albedo).xyz;
			float4 tex2DNode2 = tex2D( _DisolveGuide,input.uv_DisolveGuide);
			output.Emission = ( ( 1.0 - clamp( (-4.0 + (( (-0.6 + (( 1.0 - _DisolveAmount ) - 0.0) * (0.6 - -0.6) / (1.0 - 0.0)) + tex2DNode2.r ) - 0.0) * (4.0 - -4.0) / (1.0 - 0.0)) , 0.0 , 1.0 ) ) * tex2D( _BurnRamp,float2( ( 1.0 - clamp( (-4.0 + (( (-0.6 + (( 1.0 - _DisolveAmount ) - 0.0) * (0.6 - -0.6) / (1.0 - 0.0)) + tex2DNode2.r ) - 0.0) * (4.0 - -4.0) / (1.0 - 0.0)) , 0.0 , 1.0 ) ) , 0 )) ).xyz;
			float Node73Port0FLOAT=( (-0.6 + (( 1.0 - _DisolveAmount ) - 0.0) * (0.6 - -0.6) / (1.0 - 0.0)) + tex2DNode2.r );
			clip( Node73Port0FLOAT - 0.5 );
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=14
688;92;1232;966;1630.922;659.9638;2.5;True;False
Node;AmplifyShaderEditor.CommentaryNode;132;144.1929,26.72195;765.1592;493.9802;Created by The Four Headed Cat @fourheadedcat - www.twitter.com/fourheadedcat;1;0
Node;AmplifyShaderEditor.CommentaryNode;129;-892.9326,49.09825;814.5701;432.0292;Burn Effect - Emission;6;113;126;115;114;112;130
Node;AmplifyShaderEditor.CommentaryNode;128;-967.3727,510.0833;908.2314;498.3652;Dissolve - Opacity Mask;5;4;71;2;73;111
Node;AmplifyShaderEditor.OneMinusNode;71;-655.2471,583.1434;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-202.3633,125.7657;0.0;0,0,0,0
Node;AmplifyShaderEditor.SamplerNode;2;-557.5587,798.9492;Property;_DisolveGuide;Disolve Guide;2;Assets/Sample Shader/Dissolve Burn 1/dissolve-guide.png;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;78;-323.0742,-278.0451;Property;_Albedo;Albedo;0;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.ClampOpNode;113;-797.634,90.31517;0.0;0.0;1.0
Node;AmplifyShaderEditor.OneMinusNode;130;-627.5982,83.10277;0.0
Node;AmplifyShaderEditor.AppendNode;115;-549.438,307.1016;FLOAT2;0;0;0;0;0.0;0.0;0.0;0.0
Node;AmplifyShaderEditor.SamplerNode;114;-422.1431,295.0128;Property;_BurnRamp;Burn Ramp;3;Assets/Sample Shader/Dissolve Burn 1/burn-ramp.png;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.TFHCRemap;111;-526.4305,583.9279;0.0;0.0;1.0;-0.6;0.6
Node;AmplifyShaderEditor.SimpleAddOpNode;73;-319.6845,566.4299;0.0;0.0
Node;AmplifyShaderEditor.RangedFloatNode;4;-919.0424,582.2975;Property;_DisolveAmount;Disolve Amount;4;0;0;1
Node;AmplifyShaderEditor.SamplerNode;131;-325.7014,-110.6792;Property;_Normal;Normal;1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.TFHCRemap;112;-878.1525,280.8961;0.0;0.0;1.0;-4.0;4.0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;435.9929,109.222;True;Standard;UserSamples/DissolveBurn;False;False;False;False;False;False;False;False;False;False;False;False;Off;On;LEqual;Masked;0.5;False;True;0;False;TransparentCutout;AlphaTest;0,0,0;0,0,0;0,0,0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0,0,0
WireConnection;71;0;4;0
WireConnection;126;0;130;0
WireConnection;126;1;114;0
WireConnection;113;0;112;0
WireConnection;130;0;113;0
WireConnection;115;0;130;0
WireConnection;114;0;115;0
WireConnection;111;0;71;0
WireConnection;73;0;111;0
WireConnection;73;1;2;1
WireConnection;112;0;73;0
WireConnection;0;0;78;0
WireConnection;0;1;131;0
WireConnection;0;2;126;0
WireConnection;0;7;73;0
ASEEND*/
//CHKSM=96EBF5179354C6BF89172D23BB2F5397EA978A0B