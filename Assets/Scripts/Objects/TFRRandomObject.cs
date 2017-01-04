/* Created by Dean Day from Greenlight Games Ltd 17/11/2016
 * In partnership with Forever Humble PDX, for 'The Forgotten Rooms'.
 * Copyright 2016, Greenlight Games, All Rights Reserved.
 */

// This script manages all objects that are randomly spawned in to the game.

using UnityEngine;
using System.Collections;

public class TFRRandomObject : MonoBehaviour
{

    [Header("This script manages any randomly spawned object.")]
    [Tooltip("The Sprite for this object, for the Cuff")]
    public Sprite m_ObjectSprite;
    [Tooltip("The Hologram Gameobject, for the Cuff")]
    public GameObject m_HologramObject;
    [Tooltip("The Scroll Gameobject, if it goes to the Cuff")]
    public GameObject m_ScrollObject;

    // Private parameters

    // Use this for initialization
    void Start()
    {

    }
}
