//
//  EntityFactory.swift
//  TinyCity
//
//  Created by Pedro Gomes on 29/10/2018.
//  Copyright © 2018 Pedro Gomes. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

enum UnitType {
    case soldier
    case tank
    case jeep
}

enum Unit {
    case soldier(entity: GKEntity)
}

class UnitFactory {
    
    static func build(_ type: UnitType) -> Unit {
        if case .soldier = type  {
            return buildSoldier()
        }
        fatalError("Unit Type \(type) not supported yet")
    }
    
    private static func buildSoldier() -> Unit {
        let entity = GKEntity()
        
        let radius = CGFloat(10)
        let node = SKShapeNode(circleOfRadius: radius)
        node.userData = NSMutableDictionary()
        node.name = "dot"
        node.lineWidth = 2.5
        node.fillColor = .red
        node.strokeColor = .green

        let visual = GKSKNodeComponent(node: node)
        let selectable = SelectableComponent(node: visual)
        
        entity.addComponent(visual)
        entity.addComponent(selectable)

        return .soldier(entity: entity)
    }
    
}
