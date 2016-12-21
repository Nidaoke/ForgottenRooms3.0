using System.Collections;
using System;
using System.Collections.Generic;
using UnityEngine;
namespace OVRTouchSample
{
    public class TFRGrabbableParentObjectRotate : MonoBehaviour
    {
        [Header("This script allows roation of doors etc.")]
        [Tooltip("Which Axis can it move on?")]
        public bool rotateX;
        public bool rotateY;
        public bool rotateZ;
        [Space(20)]

        [Tooltip("The Min & Max movement on these Axis?")]
        public float maxX;
        public float maxY;
        public float maxZ;
        [Space(20)]

        public float minX;
        public float minY;
        public float minZ;
        [Space(20)]

        public GameObject objectToRotate;
        public Vector3 directionToLook;
        [Tooltip("Where does the handle respawn to?")]
        public GameObject HandleRespawn;

        // Private parameters
        private Grabbable grabbable;


        // Use this for initialization
        void Start()
        {
            grabbable = GetComponent<Grabbable>();
        }

        // Update is called once per frame
<<<<<<< HEAD
        void Update()
        {
            if (grabbable.IsGrabbed)
            {
                if (rotateX)
                    directionToLook = new Vector3(objectToRotate.transform.position.x, transform.position.y, transform.position.z);
                else if (rotateY)
                    directionToLook = new Vector3(transform.position.x, objectToRotate.transform.position.y, transform.position.z);
                else if (rotateZ)
                    directionToLook = new Vector3(transform.position.x, transform.position.y, objectToRotate.transform.position.z);

                objectToRotate.transform.LookAt(directionToLook);
=======
        void FixedUpdate()
        {
            // Make the object we're moving move to our position.
            if (grabbable.IsGrabbed)
            {
                // If rotate on X axis
                if (rotateX)
                    // Look at based on X.
                    directionToLook = new Vector3(objectToRotate.transform.position.x, transform.position.y, transform.position.z);
                // If rotate on Y axis.
                else if (rotateY)
                    // Look at based on Y.
                    directionToLook = new Vector3(transform.position.x, objectToRotate.transform.position.y, transform.position.z);
                // If rotate on Z axis.
                else if (rotateZ)
                    // Look at based on Z axis.
                    directionToLook = new Vector3(transform.position.x, transform.position.y, objectToRotate.transform.position.z);

                // Update final position.
                objectToRotate.transform.LookAt(directionToLook);
>>>>>>> f8a0c412a1532a117f02191028eee723e19c6419
            }
        }
    }
}