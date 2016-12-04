/* Created by Jonathan Cunningham from Skinny Jean Death Studios 03/12/2016
 * In partnership with Forever Humble PDX, for 'The Forgotten Rooms'.
 * Copyright 2016, Skinny Jean Death Studios, All Rights Reserved.
 */

// This script sits on the invisible object, that allows the player to move objects such as desk draws.

using System.Collections;
using System;
using System.Collections.Generic;
using UnityEngine;

namespace OVRTouchSample
{
    public class TFRGrabbableParentObjectMove : MonoBehaviour
    {

        [Header("This script allows movement of draws etc.")]

        [Tooltip("Which Axis can it move on?")]
        public bool moveX, moveY, moveZ;
        [Space("20")]
        [Tooltip("The Min & Max movement on these Axis?")]
        public float maxX, maxY, maxZ, minX, minY, minZ;
        [Space("20")]
        [Tooltip("The gameobject we're moving?")]
        public GameObject objectToMove;

        // Private paremeters
        private Grabbable grabbable;

        void Start()
        {
            // Get our Grabbable.
            grabbable = GetComponent<Grabbable>();
        }

        void FixedUpdate()
        {
            // Make the object we're moving move to our position.
            objectToMove.transform.localPosition = new Vector3(transform.localPosition.x * Convert.ToInt16(moveX),
                                                          transform.localPosition.y * Convert.ToInt16(moveY),
                                                          transform.localPosition.z * Convert.ToInt16(moveZ));

            // If we're over our max X, move it back to the max X position.
            if (objectToMove.transform.localPosition.x > maxX)
                objectToMove.transform.localPosition = new Vector3(maxX, objectToMove.transform.localPosition.y, objectToMove.transform.localPosition.z);

            // If we're over our max Y, move it back to the max y position.
            if (objectToMove.transform.localPosition.y > maxY)
                objectToMove.transform.localPosition = new Vector3(objectToMove.transform.localPosition.x, maxY, objectToMove.transform.localPosition.z);

            // If we're over our max Z, move it back to the max Z position.
            if (objectToMove.transform.localPosition.z > maxZ)
                objectToMove.transform.localPosition = new Vector3(objectToMove.transform.localPosition.x, objectToMove.transform.localPosition.y, maxZ);

            // If we're under our min X, move it back to the min X position.
            if (objectToMove.transform.localPosition.x < minX)
                objectToMove.transform.localPosition = new Vector3(minX, objectToMove.transform.localPosition.y, objectToMove.transform.localPosition.z);

            // If we're under our min Y, move it back to the min Y position.
            if (objectToMove.transform.localPosition.y < minY)
                objectToMove.transform.localPosition = new Vector3(objectToMove.transform.localPosition.x, minY, objectToMove.transform.localPosition.z);

            // If we're under our min Y, move it back to the min Y position.
            if (objectToMove.transform.localPosition.z < minZ)
                objectToMove.transform.localPosition = new Vector3(objectToMove.transform.localPosition.x, objectToMove.transform.localPosition.y, minZ);
        }
    }
}