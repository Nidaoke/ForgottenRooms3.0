// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/BurnEffect"
{
	Properties
	{
		EmberColorTint("Ember Color Tint", Color) = (0.9926471,0.6777384,0,1)
		GlowColorIntensity("Glow Color Intensity", Range( 0 , 10)) = 0
		_AlbedoMix("Albedo Mix", Range( 0 , 1)) = 0.5
		BaseEmber("Base Ember", Range( 0 , 1)) = 0
		GlowEmissionMultiplier("Glow Emission Multiplier", Range( 0 , 30)) = 1
		[HideInInspector] __dirty( "", Int ) = 1
		GlowBaseFrequency("Glow Base Frequency", Range( 0 , 5)) = 1.1
		GlowOverride("Glow Override", Range( 0 , 10)) = 1
		_CharcoalNormalTile("Charcoal Normal Tile", Range( 2 , 5)) = 5
		_CharcoalMix("Charcoal Mix", Range( 0 , 1)) = 1
		Normals("Normals", 2D) = "bump" {}
		BurntTileNormals("Burnt Tile Normals", 2D) = "white" {}
		_BurnTilling("Burn Tilling", Range( 0.1 , 1)) = 1
		Albedo("Albedo", 2D) = "white" {}
		Masks("Masks", 2D) = "white" {}
		_BurnOffset("Burn Offset", Range( 0 , 5)) = 1
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
			float2 texcoord_0;
			float2 texcoord_1;
		};

		uniform sampler2D Normals;
		uniform sampler2D BurntTileNormals;
		uniform float _CharcoalNormalTile;
		uniform float _CharcoalMix;
		uniform sampler2D Masks;
		uniform float _BurnOffset;
		uniform float _BurnTilling;
		uniform sampler2D Albedo;
		uniform float _AlbedoMix;
		uniform float BaseEmber;
		uniform float4 EmberColorTint;
		uniform float GlowColorIntensity;
		uniform float GlowBaseFrequency;
		uniform float GlowOverride;
		uniform float GlowEmissionMultiplier;

		void vertexDataFunc(inout appdata_full vertexData, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			o.texcoord_0.xy = vertexData.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
			o.texcoord_1.xy = vertexData.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
		}

		void surf( Input input , inout SurfaceOutputStandard output )
		{
			float2 FLOATToFLOAT250=_CharcoalNormalTile;
			float4 tex2DNode83 = tex2D( BurntTileNormals,( input.texcoord_0 * FLOATToFLOAT250 ));
			float2 FLOATToFLOAT270=_BurnTilling;
			float4 tex2DNode98 = tex2D( Masks,frac(abs( ( input.texcoord_1 * FLOATToFLOAT270 )+_BurnOffset * float2(1,0.5 ))));
			output.Normal = lerp( float4( UnpackNormal( tex2D( Normals,input.texcoord_0) ) , 0.0 ) , tex2DNode83 , ( _CharcoalMix + tex2DNode98.r ) ).xyz;
			float4 tex2DNode80 = tex2D( Albedo,input.texcoord_1);
			float4 FLOATToFLOAT4340=_AlbedoMix;
			float4 FLOATToFLOAT4280=0.0;
			float4 FLOATToCOLOR1460=( tex2DNode83.a * 2.95 );
			float4 FLOATToCOLOR1360=( tex2DNode83.a * 4.2 );
			float4 FLOATToCOLOR1490=tex2DNode98.r;
			float4 FLOATToCOLOR1510=BaseEmber;
			output.Albedo = lerp( lerp( ( tex2DNode80 * FLOATToFLOAT4340 ) , FLOATToFLOAT4280 , ( _CharcoalMix + tex2DNode98.r ) ) , ( ( lerp( ( float4(0.718,0.0627451,0,1) * FLOATToCOLOR1460 ) , ( float4(0.647,0.06297875,0,1) * FLOATToCOLOR1360 ) , tex2DNode98.g ) * FLOATToCOLOR1490 ) * FLOATToCOLOR1510 ) , ( tex2DNode98.r * 1.0 ) ).rgb;
			float4 FLOATToCOLOR1270=tex2DNode98.r;
			float4 FLOATToCOLOR650=GlowColorIntensity;
			float4 FLOATToCOLOR700=( ( sin( ( _Time[1] * GlowBaseFrequency ) ) * 0.5 ) + ( GlowOverride * ( tex2DNode98.r * tex2DNode83.a ) ) );
			float4 FLOATToCOLOR1010=tex2DNode98.g;
			float4 FLOATToCOLOR1060=tex2DNode83.a;
			float4 FLOATToCOLOR1570=GlowEmissionMultiplier;
			output.Emission = clamp( ( ( FLOATToCOLOR1270 * ( ( ( ( EmberColorTint * FLOATToCOLOR650 ) * FLOATToCOLOR700 ) * FLOATToCOLOR1010 ) * FLOATToCOLOR1060 ) ) * FLOATToCOLOR1570 ) , 0.0 , 100.0 ).rgb;
			output.Smoothness = tex2DNode80.a;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=21
509;157;1214;765;360.5961;303.6724;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;130;-2566.58,462.9727;2529.991;765.4811;Emission;17;157;158;69;66;95;68;67;76;73;77;127;65;70;106;101;170;174
Node;AmplifyShaderEditor.CommentaryNode;128;-3118.95,-279.5554;1648.54;574.2015;;9;7;9;11;10;98;13;19;129;180
Node;AmplifyShaderEditor.CommentaryNode;129;-1945.302,-227.6195;471.6918;296.3271;Mix Base Albedo;0
Node;AmplifyShaderEditor.CommentaryNode;39;-2354.221,1634.534;1333.056;554.484;Base + Burnt Detail Mix (1 Free Alpha channels if needed);6;82;6;5;40;103;179
Node;AmplifyShaderEditor.CommentaryNode;40;-1796.12,1849.328;343.3401;246.79;Emission in Alpha;1;83
Node;AmplifyShaderEditor.CommentaryNode;38;-1752.147,-1032.491;1183.903;527.3994;Albedo - Smoothness in Alpha;5;35;27;34;28;80
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-1277.102,-982.4909;0,0,0,0;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-1279.204,-773.5922;Constant;_RangedFloatNode27;_RangedFloatNode27;-1;0;0;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-1666.103,-951.4903;Property;_AlbedoMix;Albedo Mix;-1;0.5;0;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-2686.548,-127.2553;0,0;0
Node;AmplifyShaderEditor.PannerNode;9;-2442.548,-69.0541;1;0.5;0,0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-1635.11,-49.29237;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-1374.632,659.5688;0,0,0,0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-1650.418,755.3741;0,0,0,0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-1833.5,705.4734;0,0,0,0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;127;-952.7081,532.5618;0;0,0,0,0
Node;AmplifyShaderEditor.LerpOp;28;-970.9127,-675.8198;0,0,0,0;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;-735.1851,46.52425;0,0,0,0;0
Node;AmplifyShaderEditor.ColorNode;147;-1134.788,-277.6757;Constant;ColorNode39134147;ColorNode39134 147;-1;0.718,0.0627451,0,1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-864.0865,-85.57518;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;146;-718.0855,-186.0759;0,0,0,0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;151;-118.0104,-148.7752;0,0,0,0;0
Node;AmplifyShaderEditor.LerpOp;152;247.1904,-253.5751;0,0,0,0;0,0,0,0;0
Node;AmplifyShaderEditor.RangedFloatNode;144;-1201.686,-84.4754;Constant;R2144;R2 144;-1;2.95;0;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;154;41.58921,-45.27597;0;0
Node;AmplifyShaderEditor.RangedFloatNode;156;-182.4112,109.8244;Constant;RangedFloatNode156;RangedFloatNode 156;-1;1;0;2
Node;AmplifyShaderEditor.RangedFloatNode;150;-535.9109,125.925;Property;BaseEmber;Base Ember;-1;0;0;1
Node;AmplifyShaderEditor.LerpOp;148;-532.6986,-105.8688;0,0,0,0;0,0,0,0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-348.4115,-25.67536;0,0,0,0;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;521.204,-107.2724;True;Standard;ASESampleShaders/BurnEffect;False;False;False;False;False;False;False;False;False;False;False;False;Back;On;LEqual;Opaque;0;True;True;0;False;Opaque;Geometry;0;0,0,0;0,0,0;0,0,0;0;0;0;0;0.0;0.0;0.0;0,0,0
Node;AmplifyShaderEditor.SamplerNode;80;-1643.756,-782.4553;Property;Albedo;Albedo;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.RangedFloatNode;77;-2516.58,713.7126;Property;GlowColorIntensity;Glow Color Intensity;-1;0;0;10
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-1971.32,1872.128;0,0;0
Node;AmplifyShaderEditor.LerpOp;103;-1187.304,1824.428;0,0,0;0,0,0,0;0
Node;AmplifyShaderEditor.TimeNode;67;-2487.243,814.3365
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-2214.131,864.2569;0;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-2048.016,1006.15;Constant;GlowDuration;Glow Duration;-1;0.5;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-1859.748,866.4651;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;157;-597.8378,569.7058;0,0,0,0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;171;-2059.027,1470.798;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;170;-1863.427,1078.999;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;174;-1695.621,992.7978;0;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-2304.22,1979.127;Property;_CharcoalNormalTile;Charcoal Normal Tile;-1;5;2;5
Node;AmplifyShaderEditor.RangedFloatNode;158;-922.8376,723.2053;Property;GlowEmissionMultiplier;Glow Emission Multiplier;-1;1;0;30
Node;AmplifyShaderEditor.RangedFloatNode;10;-3067.554,57.64606;Property;_BurnOffset;Burn Offset;-1;1;0;5
Node;AmplifyShaderEditor.RangedFloatNode;11;-3066.507,-41.68358;Property;_BurnTilling;Burn Tilling;-1;1;0.1;1
Node;AmplifyShaderEditor.RangedFloatNode;13;-1907.802,-165.1195;Property;_CharcoalMix;Charcoal Mix;-1;1;0;1
Node;AmplifyShaderEditor.RangedFloatNode;76;-2501.525,1037.474;Property;GlowBaseFrequency;Glow Base Frequency;-1;1.1;0;5
Node;AmplifyShaderEditor.RangedFloatNode;169;-2446.727,1216.798;Property;GlowOverride;Glow Override;-1;1;0;10
Node;AmplifyShaderEditor.ClampOpNode;176;257.5815,221.0976;0,0,0,0;0,0,0,0;0,0,0,0
Node;AmplifyShaderEditor.ColorNode;73;-2500.298,512.9727;Property;EmberColorTint;Ember Color Tint;-1;0.9926471,0.6777384,0,1
Node;AmplifyShaderEditor.ColorNode;134;-1253.789,180.1245;Constant;ColorNode39134;ColorNode 39 134;-1;0.647,0.06297875,0,1
Node;AmplifyShaderEditor.RangedFloatNode;138;-1244.786,362.2247;Constant;R2;R2;-1;4.2;0;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;137;-877.9863,266.6246;0;0
Node;AmplifyShaderEditor.RangedFloatNode;177;-204.6184,257.1976;Constant;RangedFloatNode177;RangedFloatNode 177;-1;0;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;179;-2197.001,1725.1;0;1,1;0,0
Node;AmplifyShaderEditor.SamplerNode;83;-1771.837,1899.235;Property;BurntTileNormals;Burnt Tile Normals;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.SamplerNode;82;-1802.313,1678.685;Property;Normals;Normals;-1;None;True;2;True;bump;Auto;True;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.TextureCoordinatesNode;180;-3038.006,-242.6004;0;1,1;0,0
Node;AmplifyShaderEditor.SamplerNode;98;-2193.674,88.78339;Property;Masks;Masks;-1;None;True;1;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.SinOpNode;66;-2005.042,836.0363;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-1147.638,615.7524;0,0,0,0;0
Node;AmplifyShaderEditor.RangedFloatNode;178;30.78172,469.7978;Constant;RangedFloatNode178;RangedFloatNode 178;-1;100;0;0
WireConnection;34;0;80;0
WireConnection;34;1;35;0
WireConnection;7;0;180;0
WireConnection;7;1;11;0
WireConnection;9;0;7;0
WireConnection;9;1;10;0
WireConnection;19;0;13;0
WireConnection;19;1;98;1
WireConnection;101;0;70;0
WireConnection;101;1;98;2
WireConnection;70;0;65;0
WireConnection;70;1;174;0
WireConnection;65;0;73;0
WireConnection;65;1;77;0
WireConnection;127;0;98;1
WireConnection;127;1;106;0
WireConnection;28;0;34;0
WireConnection;28;1;27;0
WireConnection;28;2;19;0
WireConnection;136;0;134;0
WireConnection;136;1;137;0
WireConnection;145;0;83;4
WireConnection;145;1;144;0
WireConnection;146;0;147;0
WireConnection;146;1;145;0
WireConnection;151;0;149;0
WireConnection;151;1;150;0
WireConnection;152;0;28;0
WireConnection;152;1;151;0
WireConnection;152;2;154;0
WireConnection;154;0;98;1
WireConnection;154;1;156;0
WireConnection;148;0;146;0
WireConnection;148;1;136;0
WireConnection;148;2;98;2
WireConnection;149;0;148;0
WireConnection;149;1;98;1
WireConnection;0;0;152;0
WireConnection;0;1;103;0
WireConnection;0;2;176;0
WireConnection;0;4;80;4
WireConnection;80;0;180;0
WireConnection;5;0;179;0
WireConnection;5;1;6;0
WireConnection;103;0;82;0
WireConnection;103;1;83;0
WireConnection;103;2;19;0
WireConnection;68;0;67;2
WireConnection;68;1;76;0
WireConnection;69;0;66;0
WireConnection;69;1;95;0
WireConnection;157;0;127;0
WireConnection;157;1;158;0
WireConnection;171;0;98;1
WireConnection;171;1;83;4
WireConnection;170;0;169;0
WireConnection;170;1;171;0
WireConnection;174;0;69;0
WireConnection;174;1;170;0
WireConnection;176;0;157;0
WireConnection;176;1;177;0
WireConnection;176;2;178;0
WireConnection;137;0;83;4
WireConnection;137;1;138;0
WireConnection;83;0;5;0
WireConnection;82;0;179;0
WireConnection;98;0;9;0
WireConnection;66;0;68;0
WireConnection;106;0;101;0
WireConnection;106;1;83;4
ASEEND*/
//CHKSM=130010EECD2C66ED496F6330E48A4038F481B4D4