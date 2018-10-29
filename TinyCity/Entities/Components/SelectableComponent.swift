//
//  SelectableComponent.swift
//  TinyCity
//
//  Created by Pedro Gomes on 29/10/2018.
//  Copyright © 2018 Pedro Gomes. All rights reserved.
//

import GameplayKit

class SelectableComponent: GKComponent {
    
    private(set) var selected: Bool = false
    private let nodeComponent: GKSKNodeComponent
    
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
