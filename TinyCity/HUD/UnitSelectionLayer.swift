//
//  UnitSelectionLayer.swift
//  TinyCity
//
//  Created by Pedro Gomes on 26/10/2018.
//  Copyright © 2018 Pedro Gomes. All rights reserved.
//

import SpriteKit

protocol UnitSelectionLayerListener: class {
    func unitSelectorStarted()
    
    func unitSelector(_ : UnitSelectionLayer, updatedTo region: SKRegion)
    
    func unitSelectorCompleted()
}

class UnitSelectionLayer: SKNode {
    private let template = SKShapeNode(rectOf: CGSize(width: 1, height: 1))
    private var start = CGPoint.zero
    private var active: SKShapeNode?
    
    weak var listener: UnitSelectionLayerListener?

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
        
        self.listener?.unitSelectorStarted()
    }
    
    func drag(to: CGPoint) {
        let box = CGRect.box(p1: self.start, p2: to)
        
        let path = CGPath(rect: box, transform: nil)
        let region = SKRegion(path: path)

        self.active?.path = path
        self.active?.isHidden = false

        self.listener?.unitSelector(self, updatedTo: region)
    }
    
    func stop(at: CGPoint) {
        self.start = .zero
        self.active?.removeFromParent()
        self.active = nil
        
        self.listener?.unitSelectorCompleted()
    }
}
