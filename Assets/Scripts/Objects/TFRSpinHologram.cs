/* Created by Dean Day from Greenlight Games Ltd 18/11/2016
 * In partnership with Forever Humble PDX, for 'The Forgotten Rooms'.
 * Copyright 2016, Greenlight Games, All Rights Reserved.
 */


// This script will spin a Hologram on the defined Axis.
using UnityEngine;
using System.Collections;

public class TFRSpinHologram : MonoBehaviour
{

    [Header("This script will spin a Hologram object.")]
    [Tooltip("Spin on the X Axis?")]
    public bool m_XAxis;
    [Tooltip("Spin on the y Axis?")]
    public bool m_YAxis;
    [Tooltip("Spin on the Z Axis?")]
    public bool m_ZAxis;
    [Space(10)]
    [Tooltip("How fast should we spin?")]
    public float m_SpinSpeed;

    void Update()
    {
        // Spin on X
        if (m_XAxis)
            transform.Rotate(Vector3.right * m_SpinSpeed * Time.deltaTime);

        // Spin on Y
        if (m_YAxis)
            transform.Rotate(Vector3.up * m_SpinSpeed * Time.deltaTime);

        // Spin on Z
        if (m_ZAxis)
            transform.Rotate(Vector3.forward * m_SpinSpeed * Time.deltaTime);
    }
}
