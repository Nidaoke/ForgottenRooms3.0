Shader "GhostShaders/TransparentTest"
{
	Properties
	{
		_ShaderColor("Color", Color) = (1, 1, 1, 1)
	}

	SubShader
	{
		Tags{"Queue" = "Transparent"} //Only draw after opaque stuff
		Pass
		{
			//ZWrite Off //Don't draw depth (Precents Occlusion)
			Blend SrcAlpha OneMinusSrcAlpha //Blend Alphas

			CGPROGRAM //Start of Draw Script

			#pragma target 2.0 //Targets most systems (Non needed to work)
			#pragma vertex vert
			#pragma fragment frag//Vertex + Fragment Shaders

			float4 _ShaderColor; //Define Shader Color

			float4 vert(float4 vertexPos : POSITION) : SV_POSITION{ //Draw vertices at positions
				return mul(UNITY_MATRIX_MVP, vertexPos);
			}

			float4 frag(void) : COLOR{
				return _ShaderColor; //Draw in the shader color
			}

			ENDCG //End drawing
		}
	}
}