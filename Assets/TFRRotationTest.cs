using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TFRRotationTest : MonoBehaviour
{

    // Use this for initialization
    void Start()
    {

    }
    

    // Update is called once per frame
    void Update()
    {
        Debug.Log(OVRInput.Get(OVRInput.Axis2D.SecondaryThumbstick));
    }
}
