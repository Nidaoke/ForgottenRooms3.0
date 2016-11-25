/********************************************************************************//**
\file      TouchController.cs
\brief     Animating controller that updates with the tracked controller.
\copyright Copyright 2015 Oculus VR, LLC All Rights reserved.
************************************************************************************/

using UnityEngine;

namespace OVRTouchSample
{
    public class TouchController : MonoBehaviour
    {
        [SerializeField]
        private OVRInput.Controller m_handedness;
        [SerializeField]
        private Animator m_animator = null;

        private TrackedController m_trackedController = null;

        private OVRHaptics.OVRHapticsChannel m_hapticsChannel = null;

        public AudioClip m_buttonOneClip;
        public AudioClip m_buttonTwoClip;
        private OVRHapticsClip m_buttonOneHC;
        private OVRHapticsClip m_buttonTwoHC;
        private bool m_lastButtonOne = false;
        private bool m_lastButtonTwo = false;

        private void Start()
        {
            m_trackedController = TrackedController.GetController(m_handedness);

            m_hapticsChannel = m_handedness == OVRInput.Controller.LTouch ? OVRHaptics.LeftChannel : OVRHaptics.RightChannel;
            if (m_buttonOneClip != null) m_buttonOneHC = new OVRHapticsClip(m_buttonOneClip);
            if (m_buttonTwoClip != null) m_buttonTwoHC = new OVRHapticsClip(m_buttonTwoClip);
        }

        private void Update()
        {
            if (m_trackedController != null)
            {
                // Animation
                m_animator.SetFloat("Button 1", m_trackedController.Button1 ? 1.0f : 0.0f);
                m_animator.SetFloat("Button 2", m_trackedController.Button2 ? 1.0f : 0.0f);
                Vector2 joyStick = m_trackedController.Joystick;
                m_animator.SetFloat("Joy X", joyStick.x);
                m_animator.SetFloat("Joy Y", joyStick.y);
                m_animator.SetFloat("Grip", m_trackedController.GripTrigger);
                m_animator.SetFloat("Trigger", m_trackedController.Trigger);

                // Haptics
                if(m_lastButtonOne && m_lastButtonOne != m_trackedController.Button1 && m_buttonOneHC != null)
                {
                    m_hapticsChannel.Preempt(m_buttonOneHC);
                }
                if(m_lastButtonTwo && m_lastButtonTwo != m_trackedController.Button2 && m_buttonTwoHC != null)
                {
                    m_hapticsChannel.Preempt(m_buttonTwoHC);
                }
                m_lastButtonOne = m_trackedController.Button1;
                m_lastButtonTwo = m_trackedController.Button2;
            }
        }
    }
}
