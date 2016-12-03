using System.Collections;
using System;
using System.Collections.Generic;
using UnityEngine;
namespace OVRTouchSample {
    public class GrabbableParentObject : MonoBehaviour {

        private Grabbable grabbable;

        public bool moveX, moveY, moveZ;
        public float maxX, maxY, maxZ, minX, minY, minZ;
        public GameObject objectToMove;

        // Use this for initialization
        void Start() {
            grabbable = GetComponent<Grabbable>();
        }

        // Update is called once per frame
        void Update() {
            objectToMove.transform.localPosition = new Vector3(transform.localPosition.x * Convert.ToInt16(moveX),
                                                          transform.localPosition.y * Convert.ToInt16(moveY),
                                                          transform.localPosition.z * Convert.ToInt16(moveZ));

            if (objectToMove.transform.localPosition.x > maxX)
                objectToMove.transform.localPosition = new Vector3(maxX, objectToMove.transform.localPosition.y, objectToMove.transform.localPosition.z);

            if (objectToMove.transform.localPosition.y > maxY)
                objectToMove.transform.localPosition = new Vector3(objectToMove.transform.localPosition.x, maxY, objectToMove.transform.localPosition.z);

            if (objectToMove.transform.localPosition.z > maxZ)
                objectToMove.transform.localPosition = new Vector3(objectToMove.transform.localPosition.x, objectToMove.transform.localPosition.y, maxZ);

            if (objectToMove.transform.localPosition.x < minX)
                objectToMove.transform.localPosition = new Vector3(minX, objectToMove.transform.localPosition.y, objectToMove.transform.localPosition.z);

            if (objectToMove.transform.localPosition.y < minY)
                objectToMove.transform.localPosition = new Vector3(objectToMove.transform.localPosition.x, minY, objectToMove.transform.localPosition.z);

            if (objectToMove.transform.localPosition.z < minZ)
                objectToMove.transform.localPosition = new Vector3(objectToMove.transform.localPosition.x, objectToMove.transform.localPosition.y, minZ);
        }
    }
}