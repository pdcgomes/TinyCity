//
//  UnitSelectionLayer.swift
//  TinyCity
//
//  Created by Pedro Gomes on 26/10/2018.
//  Copyright © 2018 Pedro Gomes. All rights reserved.
//

import SpriteKit

protocol UnitSelectionAreaListener: class {
    func unitSelectionStarted()
    
    func unitSelection(_ : UnitSelectionArea, updatedTo region: SKRegion)
    
    func unitSelectionFinished()
}

class UnitSelectionArea: SKNode {
    private let template = SKShapeNode(rectOf: CGSize(width: 1, height: 1))
    private var start = CGPoint.zero
    private var ready = false
    private var active: SKShapeNode?
    
    weak var listener: UnitSelectionAreaListener?

    func start(at: CGPoint) {
        self.start = at
        
        let node = template.copy() as! SKShapeNode
        node.isHidden = false
        node.lineWidth = 2.5
        node.strokeColor = .green
        node.fillColor = SKColor.darkGray.withAlphaComponent(0.1)
        node.isHidden = true
        
        addChild(node)
        
        self.active = node
        
        self.listener?.unitSelectionStarted()
    }
    
    func drag(to: CGPoint) {
        if self.start == .zero {
            self.start = to
            return
        }
        
        if !self.ready, dist(from: self.start, to: to) >= 5 {
            start(at: self.start)
            self.ready = true
        }
        if !self.ready {
            return
        }
        
        let box = CGRect.box(p1: self.start, p2: to)
        
        let path = CGPath(rect: box, transform: nil)
        let region = SKRegion(path: path)

        self.active?.path = path
        self.active?.isHidden = false

        self.listener?.unitSelection(self, updatedTo: region)
    }
    
    func stop(at: CGPoint) {
        self.ready = false
        self.start = .zero
        self.active?.removeFromParent()
        self.active = nil
        
        self.listener?.unitSelectionFinished()
    }
    
    private func dist(from: CGPoint, to: CGPoint) -> Float {
        let x = abs(to.x - from.x)
        let y = abs(to.y - from.y)
        
        return Float(max(x, y))
    }
}
