/********************************************************************************//**
\file      ColorGrabbable.cs
\brief     Simple component that changes color based on grab state.
\copyright Copyright 2015 Oculus VR, LLC All Rights reserved.
************************************************************************************/

using UnityEngine;
using OVRTouchSample;

namespace OVRTouchSample
{
    public class ColorGrabbable : Grabbable
    {
        public static readonly Color COLOR_GRAB = new Color(1.0f, 0.5f, 0.0f, 1.0f);

        private Color m_color = Color.black;
        private MeshRenderer[] m_meshRenderers = null;

        override public void GrabBegin(Hand hand, Collider grabbableCollider)
        {
            base.GrabBegin(hand, grabbableCollider);

            SetColor(COLOR_GRAB);
        }

        override public void GrabEnd(Vector3 linearVelocity, Vector3 angularVelocity)
        {
            base.GrabEnd(linearVelocity, angularVelocity);

            SetColor(m_color);
        }

        override protected void Awake()
        {
            base.Awake();
            m_color = new Color(
                Random.Range(0.1f, 0.95f),
                Random.Range(0.1f, 0.95f),
                Random.Range(0.1f, 0.95f),
                1.0f
            );
            m_meshRenderers = this.GetComponentsInChildren<MeshRenderer>();
            SetColor(m_color);
        }

        private void SetColor(Color color)
        {
            for (int i = 0; i < m_meshRenderers.Length; ++i)
            {
                MeshRenderer meshRenderer = m_meshRenderers[i];
                for (int j = 0; j < meshRenderer.materials.Length; ++j)
                {
                    Material meshMaterial = meshRenderer.materials[j];
                    meshMaterial.color = color;
                }
            }
        }
    }
}
