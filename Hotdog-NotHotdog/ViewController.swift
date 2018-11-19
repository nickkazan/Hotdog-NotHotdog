//
//  ViewController.swift
//  Hotdog-NotHotdog
//
//  Created by Nick Kazan on 2018-11-18.
//  Copyright © 2018 Nick Kazan. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        let scene = SCNScene(named: "art.scnassets/GameScene.scn")!;
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration that looks for objects matching those in "HotdogObjects"
        let configuration = ARWorldTrackingConfiguration();
        configuration.detectionObjects = ARReferenceObject.referenceObjects(inGroupNamed: "HotdogObjects", bundle: Bundle.main)!;

        // Run the view's session
        sceneView.session.run(configuration);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode();
        
        if let objectAnchor = anchor as? ARObjectAnchor {
            print("-------Hotdog Detected-------")
            
            //Create the text to display the Confirmation and set its position
            let text = SCNText(string: "Hotdog", extrusionDepth: 1);
            text.font = UIFont.systemFont(ofSize: 8);
            text.firstMaterial?.diffuse.contents = UIColor.green;
            
            let textNode = SCNNode(geometry: text)
            //Current ARObject was scanned poorly, so I manually adjusted the center but 0.07 and 0.05. Eventually will be fixed so center is accurate
            textNode.position = SCNVector3Make(objectAnchor.referenceObject.center.x - 0.07, objectAnchor.referenceObject.center.y + 0.05, objectAnchor.referenceObject.center.z);
            textNode.scale = SCNVector3Make(0.005, 0.005, 0.005)
            node.addChildNode(textNode);
        }
        return node;
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
