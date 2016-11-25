/* Created by Dean Day from Greenlight Games Ltd 23/11/2016
 * In partnership with Forever Humble PDX, for 'The Forgotten Rooms'.
 * Copyright 2016, Greenlight Games, All Rights Reserved.
 */

// Left Cuff Manager for the buttons and hologram switching.

using UnityEngine;
using System.Collections.Generic;

[RequireComponent(typeof(AudioSource))]

public class TFRLeftCuffManager : MonoBehaviour
{

    [Header("This script manages the left bracelet Hologram.")]
    [Tooltip("Our Hologram Object")]
    public GameObject m_HologramScreen;
    [Tooltip("Our list of screens, top to bottom.")]
    public List<GameObject> m_Screens = new List<GameObject>();
    [Tooltip("Would you like debug notes?")]
    public bool m_DebugMode;

    // Private Parameters
    GameObject m_CurrentScreen;
    AudioSource m_AudioSource;

    void Start()
    {
        m_AudioSource = GetComponent<AudioSource>();
    }

    // Function used for screen switching.
    public void SwitchScreen(int screen)
    {

        if (m_CurrentScreen != null && m_CurrentScreen == m_Screens[screen])
        {
            // Turn of the screens.
            for (int i = 0; i < m_Screens.Count; i++)
                m_Screens[i].SetActive(false);

            // Turn off the scroll.
            m_HologramScreen.SetActive(false);
            // Reset our saved screen.
            m_CurrentScreen = null;

            // Play our Click.
            m_AudioSource.Play();

            if (m_DebugMode)
                Debug.Log("The scroll was closed.");
        }
        else
        {
            // Go through our screens turning them all off except the one we want.
            for (int i = 0; i < m_Screens.Count; i++)
            {
                if (i != screen)
                {
                    m_Screens[i].SetActive(false);
                }
                else
                {
                    m_Screens[i].SetActive(true);
                }
            }

            // Save our open screen.
            m_CurrentScreen = m_Screens[screen];

            // If the Scroll isn't on, turn it on.
            if (!m_HologramScreen.activeSelf)
                m_HologramScreen.SetActive(true);

            // Play our Click.
            m_AudioSource.Play();

            if (m_DebugMode)
                Debug.Log("The scroll was opened to screen: " + m_Screens[screen].name + ".");
        }
    }
}
