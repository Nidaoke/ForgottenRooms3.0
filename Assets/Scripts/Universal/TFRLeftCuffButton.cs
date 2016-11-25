/* Created by Dean Day from Greenlight Games Ltd 23/11/2016
 * In partnership with Forever Humble PDX, for 'The Forgotten Rooms'.
 * Copyright 2016, Greenlight Games, All Rights Reserved.
 */

// This script is for the individual buttons on the left Cuff.
using UnityEngine;
using System.Collections;

public class TFRLeftCuffButton : MonoBehaviour
{
    [Header("This script manages a left bracelet button.")]
    [Tooltip("What position is it from top to bottom? 0-2")]
    public int m_ButtonPosition;
    [Tooltip("Would you like debug notes?")]
    public bool m_DebugMode;

    // Private Parameters
    bool m_WaitingToReset;
    TFRLeftCuffManager m_RightParent;

    void Start()
    {
        m_RightParent = GetComponentInParent<TFRLeftCuffManager>();
    }

    void OnTriggerEnter(Collider col)
    {
        if (col.CompareTag("RightHand") && col.GetComponentInParent<TFRHandScript>().m_IsPointing && !m_WaitingToReset)
        {
            m_RightParent.SwitchScreen(m_ButtonPosition);
            m_WaitingToReset = true;

            if (m_DebugMode)
                Debug.Log("Left Button " + m_ButtonPosition + " was pushed.");
        }
    }

    void OnTriggerExit(Collider col)
    {
        if (col.CompareTag("RightHand") && m_WaitingToReset)
        {
            m_WaitingToReset = false;

            if (m_DebugMode)
                Debug.Log("Left Button " + m_ButtonPosition + " was exited.");
        }
    }
}
