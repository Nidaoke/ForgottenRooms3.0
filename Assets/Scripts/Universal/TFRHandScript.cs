/* Created by Dean Day from Greenlight Games Ltd 16/11/2016
 * In partnership with Forever Humble PDX, for 'The Forgotten Rooms'.
 * Copyright 2016, Greenlight Games, All Rights Reserved.
 */

/* This script communicates with the Oculus SDK Hand.cs script, so we don't have to edit it directly (Too much).
All edits in the Hand.cs are commented with //TFR Edit */

using UnityEngine;
using System.Collections;

public class TFRHandScript : MonoBehaviour
{

    [Header("This script communicates with Hand.cs.")]
    [Tooltip("Is the player pointing?")]
    public bool m_IsPointing;
    [Tooltip("The current Grabbed Object.")]
    public GameObject m_GrabbedObject;
    [Tooltip("The Right Bracelet.")]
    public TFRRightBracelet m_RightBracelet;
    [Tooltip("Would you like debug notes?")]
    public bool m_DebugMode;

    // Update is called once per frame
    void Update()
    {
        if (m_GrabbedObject != null && OVRInput.Get(OVRInput.RawButton.A))
        {
            // We've tried to 'Collect' an Object, tell the Dock Manager.
            bool SeqObj = false;
            // Is the Object a Seq Object?
            if (m_GrabbedObject.GetComponent<TFRRandomObject>().m_ScrollObject != null)
                SeqObj = true;
            m_RightBracelet.AmIWanted(m_GrabbedObject, SeqObj);

            if (m_DebugMode)
                Debug.Log("Player tried to collect Object: " + m_GrabbedObject.name + ". Seq Object: " + SeqObj);
        }
    }
}
