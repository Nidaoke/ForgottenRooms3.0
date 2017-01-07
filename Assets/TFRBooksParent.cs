/* Created by Dean Day from Greenlight Games Ltd 07/01/2017
 * In partnership with Forever Humble PDX, for 'The Forgotten Rooms'.
 * Copyright 2016, Greenlight Games, All Rights Reserved.
 */

// This script manages all the materials available for Books.
// All books should be inside a child of this gameobject.

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TFRBooksParent : MonoBehaviour
{
    [Header("This script manages the materials for random books.")]
    [Tooltip("The materials for our books.")]
    public List<Material> m_Materials = new List<Material>();

    public Material m_GetMaterial()
    {
        return m_Materials[Random.Range(0, m_Materials.Count)];
    }
}
