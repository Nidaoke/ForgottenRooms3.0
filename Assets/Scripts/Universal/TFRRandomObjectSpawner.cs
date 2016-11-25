/* Created by Dean Day from Greenlight Games Ltd 14/11/2016
 * In partnership with Forever Humble PDX, for 'The Forgotten Rooms'.
 * Copyright 2016, Greenlight Games, All Rights Reserved.
 */


// Call this function by using the public function 'SpawnObjects'.

using UnityEngine;
using System.Collections.Generic;

public class TFRRandomObjectSpawner : MonoBehaviour
{
    [Header("This script will randomly select and spawn objects.")]
    [Tooltip("Which objects can we randomly select to spawn?")]
    public List<GameObject> m_RandomObjectsList = new List<GameObject>();
    [Space(10)]
    [Tooltip("How many objects should we pick to spawn?")]
    public int m_RandomObjectsToSelect;
    [Space(10)]
    [Tooltip("The Parent of our Spawn Points, that will be counted later.")]
    public GameObject m_SpawnPointsParent;
    [Space(10)]

    [Tooltip("This is the list of objects that have been chosen, it's populated upon scene Start.")]
    [SerializeField]
    public List<GameObject> m_RandomObjectsSelected = new List<GameObject>();
    [Space(10)]

    [Tooltip("Would you like debug notes?")]
    public bool m_DebugMode;
    [Tooltip("Would you like test spawning the objects?")]
    public bool m_SpawnObjectsDebug;

    // Private parameters
    private List<GameObject> m_ListOfSpawns = new List<GameObject>();

    /* The Start function will select the objects we want to use in the game.
     It will also collect all spawn points in the game. */
    void Start()
    {
        // Randomly select X objects from the list.
        if (m_RandomObjectsToSelect > 0)
        {
            for (int i = 0; i < m_RandomObjectsToSelect; i++)
            {
                // Pick an object at random.
                int a = Random.Range(0, m_RandomObjectsList.Count);
                // Add that Object to our list.
                m_RandomObjectsSelected.Add(m_RandomObjectsList[a]);

                if (m_DebugMode)
                    Debug.Log(m_RandomObjectsList[a] + " was selected at random, object number " + i);

                // Remove the object, so it's not used again.
                m_RandomObjectsList.RemoveAt(a);
            }
        }
        else
        {
            Debug.LogError("You need to define how many objects to define in Random Objects To Select.");
        }

        // Add every child of our Spawn Points parent to the list.
        if (m_SpawnPointsParent != null)
        {
            foreach (Transform child in m_SpawnPointsParent.transform)
                m_ListOfSpawns.Add(child.gameObject);
        }
        else
        {
            Debug.LogError("You need to assign a Parent for the Spawn Locations.");
        }

    }

    // This function will spawn our objects when called.
    public void SpawnObjects()
    {
        if (m_DebugMode)
            Debug.Log("Objects Spawning for " + m_RandomObjectsToSelect + " was started.");

        // for every object we've selected.
        for (int i = 0; i < m_RandomObjectsSelected.Count; i++)
        {
            // Find a Spawn Point.
            Vector3 Spawn = FindObjectSpawn(m_RandomObjectsSelected[i]);
            // If our spawn point is equal to 0,0,0.
            if (Spawn == new Vector3(0, 0, 0))
            {
                // No spawn found, report it.
                Debug.LogError("Unable to find spawn for " + m_RandomObjectsSelected[i]);
            }
            else
            {
                // Spawn it at this spawn point.
                Instantiate(m_RandomObjectsSelected[i], Spawn, Quaternion.identity);

                if (m_DebugMode)
                    Debug.Log("Spawned object " + m_RandomObjectsSelected[i] + " at " + Spawn);
            }
        }
    }

    // This function will return an Object to the right bracelet, removing it from the list when done.
    public GameObject GiveNewObject()
    {
        // If we still have objects to find.
        if (m_RandomObjectsSelected.Count > 0)
        {
            // Send a random object to the bracelet.
            GameObject ObjectChosen = m_RandomObjectsSelected[Random.Range(0, m_RandomObjectsSelected.Count)];
            m_RandomObjectsSelected.Remove(ObjectChosen);
            if (m_DebugMode)
            {
                Debug.Log(ObjectChosen + " was sent to the right Bracelet");
            }

            return ObjectChosen;
        }
        else
        {
            // No object to return.
            if (m_DebugMode)
            {
                Debug.Log("No items available for the right Bracelet.");
            }
            return null;
        }

        return null;
    }

    // This function will find a spawn point for our object.
    private Vector3 FindObjectSpawn(GameObject Object)
    {
        // For every spawn in our list.
        for (int i = 0; i < m_ListOfSpawns.Count; i++)
        {
            // Pick one at random.
            int a = Random.Range(0, m_ListOfSpawns.Count);
            // Get its Component.
            TFRObjectSpawnPoint ObjSpawn = m_ListOfSpawns[a].GetComponent<TFRObjectSpawnPoint>();

            // Look through this spawn points objects.
            for (int o = 0; o < ObjSpawn.m_ObjectsToSpawn.Count; o++)
            {
                // If this spawn allows our object.
                if (ObjSpawn.m_ObjectsToSpawn[o] == Object)
                {
                    // Save this spawn.
                    Vector3 Spawn = ObjSpawn.transform.position;

                    if (m_DebugMode)
                        Debug.Log("Removed Spawn Point " + ObjSpawn.gameObject.name + " with Vector 3 of " + ObjSpawn.transform.position);

                    // Remove this spawn from the list.
                    m_ListOfSpawns.RemoveAt(a);
                    // Return this spawn
                    return Spawn;
                }
            }
        }

        // Otherwise, we've found no spawns - return 0,0,0.
        return new Vector3(0, 0, 0);
    }

    // The Update function is used for Debug notes.
    void Update()
    {
        if (m_DebugMode)
        {
            if (m_SpawnObjectsDebug)
            {
                m_SpawnObjectsDebug = false;
                SpawnObjects();
                Debug.Log("Objects Spawns Tested.");
            }
        }
    }
}


