/* Created by Dean Day from Greenlight Games Ltd 16/11/2016
 * In partnership with Forever Humble PDX, for 'The Forgotten Rooms'.
 * Copyright 2016, Greenlight Games, All Rights Reserved.
 */

// This script manages the right dock spots and is called to get new objects or see if an object is wanted.

using System.Collections.Generic;
using UnityEngine;

public class TFRRightBracelet : MonoBehaviour
{

    [Header("This script manages the right bracelet.")]
    [Tooltip("Our 3 Dock buttons, left to right.")]
    public List<TFRRightBraceletDock> m_BraceletDocks = new List<TFRRightBraceletDock>();
    [Tooltip("Should we start the timer after finding the first object?")]
    public bool m_StartTimer;
    [Tooltip("The Braclet Timer if needed.")]
    public TFRBraceletTimer m_BraceletTimer;
    [Space(10)]

    [Tooltip("Our TFRRandomObjectSpawner.")]
    public TFRRandomObjectSpawner m_RandomObjectSpawner;
    [Space(10)]

    [Tooltip("Would you like debug notes?")]
    public bool m_DebugMode;
    [Tooltip("Pick a Dock Spot to test.")]
    public int m_DummyDockSpot;
    [Tooltip("Test assigning the objects to Dock Spot")]
    public bool m_DummyAssignObjects;


    // Private parameters
    private int m_ObjectsRequested;
    private bool m_TimerStarted;
    private TFRRightBraceletDock m_CurrentHologram;

    // This function will fill the Dock Spots up when object hunting starts.
    public void StartLooking()
    {
        AssignNewObject(1);
        AssignNewObject(2);
        AssignNewObject(3);
    }


    // Called when we need to find a new object
    void AssignNewObject(int BraceletDock)
    {
        GameObject NewObject = m_RandomObjectSpawner.GiveNewObject();
        m_ObjectsRequested++;

        if (m_ObjectsRequested < 4 && !m_TimerStarted && m_StartTimer)
        {
            // m_BraceletTimer.StartTimer();
            m_TimerStarted = true;

            if (m_DebugMode)
                Debug.Log("The Bracelet Timer has been started.");
        }

        // Change the Dock Spot

        if (BraceletDock == 0)
        {
            m_BraceletDocks[0].NewObject(NewObject);
        }

        if (BraceletDock == 1)
        {
            m_BraceletDocks[1].NewObject(NewObject);
        }

        if (BraceletDock == 2)
        {
            m_BraceletDocks[2].NewObject(NewObject);
        }


        if (NewObject != null)
        {
            if (m_DebugMode)
                Debug.Log("Dock Spot " + BraceletDock + " was assigned new object " + NewObject + ".");
        }
        else
        {
            if (m_DebugMode)
                Debug.Log("There are no new objects left to assign for Dock Spot " + BraceletDock + ".");
        }
    }

    // Called by the Docks when a new one is enabled, to keep one alive at a time.
    public void HologramEnabled(TFRRightBraceletDock Hologram)
    {
        if (m_CurrentHologram != null && m_CurrentHologram != Hologram)
        {
            m_CurrentHologram.TurnOff();
            m_CurrentHologram = null;
        }

        m_CurrentHologram = Hologram;
    }

    // Called by the hand when an Object is collected.
    public void AmIWanted(string Object, bool GoToScroll)
    {
        for (int i = 0; i < m_BraceletDocks.Count; i++)
        {
            if (m_BraceletDocks[i].m_ItemName == Object)
            {
                // The Object matches this Dock

                if (m_DebugMode)
                    Debug.Log(Object + " is wanted by " + m_BraceletDocks[i].name);
                // Make the Object dissapear

                // Is it a Seq Object?
                if (GoToScroll)
                {
                    // Make the Object appear in the Scroll

                    if (m_DebugMode)
                        Debug.Log(Object + " was sent to the scroll as a Seq Item.");
                }

                // Remove the Object from the Right Scroll and get a new one.
                AssignNewObject(i);
                break;
            }
            else
            {
                if (m_DebugMode)
                    Debug.Log("The object " + Object + " is not wanted by Bracelet spot " + m_BraceletDocks[i] + " .");
            }
        }
    }

    // The Update function is used for Debug notes.
    void Update()
    {
        if (m_DebugMode)
        {
            if (m_DummyAssignObjects)
            {
                m_DummyAssignObjects = false;
                if (m_DummyDockSpot < 3 && m_DummyDockSpot > -1)
                {
                    AssignNewObject(m_DummyDockSpot);
                    Debug.Log("Objects placement to Dock Spot " + m_DummyDockSpot + " tested.");
                }
                else
                {
                    Debug.LogError("Pick a Dock Spot between 0 & 2!");
                }
            }
        }
    }

}
