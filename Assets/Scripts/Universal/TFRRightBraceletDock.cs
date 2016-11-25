/* Created by Dean Day from Greenlight Games Ltd 16/11/2016
 * In partnership with Forever Humble PDX, for 'The Forgotten Rooms'.
 * Copyright 2016, Greenlight Games, All Rights Reserved.
 */

// Hologram object prefabs must include an Andromeda Parent as we're unable to change it direct via code.

using UnityEngine;
using System.Collections;
using UnityEngine.UI;

[RequireComponent(typeof(AudioSource))]
[RequireComponent(typeof(Animator))]

public class TFRRightBraceletDock : MonoBehaviour
{

    [Header("This script manages the right bracelet docks.")]
    public TFRRightBracelet m_RightBraceletParent;
    [Space(10)]
    [Tooltip("Our HologramObject parent")]
    public GameObject m_HologramParent;
    [Space(20)]
    [Header("Variables below are set by scripts, do not edit them.")]
    [Tooltip("Our Hologram Object from the Random Object")]
    public GameObject m_HologramObject;
    [Tooltip("The Sprite for our Object")]
    public Image m_ObjectImage;
    [Space(10)]
    [Tooltip("Would you like debug notes?")]
    public bool m_DebugMode;
    [Tooltip("The GameObject we've been assigned - Do not edit.")]
    [SerializeField]
    public TFRRandomObject m_MyObject;

    // Private parameters
    bool m_ShowingHolo;
    AudioSource m_AudioSource;
    Animator m_Anim;
    bool m_WaitingToReset;


    // Grab out components.
    void Start()
    {
        m_AudioSource = GetComponent<AudioSource>();
        m_Anim = GetComponent<Animator>();
    }

    // This function is called to give us a new object.
    public void NewObject(GameObject Object)
    {
        // Replace our Objects if we've been given an object.
        if (Object != null)
        {
            m_MyObject = Object.GetComponent<TFRRandomObject>();
            m_ObjectImage.sprite = m_MyObject.m_ObjectSprite;

            // Remove current Hologram Object.
            Destroy(m_HologramObject.gameObject);
            // Take the new Hologram Object & Instantiate it.
            m_HologramObject = Instantiate(m_MyObject.m_HologramObject, m_HologramParent.transform.position, Quaternion.identity) as GameObject;
            // Parent the GameObject to the Parent.
            m_HologramObject.transform.parent = m_HologramParent.transform;
            // Reset the Position, Rotation & Scale.

            m_HologramObject.transform.position = m_HologramParent.transform.position;
            m_HologramObject.transform.rotation = new Quaternion(0, 0, 0, 0);
            m_HologramObject.transform.localScale = new Vector3(1, 1, 1);

            if (m_DebugMode)
                Debug.Log("I was given a new object: " + Object);

        }
        else
        {
            // No objects left.
            m_MyObject = null;
            m_ObjectImage.sprite = null; // Need a Default null sprite?
            // Remove the Hologram.
            Destroy(m_HologramObject.gameObject);

            if (m_DebugMode)
                Debug.Log("No objects available for me, " + gameObject.name);
        }
    }

    // This function is used to enable the Hologram
    void TurnOn()
    {
        // Show the Hologram
        m_AudioSource.Play();
        m_Anim.SetBool("In", true);
        m_Anim.SetBool("Out", false);

        m_ShowingHolo = true;
        m_HologramParent.SetActive(true);
        m_ObjectImage.enabled = false;

        // Wait for hand to leave
        m_WaitingToReset = true;

        // Tell our Parent we're alive.
        m_RightBraceletParent.HologramEnabled(this);

        if (m_DebugMode)
            Debug.Log(gameObject.name + " was pushed in.");
    }

    // This function is called by the parent, when another Hologram is enabled.
    public void TurnOff()
    {
        // Hide the Hologram
        m_AudioSource.Play();
        m_Anim.SetBool("In", false);
        m_Anim.SetBool("Out", true);
        m_ShowingHolo = false;
        m_HologramParent.SetActive(false);
        m_ObjectImage.enabled = true;
        m_WaitingToReset = false;

        if (m_DebugMode)
            Debug.Log("Hologram " + gameObject.name + " was disabled by the parent.");
    }

    // This function is used for when the dock is pushed in.
    void OnTriggerEnter(Collider col)
    {
        if (m_MyObject != null && col.CompareTag("LeftHand") && col.GetComponentInParent<TFRHandScript>().m_IsPointing && !m_WaitingToReset)
        {
            // If we have an object and the hand is pointing
            if (m_ShowingHolo)
            {
                TurnOff();
            }
            else
            {
                TurnOn();
            }
        }
    }

    void OnTriggerExit(Collider col)
    {
        if (col.CompareTag("LeftHand") && m_WaitingToReset)
        {
            m_WaitingToReset = false;

            if (m_DebugMode)
                Debug.Log("Hand left the Dock Spot " + gameObject.name);
        }
    }
}
