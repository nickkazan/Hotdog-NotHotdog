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
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration();
        configuration.detectionObjects = ARReferenceObject.referenceObjects(inGroupNamed: "Hotdogs", bundle: Bundle.main)!;

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
            let plane = SCNPlane(width: CGFloat(objectAnchor.referenceObject.extent.x), height: CGFloat(objectAnchor.referenceObject.extent.y))
            plane.cornerRadius = plane.width / 8;
            let spriteKitScene = SKScene(fileNamed: "ProductInfo.sks");
            
            plane.firstMaterial?.diffuse.contents = spriteKitScene;
            plane.firstMaterial?.isDoubleSided = true;
            plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0);
            
            let planeNode = SCNNode(geometry: plane);
            planeNode.position = SCNVector3Make(objectAnchor.referenceObject.center.x, objectAnchor.referenceObject.center.y + 0.20, objectAnchor.referenceObject.center.z)
            
            node.addChildNode(planeNode);
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
