using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class TFRFacebookMockScript : MonoBehaviour
{

    public GameObject m_StartStream;
    public GameObject m_StartedStream;
    public GameObject m_TickBox;

    public Text m_Comments;

    int m_Status;

    float m_Timer = 5;
    float m_Time;

    string m_FirstComment = "Daryl: Wow this looks awesome Tom.";
    string m_SecondComment = "Daryl: Wow this looks awesome Tom.\nRick: I think I see the Razorblade back there!";
    string m_ThirdComment = "Daryl: Wow this looks awesome Tom.\nRick: I think I see the Razorblade back there!\nCarl: I'd never be able to find all those items.";
    string m_ForthComment = "Daryl: Wow this looks awesome Tom.\nRick: I think I see the Razorblade back there!\nCarl: I'd never be able to find all those items.\nGlenn: How much time left?\nMaggy: Damn that's scary.";

    bool m_Count;

    void OnTriggerEnter(Collider col)
    {
        if (col.CompareTag("RightHand"))
        {
            if (m_Status < 2)
            {
                m_Status++;
                UpdateStates();
            }
        }
    }

    void UpdateStates()
    {
        if (m_Status == 1)
        {
            m_TickBox.SetActive(true);
        }

        if (m_Status == 2)
        {
            m_StartStream.SetActive(false);
            m_StartedStream.SetActive(true);
            m_Count = true;
        }
    }

    void Update()
    {
        if (m_Count)
        {
            if (m_Time < m_Timer)
            {
                m_Time += Time.deltaTime;
            }
            else
            {
                if (m_FirstComment != "")
                {
                    m_Comments.text = m_FirstComment;
                    m_FirstComment = "";
                    m_Timer = 4;
                    m_Time = 0;
                }
                else if (m_SecondComment != "")
                {
                    m_Comments.text = m_SecondComment;
                    m_SecondComment = "";
                    m_Timer = 5;
                    m_Time = 0;
                }
                else if (m_ThirdComment != "")
                {
                    m_Comments.text = m_ThirdComment;
                    m_ThirdComment = "";
                    m_Timer = 6;
                    m_Timer = 0;
                }
                else if (m_ForthComment != "")
                {
                    m_Comments.text = m_ForthComment;
                    m_ForthComment = "";
                    m_Timer = 4;
                    m_Time = 0;
                }
                else
                {
                    m_Count = false;
                    Debug.Log("All Comments Posted");
                }
            }
        }
    }
}
