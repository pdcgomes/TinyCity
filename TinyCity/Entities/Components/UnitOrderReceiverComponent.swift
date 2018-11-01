//
//  UnitOrderReceiverComponent.swift
//  TinyCity
//
//  Created by Pedro Gomes on 31/10/2018.
//  Copyright © 2018 Pedro Gomes. All rights reserved.
//

import GameplayKit

extension GKEntity {
    
    var sprite: GKSKNodeComponent {
        return self.component(ofType: GKSKNodeComponent.self)!
    }
    
}

class UnitOrderReceiverComponent: GKComponent {
    
    func accept(order: UnitOrder) -> Bool {
        
        switch order {
        case let .moveTo(point): return moveTo(point)
        case let .patrolArea(area): return patrolArea(area)
        case let .attackUnit(unit): return attackUnit(unit)
        case let .defendUnit(unit): return defendUnit(unit)
        
        case .stop: return stop()
        case .cancel: return cancel()
            
        }
    }
    
}

private extension UnitOrderReceiverComponent {
    func moveTo(_ point: CGPoint) -> Bool {
        let node = self.entity?.sprite.node
        
        node?.removeAllActions()
        node?.run(SKAction.move(to: point, duration: 1.0))
        
        return true
    }

    func patrolArea(_ area: CGRect) -> Bool {
        return false
    }
    
    func attackUnit(_ unit: Unit) -> Bool {
        return false
    }
    
    func defendUnit(_ unit: Unit) -> Bool {
        return false
    }
    
    func stop() -> Bool {
        return false
    }

    func cancel() -> Bool {
        return false
    }

}
