/* Created by Dean Day from Greenlight Games Ltd 14/11/2016
 * In partnership with Forever Humble PDX, for 'The Forgotten Rooms'.
 * Copyright 2016, Greenlight Games, All Rights Reserved.
 */

// Currently there's no reason to edit or call this script directly, it's handled by the Random Object Spawner script.

using UnityEngine;
using System.Collections.Generic;

public class TFRObjectSpawnPoint : MonoBehaviour
{
    [Header("This script states Object Spawn locations.")]
    [Tooltip("Which objects can we spawn here?")]
    public List<GameObject> m_ObjectsToSpawn = new List<GameObject>();
    [Space(10)]

    [Tooltip("Would you like debug notes?")]
    public bool m_DebugMode;

    // Not used.
    void Start()
    {

    }
}
