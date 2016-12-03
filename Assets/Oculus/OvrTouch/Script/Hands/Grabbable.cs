/********************************************************************************//**
\file      Grabbable.cs
\brief     Component that allows objects to be grabbed by the hand.
\copyright Copyright 2015 Oculus VR, LLC All Rights reserved.
************************************************************************************/

using System;
using UnityEngine;

namespace OVRTouchSample
{
    // Which object had its grabbed state changed, and whether the grab is starting or ending.
    public class Grabbable : MonoBehaviour
    {
        // TFR EDIT
        [Header("Edits to script commented //TFR EDIT")]
        public bool m_IsInWall;
        Transform m_BeforeWallPos;

        [SerializeField]
        private bool m_allowOffhandGrab = true;
        [SerializeField]
        private Collider[] m_grabPoints = null;
        [SerializeField]
        private HandPose m_grabPose = null;

        private bool m_grabbedKinematic = false;
        private Collider m_grabbedCollider = null;
        private Hand m_grabbedHand = null;
        [SerializeField]
        private bool m_PreventKinematic = false;

        public bool resetPositionOnGrabEnd;
        public Vector3 startingPosition;

        public bool AllowOffhandGrab
        {
            get { return m_allowOffhandGrab; }
        }

        public HandPose HandPose
        {
            get { return m_grabPose; }
        }

        public bool IsGrabbed
        {
            get { return m_grabbedHand != null; }
        }

        public Hand GrabbedHand
        {
            get { return m_grabbedHand; }
        }

        public Transform GrabbedTransform
        {
            get { return m_grabbedCollider.transform; }
        }

        public Rigidbody GrabbedRigidbody
        {
            get { return m_grabbedCollider.attachedRigidbody; }
        }

        public Collider[] GrabPoints
        {
            get { return m_grabPoints; }
        }

        public bool PreventKinematic
        {
            get { return m_PreventKinematic; }
        }

        virtual public void GrabBegin(Hand hand, Collider grabPoint)
        {
            m_grabbedHand = hand;
            m_grabbedCollider = grabPoint;
            if (!m_PreventKinematic)
                gameObject.GetComponent<Rigidbody>().isKinematic = true;
        }

        virtual public void GrabEnd(Vector3 linearVelocity, Vector3 angularVelocity)
        {
            Rigidbody rb = gameObject.GetComponent<Rigidbody>();
            rb.isKinematic = m_grabbedKinematic;
            m_grabbedHand = null;
            m_grabbedCollider = null;

            if (resetPositionOnGrabEnd)
            {
                transform.position = startingPosition;
            }

            //TFR Edit
            if (m_IsInWall)
            {
                this.transform.position = m_BeforeWallPos.position;
                this.transform.rotation = m_BeforeWallPos.rotation;
                m_IsInWall = false;
            }
            else
            {
                rb.velocity = linearVelocity;
                rb.angularVelocity = angularVelocity;
            }
        }

        virtual protected void Awake()
        {
            if (m_grabPoints.Length == 0)
            {
                // Get the collider from the grabbable
                Collider collider = this.GetComponent<Collider>();
                if (collider == null)
                {
                    throw new ArgumentException("Grabbable: Grabbables cannot have zero grab points and no collider -- please add a grab point or collider.");
                }

                // Create a default grab point
                m_grabPoints = new Collider[1] { collider };
            }
        }

        private void Start()
        {
            m_grabbedKinematic = GetComponent<Rigidbody>().isKinematic;
            startingPosition = transform.position;
        }

        private void OnDestroy()
        {
            if (m_grabbedHand != null)
            {
                // Notify the hand to release destroyed grabbables
                m_grabbedHand.ForceRelease(this);
            }
        }

        private void SendMsg(string msgName, object msg)
        {
            this.transform.SendMessage(msgName, msg, SendMessageOptions.DontRequireReceiver);
        }

        //TFR Edit
        void OnTriggerEnter(Collider col)
        {
            if (col.CompareTag("Wall"))
            {
                m_IsInWall = true;
                m_BeforeWallPos = this.transform;
            }
        }

        void OnTriggerExit(Collider col)
        {
            if (col.CompareTag("Wall"))
                m_IsInWall = false;
        }
    }
}
