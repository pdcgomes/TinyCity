//
//  GameScene.swift
//  TinyCity
//
//  Created by Pedro Gomes on 26/10/2018.
//  Copyright © 2018 Pedro Gomes. All rights reserved.
//

import SpriteKit
import GameplayKit

extension SKNode: Selectable {
    @objc func select() {}
    @objc func deselect() {}
}

extension SKShapeNode {
    @objc override func select() {
        if let info = self.userData, info["fillColor"] == nil  {
            info["fillColor"] = self.fillColor
        }
        self.fillColor = .green
    }
    
    @objc override func deselect() {
        if let info = self.userData, let fillColor = info["fillColor"] as? SKColor {
            self.fillColor = fillColor
        }
    }
}

extension GameScene: UnitSelectionLayerListener {

    func unitSelectorStarted() {
        self.unitSelection.reset()
    }
    
    func unitSelector(_: UnitSelectionLayer, updatedTo region: SKRegion) {
        var selection = [SKNode]()
        
        self.enumerateChildNodes(withName: "dot") { (node, _) in
            if     region.contains(node.frame.a)
                || region.contains(node.frame.b)
                || region.contains(node.frame.c)
                || region.contains(node.frame.d) {
                selection.append(node)
            }
        }

        self.unitSelection.select(units: selection)
    }
    
    func unitSelectorCompleted() {
    }
}

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    let unitSelection = UnitSelection<SKNode>()
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var hud: UnitSelectionLayer?
    
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
        
        setupDots()
        setupHud()
    }

    // MARK: - Setup
    
    func setupDots() {
        var dots = [SKNode]()
        let radius = CGFloat(10)
        for _ in 1...10 {
            let dot = SKShapeNode(circleOfRadius: radius)
            dot.userData = NSMutableDictionary()
            dot.name = "dot"
            dot.lineWidth = 2.5
            dot.fillColor = SKColor.red
            dot.strokeColor = SKColor.green
            dot.position = CGPoint.random(constraintedTo: self.frame.insetBy(dx: radius, dy: radius))
            addChild(dot)
            
            dots.append(dot)
        }
        
        for dot in dots {
            let moveToRandomPos = SKAction.run {
                let move = SKAction.move(to: CGPoint.random(constraintedTo: self.frame),
                                         duration: 2.0)
                dot.run(move)
            }
            
            let moveSequence = SKAction.sequence([
                SKAction.wait(forDuration: 0.5, withRange: 2),
                SKAction.fadeAlpha(to: 1.0, duration: 0.2),
                moveToRandomPos,
                SKAction.wait(forDuration: 2, withRange: 0.2),
                SKAction.fadeAlpha(to: 0.5, duration: 0.3)])
            
            dot.run(SKAction.repeatForever(moveSequence))
        }
    }
    
    func setupHud() {
        let hud = UnitSelectionLayer()
        
        addChild(hud)

        hud.listener = self
        
        self.hud = hud
    }
    
    // MARK: - Mouse/Touches/Keyboard
    
    func touchDown(atPoint pos : CGPoint)   {}
    func touchMoved(toPoint pos : CGPoint)  {}
    func touchUp(atPoint pos : CGPoint)     {}
    
    override func mouseDown(with event: NSEvent) {
        let point = event.location(in: self)

        self.touchDown(atPoint: point)
        self.hud?.start(at: point)
    }
    
    override func mouseDragged(with event: NSEvent) {
        let point = event.location(in: self)

        self.touchMoved(toPoint: event.location(in: self))
        
        self.hud?.drag(to: point)
    }
    
    override func mouseUp(with event: NSEvent) {
        let point = event.location(in: self)

        self.touchUp(atPoint: point)
        self.hud?.stop(at: point)
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x31: break
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }

    // MARK: - Update

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
