// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "UserSamples/EnvironmentGradient"
{
	Properties
	{
		_Top_XZ("Top_XZ", Color) = (0.2569204,0.5525266,0.7279412,0)
		_Bot_Y("Bot_Y", Color) = (0.3877363,0.5955882,0.188311,0)
		_Top_Y("Top_Y", Color) = (0.7259277,0.7647059,0.06185123,0)
		[HideInInspector] __dirty( "", Int ) = 1
		_GradientHeight("GradientHeight", Range( 0 , 20)) = 6.4
		_Bot_XZ("Bot_XZ", Color) = (0.7058823,0.2024221,0.2024221,0)
		_EdgeColor("EdgeColor", Color) = (0.9411765,0.9197947,0.7474049,0)
		_NormalMap("NormalMap", 2D) = "bump" {}
		_EdgeMultiplier("EdgeMultiplier", Range( 0 , 5)) = 1
		_AO_Power("AO_Power", Range( 0 , 4)) = 1
		_R_AO_G_Edges("R_AO_G_Edges", 2D) = "white" {}
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
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
		};

		uniform sampler2D _NormalMap;
		uniform float4 _EdgeColor;
		uniform float _EdgeMultiplier;
		uniform sampler2D _R_AO_G_Edges;
		uniform float _AO_Power;
		uniform float4 _Bot_XZ;
		uniform float4 _Bot_Y;
		uniform float4 _Top_XZ;
		uniform float4 _Top_Y;
		uniform float _GradientHeight;

		void vertexDataFunc(inout appdata_full vertexData, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			o.texcoord_0.xy = vertexData.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
		}

		void surf( Input input , inout SurfaceOutputStandard output )
		{
			output.Normal = UnpackNormal( tex2D( _NormalMap,input.texcoord_0) );
			float4 tex2DNode13 = tex2D( _R_AO_G_Edges,input.texcoord_0);
			float3 abs22 = abs( WorldNormalVector( input , float3( 0,0,1 )) );
			output.Albedo = clamp( ( ( _EdgeColor * ( _EdgeMultiplier * tex2DNode13.g ) ) + ( pow( tex2DNode13.r , _AO_Power ) * lerp( lerp( _Bot_XZ , _Bot_Y , ( abs22 * abs22 ).y.x ) , lerp( _Top_XZ , _Top_Y , ( abs22 * abs22 ).y.x ) , clamp( ( input.worldPos.y / _GradientHeight ) , 0.0 , 1.0 ) ) ) ) , 0.0 , 1.0 ).rgb;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=14
688;92;1232;966;4008.256;3070.055;5.210643;True;False
Node;AmplifyShaderEditor.CommentaryNode;55;1607.965,38.88491;596.7905;477.5201;Created by Mourelas Konstantinos @mourelask - www.moure.xyz;1;0
Node;AmplifyShaderEditor.CommentaryNode;54;-250.27,968.5449;574.3599;190.4;Lerp the Bottom and Top Colors according to the world gradient;1;28
Node;AmplifyShaderEditor.CommentaryNode;53;526.0432,467.4425;431;239;Normal Map;1;9
Node;AmplifyShaderEditor.CommentaryNode;52;-1809.752,-980.1052;886;278;Custom Map (Ambient Occlusion on Red Channel, Edges-like curvature map on Green Channel);1;13
Node;AmplifyShaderEditor.CommentaryNode;51;568.7342,84.52158;918;182;Final Clamp, you can disable it or rise the max value if you want to produce values higher than 1 for HDR;1;42
Node;AmplifyShaderEditor.CommentaryNode;50;267.7985,-587.8406;273.22;179.4799;Combine Edge color with add;1;38
Node;AmplifyShaderEditor.CommentaryNode;49;16.10875,-872.9755;268.1501;198.07;Combine AO with multiply;1;39
Node;AmplifyShaderEditor.CommentaryNode;48;-836.3126,-1205.842;577.7001;260.6001;Properties to affect the AO;2;41;40
Node;AmplifyShaderEditor.CommentaryNode;47;-831.4337,-898.4309;732.6006;499.3974;Properties to affect the edge highlight;4;30;35;37;36
Node;AmplifyShaderEditor.CommentaryNode;46;-2264.596,-210.1021;730.3268;510.8144;Create the world gradient;6;7;2;5;32;33;34
Node;AmplifyShaderEditor.CommentaryNode;45;-1762.024,1189.983;907.8201;534.3306;The same lerp for the Top Gradient Colors;3;27;26;25
Node;AmplifyShaderEditor.CommentaryNode;44;-1757.627,730.2855;897.6793;426.1704;Lerp the 2 Gradient Bottom Colors according to the above normals y vector;3;21;17;19
Node;AmplifyShaderEditor.CommentaryNode;43;-2309.229,387.8848;901.0599;287.59;Get World Y Vector Mask;4;23;8;22;15
Node;AmplifyShaderEditor.WorldNormalInputsNode;8;-2272.451,474.9954
Node;AmplifyShaderEditor.AbsOpNode;22;-2001.508,487.0916;0.0,0,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1802.105,484.8918;0.0,0,0;0.0,0,0
Node;AmplifyShaderEditor.ComponentMaskNode;23;-1620.908,491.5916;False;True;False;True;0,0,0
Node;AmplifyShaderEditor.LerpOp;17;-1086.904,837.2902;0.0,0,0,0;0.0,0,0,0;0.0,0,0,0
Node;AmplifyShaderEditor.ColorNode;21;-1710.605,947.5924;Property;_Bot_Y;Bot_Y;-1;0.3877363,0.5955882,0.188311,0
Node;AmplifyShaderEditor.ColorNode;19;-1710.304,780.3916;Property;_Bot_XZ;Bot_XZ;-1;0.7058823,0.2024221,0.2024221,0
Node;AmplifyShaderEditor.ColorNode;25;-1699.706,1273.792;Property;_Top_XZ;Top_XZ;-1;0.2569204,0.5525266,0.7279412,0
Node;AmplifyShaderEditor.ColorNode;26;-1708.009,1484.99;Property;_Top_Y;Top_Y;-1;0.7259277,0.7647059,0.06185123,0
Node;AmplifyShaderEditor.LerpOp;27;-1096.107,1417.091;0.0,0,0,0;0.0,0,0,0;0.0,0,0,0
Node;AmplifyShaderEditor.WorldPosInputsNode;7;-2152.796,-160.1021
Node;AmplifyShaderEditor.RangedFloatNode;2;-2214.596,7.199674;Property;_GradientHeight;GradientHeight;-1;6.4;0;20
Node;AmplifyShaderEditor.SimpleDivideOpNode;5;-1896.661,-81.79171;0.0;0.0
Node;AmplifyShaderEditor.ClampOpNode;32;-1722.269,-84.3163;0.0;0.0;0.0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1935.627,86.51085;Constant;_Float0;Float 0;-1;0;0;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-1938.991,180.7123;Constant;_Float1;Float 1;-1;1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-458.5143,-542.0326;0.0;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-257.8333,-542.6294;0.0,0,0,0;0.0
Node;AmplifyShaderEditor.RangedFloatNode;41;-786.3125,-1065.242;Property;_AO_Power;AO_Power;-1;1;0;4
Node;AmplifyShaderEditor.PowerNode;40;-417.6125,-1155.842;0.0;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;66.10875,-822.9755;0.0;0,0,0,0
Node;AmplifyShaderEditor.SimpleAddOpNode;38;317.7985,-537.8406;0,0,0,0;0.0,0,0,0
Node;AmplifyShaderEditor.ClampOpNode;42;618.7342,134.5216;0.0,0,0,0;0,0,0,0;0,0,0,0
Node;AmplifyShaderEditor.SamplerNode;13;-1759.752,-930.1052;Property;_R_AO_G_Edges;R_AO_G_Edges;-1;None;True;0;False;white;Auto;False;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-2167.653,-535.7055;0;1,1;0,0
Node;AmplifyShaderEditor.SamplerNode;9;576.0432,517.4425;Property;_NormalMap;NormalMap;-1;None;True;0;True;bump;Auto;True;Object;-1;0,0;1.0
Node;AmplifyShaderEditor.LerpOp;28;-200.27,1018.545;0.0,0,0,0;0,0,0,0;0.0
Node;AmplifyShaderEditor.RangedFloatNode;37;-781.4337,-666.7295;Property;_EdgeMultiplier;EdgeMultiplier;-1;1;0;5
Node;AmplifyShaderEditor.ColorNode;36;-705.3331,-848.4308;Property;_EdgeColor;EdgeColor;-1;0.9411765,0.9197947,0.7474049,0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1778.777,125.7652;True;Standard;UserSamples/EnvironmentGradient;False;False;False;False;False;False;False;False;False;False;False;False;Back;On;LEqual;Opaque;0.5;True;True;0;False;Opaque;Geometry;0,0,0;0,0,0;0,0,0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0,0,0
WireConnection;22;0;8;0
WireConnection;15;0;22;0
WireConnection;15;1;22;0
WireConnection;23;0;15;0
WireConnection;17;0;19;0
WireConnection;17;1;21;0
WireConnection;17;2;23;0
WireConnection;27;0;25;0
WireConnection;27;1;26;0
WireConnection;27;2;23;0
WireConnection;5;0;7;2
WireConnection;5;1;2;0
WireConnection;32;0;5;0
WireConnection;32;1;33;0
WireConnection;32;2;34;0
WireConnection;30;0;37;0
WireConnection;30;1;13;2
WireConnection;35;0;36;0
WireConnection;35;1;30;0
WireConnection;40;0;13;1
WireConnection;40;1;41;0
WireConnection;39;0;40;0
WireConnection;39;1;28;0
WireConnection;38;0;35;0
WireConnection;38;1;39;0
WireConnection;42;0;38;0
WireConnection;42;1;33;0
WireConnection;42;2;34;0
WireConnection;13;0;11;0
WireConnection;9;0;11;0
WireConnection;28;0;17;0
WireConnection;28;1;27;0
WireConnection;28;2;32;0
WireConnection;0;0;42;0
WireConnection;0;1;9;0
ASEEND*/
//CHKSM=AA3F3FA3141CBCD7301B8AE372C3E0D4398929A0