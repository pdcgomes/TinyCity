//
//  UnitOrderDispatcher.swift
//  TinyCity
//
//  Created by Pedro Gomes on 31/10/2018.
//  Copyright © 2018 Pedro Gomes. All rights reserved.
//

import Foundation
import GameplayKit

enum UnitOrder {
    case moveTo(CGPoint)
    
    case stop

    case patrolArea(CGRect)

    case attackUnit(Unit)

    case defendUnit(Unit)

    case cancel
}

class UnitOrderDispatcher {
    
    func dispatch(order: UnitOrder, to units: [Unit]) {
        
        for unit in units {
            if case .soldier(let entity) = unit {
                dispatch(order: order, to: entity)
            }
        }
    }
    
    private func dispatch(order: UnitOrder, to entity: GKEntity) {
        if let receiver = entity.component(ofType: UnitOrderReceiverComponent.self) {
            _ = receiver.accept(order: order)
        }
    }
    
}
