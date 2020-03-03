using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraDraw : MonoBehaviour
{
    public Material renderMaterial;
    public string ImageName;
    public Vector2Int res;

    private Camera camera;


    private void Start()
    {
        camera = Camera.main;
    }

    protected virtual void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, renderMaterial);
    }


    ////Sort of deprecated now that I use unity recorder.
    //public void RenderToTexture()
    //{

    //    Texture2D tex = new Texture2D(res.x, res.y, TextureFormat.RGBA32, false);

    //    RenderTexture rt = new RenderTexture(res.x, res.y, 32);
    //    camera.targetTexture = rt;

    //    camera.Render();

    //    RenderTexture.active = rt;

    //    tex.ReadPixels(new Rect(0, 0, res.x, res.y), 0, 0);

    //    RenderTexture.active = null;
    //    camera.targetTexture = null;

    //    Destroy(rt);

    //    WriteTexture.WriteImage(tex, ImageName);
    //}
}

