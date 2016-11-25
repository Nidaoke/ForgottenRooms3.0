/* Created by Dean Day from Greenlight Games Ltd 09/11/2016
 * In partnership with Forever Humble PDX, for 'The Forgotten Rooms'.
 * Copyright 2016, Greenlight Games, All Rights Reserved.
 */

using UnityEngine;
using System.Collections.Generic;
using UnityEngine.SceneManagement;

public class TFRActiveTrigger : MonoBehaviour
{
    [Header("This script does stuff when its object is enabled.")]
    [Tooltip("Should we enable objects when activated?")]
    public bool m_EnableObjects;
    public List<GameObject> m_ObjectsToEnable = new List<GameObject>();
    [Space(10)]

    [Tooltip("Should we disable objects when activated?")]
    public bool m_DisableObjects;
    public List<GameObject> m_ObjectsToDisable = new List<GameObject>();
    [Space(10)]

    [Tooltip("Should we change scene when activated?")]
    public bool m_ChangeScene;
    public int m_SceneValue;
    [Space(10)]

    [Tooltip("Would you like debug notes?")]
    public bool m_DebugMode;

    // Use this for initialization
    void Start()
    {
        // Should we enable objects?
        if (m_EnableObjects)
        {
            for (int i = 0; i < m_ObjectsToEnable.Count; i++)
            {
                m_ObjectsToEnable[i].SetActive(true);
            }

            if (m_DebugMode)
                Debug.Log("Objects Enabled.");
        }

        // Should we disable objects?
        if (m_DisableObjects)
        {
            for (int i = 0; i < m_ObjectsToDisable.Count; i++)
            {
                m_ObjectsToDisable[i].SetActive(false);
            }

            if (m_DebugMode)
                Debug.Log("Objects Disabled.");
        }

        // Should we change scene?
        if (m_ChangeScene)
        {
            if (m_DebugMode)
                Debug.Log("Changing to Scene " + m_SceneValue + ".");

            SceneManager.LoadScene(m_SceneValue);
        }

    }
}
