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
}

enum Unit {
    case soldier(entity: GKEntity)
}

class UnitFactory {
    
    static func build(_ type: UnitType) -> Unit {
        switch type {
        case .soldier: return buildSoldier()
        }
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

        entity.addComponent(GKSKNodeComponent(node: node))

        return .soldier(entity: entity)
    }
    
}
