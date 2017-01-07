/* Created by Dean Day from Greenlight Games Ltd 07/01/2017
 * In partnership with Forever Humble PDX, for 'The Forgotten Rooms'.
 * Copyright 2016, Greenlight Games, All Rights Reserved.
 */

// This script manages all the books available for randomisation.
// All books available should be inside this gameobject.
// This gameobject should be a child of a gameobject with TFRBooksParent.

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TFRBooksRandomizer : MonoBehaviour
{
    [Header("This script manages our books.")]
    [Tooltip("Debug only, randomise again?")]
    public bool m_PickBook;

    TFRBooksParent m_BookParent;
    List<GameObject> m_Books;
    int m_ChosenBook;

    void Start()
    {
        m_BookParent = GetComponentInParent<TFRBooksParent>();
        PickABook();
    }

    void Update()
    {
        if (m_PickBook)
        {
            m_PickBook = false;
            PickABook();
        }
    }

    void PickABook()
    {
        // Empty our list
        m_Books = new List<GameObject>();

        // Find our Books.
        foreach (Transform child in transform)
        {
            m_Books.Add(child.gameObject);
        }

        // Lets pick a Book!
        m_ChosenBook = Random.Range(0, m_Books.Count);

        for (int i = 0; i < m_Books.Count; i++)
        {
            if (i != m_ChosenBook)
            {
                m_Books[i].SetActive(false);
            }
            else
            {
                m_Books[i].GetComponent<Renderer>().material = m_BookParent.m_GetMaterial();
            }
        }
    }

}
