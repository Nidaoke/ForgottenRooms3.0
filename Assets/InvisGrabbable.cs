/********************************************************************************//**
\file      InvisGrabbable.cs
\brief     Component that allows objects to be grabbed by the hand, but only allows movement in specific ways.
************************************************************************************/

using System;
using UnityEngine;

namespace OVRTouchSample
{
    // Which object had its grabbed state changed, and whether the grab is starting or ending.
    public class InvisGrabbable : MonoBehaviour
    {
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

        public GameObject trueObject;
        public bool lockX, lockY, lockZ;

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
            rb.velocity = linearVelocity;
            rb.angularVelocity = angularVelocity;
            m_grabbedHand = null;
            m_grabbedCollider = null;
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
        }

        private void Update()
        {
            if (IsGrabbed || Input.GetKey(KeyCode.Space) || true) 
            {
                Vector3 targetPostition = new Vector3(this.transform.position.x,
                                        this.transform.position.y,
                                        this.transform.position.z);
                if (lockX)
                {
                    targetPostition = new Vector3(trueObject.transform.position.x,
                                        targetPostition.y,
                                        targetPostition.z);
                }
                if (lockY)
                {
                    targetPostition = new Vector3(targetPostition.x,
                                        trueObject.transform.position.y,
                                        targetPostition.z);
                }
                if (lockZ)
                {
                    targetPostition = new Vector3(targetPostition.x,
                                        targetPostition.y,
                                        trueObject.transform.position.z);
                }

                trueObject.transform.LookAt(targetPostition);
            }
        }

        /*private void OnDestroy()
        {
            if (m_grabbedHand != null)
            {
                // Notify the hand to release destroyed grabbables
                m_grabbedHand.ForceRelease(this);
            }
        }*/

        private void SendMsg(string msgName, object msg)
        {
            this.transform.SendMessage(msgName, msg, SendMessageOptions.DontRequireReceiver);
        }
    }
}
