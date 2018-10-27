//
//  ViewController.swift
//  TinyCity
//
//  Created by Pedro Gomes on 26/10/2018.
//  Copyright © 2018 Pedro Gomes. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {
    
    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let scene = GKScene(fileNamed: "GameScene")  else { return }
        guard let sceneNode = scene.rootNode as? GameScene else { return }
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        
        // Copy gameplay related content over to the scene
        sceneNode.entities = scene.entities
        sceneNode.graphs = scene.graphs
        sceneNode.scaleMode = .aspectFill
        
        // Present the scene
        if let view = self.skView {
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true

            view.presentScene(sceneNode)
            
        }
    }
}
