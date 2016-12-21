Shader "Custom/GrabPass Distortion"
{
	Properties
	{
		_MainTex ("Texture (R,G=X,Y Distortion; B=Mask; A=Unused)", 2D) = "white" {} //Texture here is used to create randomness distortion look
		_IntensityAndScrolling ("Intensity (XY); Scrolling (ZW)", Vector) = (0.1,0.1,1,1) //Intensity of distortion + speed it moves
		_DistanceFade ("Distance Fade (X=Near, Y=Far, ZW=Unused)", Float) = (20, 50, 0, 0) //Affects distortion based on distance
		[Toggle(MASK)] _MASK ("Texture Blue channel is Mask", Float) = 0 //Masking
		[Toggle(MIRROR_EDGE)] _MIRROR_EDGE ("Mirror screen borders", Float) = 0 //Mirror edge
		[Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Culling", Float) = 0 //Directional culling

		[Toggle(DEBUGUV)] _DEBUGUV ("Debug Texture Coordinates", Float) = 0 //Debug stuff
		[Toggle(DEBUGDISTANCEFADE)] _DEBUGDISTANCEFADE ("Debug Distance Fade", Float) = 0
	}

	SubShader
	{
		Tags {"Queue" = "Transparent" "IgnoreProjector" = "True"} //Draw after opaqe + don't use projections (Not needed!)
		Blend One Zero //REMEMBER: Blend x y; x is the texture on top, y on bottom. We're making the stuff behind invisible (y = zero) and only the distorted version on top (x = one)
		Lighting Off //Cause the color to be set from the Color, not Material; Not super important, can be removed ??
		Fog { Mode Off } //Don't be affected by fog
		ZWrite Off //Don't draw depth (Used if transparent)
		LOD 200 //Diffuese shader
		Cull [_CullMode] //Set the cull to variable
		
		// See http://docs.unity3d.com/Manual/SL-GrabPass.html
		// Will grab screen contents into a texture, but will only do that once per frame for
		// the first object that uses the given texture name. 
		GrabPass{ "_GrabTexture" }
	
		Pass
		{  
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma shader_feature MASK
				#pragma shader_feature MIRROR_EDGE
				#pragma shader_feature DEBUGUV
				#pragma shader_feature DEBUGDISTANCEFADE

				#include "UnityCG.cginc"
				#include "GrabPassDistortion.cginc"
			ENDCG
		}
	}
}
