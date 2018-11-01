//
//  UnitSelection.swift
//  TinyCity
//
//  Created by Pedro Gomes on 26/10/2018.
//  Copyright © 2018 Pedro Gomes. All rights reserved.
//

import Foundation

protocol Selectable: Hashable {
    func select();
    func deselect();
}

class UnitSelection<UnitType: Selectable> {
    private(set) var selection = Set<UnitType>()
    
    func select(unit: UnitType) {
        self.selection.insert(unit)
        unit.select()
    }
    
    // Replaces the current selection
    func select(units: [UnitType]) {
        let gone = self.selection.subtracting(units)
        
        self.selection.removeAll()
        self.selection.formUnion(units)
        
        units.forEach { $0.select()   }
        gone.forEach  { $0.deselect() }
    }

    // Extends the current selection
    func extend(units: [UnitType]) {
        
    }
    
    func deselect(unit: UnitType) {
        self.selection.remove(unit)
        unit.deselect()
    }
    
    func reset() {
        self.selection.forEach { $0.deselect() }
        self.selection.removeAll()
    }
}
