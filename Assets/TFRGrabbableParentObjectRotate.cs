using System.Collections;
using System;
using System.Collections.Generic;
using UnityEngine;
namespace OVRTouchSample
{
    public class TFRGrabbableParentObjectRotate: MonoBehaviour
    {

        private Grabbable grabbable;

        public bool rotateX, rotateY, rotateZ;
        public float maxX, maxY, maxZ, minX, minY, minZ;
        public GameObject objectToRotate;

        public Vector3 directionToLook;

        // Use this for initialization
        void Start()
        {
            grabbable = GetComponent<Grabbable>();
        }

        // Update is called once per frame
        void Update()
        {
            if (rotateX)
                directionToLook = new Vector3(objectToRotate.transform.position.x, transform.position.y, transform.position.z);
            else if(rotateY)
                directionToLook = new Vector3(transform.position.x, objectToRotate.transform.position.y, transform.position.z);
            else if(rotateZ)
                directionToLook = new Vector3(transform.position.x, transform.position.y, objectToRotate.transform.position.z);

            objectToRotate.transform.LookAt(directionToLook);
        }
    }
}