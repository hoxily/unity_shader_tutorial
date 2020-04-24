using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Chapter04
{
    public class NosePositionAnalyse : MonoBehaviour
    {
        public Camera viewingCamera;

        void Start()
        {
            LogLocalPosition();
            LogWorldPosition();
            LogViewPosition();
        }

        private void LogViewPosition()
        {
            Vector3 pWorld = transform.position;
            Vector3 pViewing = viewingCamera.worldToCameraMatrix.MultiplyPoint3x4(pWorld);
            Log("观察空间", pViewing);
            // 注意worldToCameraMatrix与相机Transform的worldToLocalMatrix的差别。
            //前者是右手坐标系，后者是左手坐标系。在xoy平面发生了镜像。因为相机需要在观察空间里看向-z方向，而保持y依然向上，x依然向右，所以相当于z分量取反
            /**
             * 令 M_negate 为
             * 1  0  0  0
             * 0  1  0  0
             * 0  0 -1  0
             * 0  0  0  0
             * */
            // 则 M_worldToCameraMatrix = M_negate M_worldToLocalMatrix
            Debug.LogFormat("worldToCameraMatrix: {0}", viewingCamera.worldToCameraMatrix);
            Debug.LogFormat("viewingCamera.transform.worldToLocalMatrix: {0}", viewingCamera.transform.worldToLocalMatrix);
        }

        private void LogWorldPosition()
        {
            Vector3 p = transform.parent.localToWorldMatrix.MultiplyPoint3x4(transform.localPosition);
            Log("世界空间", p);
            Debug.LogFormat("Cow.transform.localToWorldMatrix: {0}", transform.parent.localToWorldMatrix);
        }

        private void LogLocalPosition()
        {
            Log("模型空间", transform.localPosition);
        }

        private void Log(string tag, Vector3 position)
        {
            Debug.LogFormat("{0}: ({1},{2},{3})", tag, position.x, position.y, position.z);
        }
    }
}
