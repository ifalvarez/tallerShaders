using UnityEngine;
using System.Collections;
using System.Linq;
using System.Collections.Generic;

public class ColorOnDistance : MonoBehaviour {

	private HashSet<Material> materials;
	public Transform colorer;
	public float radius;

	void Start(){
		materials = new HashSet<Material> ();
		foreach (Renderer r in FindObjectsOfType<Renderer>()) {
			materials.UnionWith (r.materials);
		}
		foreach(Terrain t in FindObjectsOfType<Terrain>()){
			materials.Add(t.materialTemplate);
		}
		materials.RemoveWhere (
			m => !m.shader.name.Contains ("ColorOnDistance")
		);
	}

	void Update () {
		foreach (Material m in materials) {
			m.SetVector ("_ColorerPosition", colorer.position);
			m.SetFloat ("_ColorerRadius", radius);
		}
	}
}
