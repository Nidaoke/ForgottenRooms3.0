/* Created by Dean Day from Greenlight Games Ltd 09/11/2016
 * In partnership with Forever Humble PDX, for 'The Forgotten Rooms'.
 * Copyright 2016, Greenlight Games, All Rights Reserved.
 */

using UnityEngine;
using System.Collections;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class TFRLoadingScreen : MonoBehaviour
{

    [Header("This script will load the next scene.")]
    [Tooltip("How much fake time should we make our loading screen take?")]
    public float m_FakeLoadingTime;
    [Space(10)]

    [Tooltip("Our Loading text for progress.")]
    public Text m_LoadingText;
    [Tooltip("Our Loading bar for progress.")]
    public Slider m_LoadingBar;

    [Tooltip("Would you like debug notes?")]
    public bool m_DebugMode;

    // Private variables
    bool m_LoadingStarted;
    int m_SceneValue;
    float m_Timer = 0;
    float m_Progress = 0;
    float m_SlowProgress;
    AsyncOperation m_LoadingScene;

    // Used to work out which scene to load.
    void Start()
    {
        // Check for stored PlayerPrefs
        if (PlayerPrefs.HasKey("LoadScene"))
        {
            m_SceneValue = PlayerPrefs.GetInt("LoadScene");
            PlayerPrefs.DeleteKey("LoadScene");

            if (m_DebugMode)
                Debug.Log("PlayerPrefs value found for Scene " + m_SceneValue + ".");
        }
        else
        {
            // Otherwise default to Main Menu
            m_SceneValue = 2;
            if (m_DebugMode)
                Debug.Log("No PlayerPrefs value found, loading Main Menu.");
        }

        // Start loading our level.
        StartCoroutine(LoadScene());
    }

    // Used for checking progress and firing final change scene coroutine.
    void Update()
    {
        // Update our timer.
        if (m_LoadingStarted)
        {
            m_Progress = (m_LoadingScene.progress * 100);
            if (m_DebugMode)
                Debug.Log("Progress: " + m_Progress + "% - Slow Progress " + m_SlowProgress + ".");

            m_Timer += Time.deltaTime;
            m_LoadingText.text = m_SlowProgress + "%";
            m_LoadingBar.value = m_SlowProgress;
        }

        // Has loading finished?
        if (m_LoadingStarted && m_SlowProgress >= 90f)
        {
            // If we're over our minimum fake time, change scene.
            if (m_Timer > m_FakeLoadingTime)
            {
                // Tell everything we're at 100%.
                m_Progress = 100;
                m_SlowProgress = 100;
                m_LoadingText.text = m_SlowProgress + "%";
                m_LoadingBar.value = m_SlowProgress;
                m_LoadingStarted = false;
                StartCoroutine(ChangeScene());
            }
            else
            {
                if (m_DebugMode)
                    Debug.Log("Scene loaded, waiting to reach fake timer.");
            }
        }
    }

    // Used for starting the Async loading progress.
    IEnumerator LoadScene()
    {
        // Start loading our scene in the background
        m_LoadingScene = SceneManager.LoadSceneAsync(m_SceneValue);
        // Stop our Scene from auto starting
        m_LoadingScene.allowSceneActivation = false;
        // Let our Timer start
        m_LoadingStarted = true;

        if (m_DebugMode)
            Debug.Log("Loading Scene " + m_SceneValue + " Async.");
        // Loading has started, Update loop will change scene when done.

        // Start fake progress.
        StartCoroutine(SlowDownProgress());
        yield return null;
    }

    // Used to fake the progress so we dont get instant loads.
    IEnumerator SlowDownProgress()
    {
        while (m_SlowProgress < 90)
        {
            // Fake the progress
            if (m_SlowProgress > 85 && m_Progress > 89)
            {
                // Cut to 90 instead of making the player wait.
                m_SlowProgress = 90;
            }
            else
            {
                m_SlowProgress = (int)Random.Range(m_SlowProgress, m_Progress);
                yield return new WaitForSeconds(1);
            }
        }
    }

    // Used for changing the scene upon completion.
    IEnumerator ChangeScene()
    {
        yield return new WaitForSeconds(1);
        m_LoadingScene.allowSceneActivation = true;
    }

}
