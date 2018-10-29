//
//  SelectableComponent.swift
//  TinyCity
//
//  Created by Pedro Gomes on 29/10/2018.
//  Copyright © 2018 Pedro Gomes. All rights reserved.
//

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

class SelectableComponent: GKComponent {
    
    let nodeComponent: GKSKNodeComponent
    var node: SKNode {
        return self.nodeComponent.node
    }

    private(set) var selected: Bool = false

    required init(node: GKSKNodeComponent) {
        self.nodeComponent = node
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func select() {
        self.selected = true
        self.nodeComponent.node.select()
    }
    
    func deselect() {
        self.selected = false
        self.nodeComponent.node.deselect()
    }
    
}
