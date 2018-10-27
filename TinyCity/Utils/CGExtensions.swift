//
//  CGExtensions.swift
//  TinyCity
//
//  Created by Pedro Gomes on 26/10/2018.
//  Copyright © 2018 Pedro Gomes. All rights reserved.
//

import GameplayKit
import Foundation
import SpriteKit

extension SKColor {
    static func random() -> SKColor {
        let random = GKRandomSource()
        
        return SKColor(calibratedRed: CGFloat(CGFloat(random.nextUniform())),
                       green: CGFloat(random.nextUniform()),
                       blue: CGFloat(random.nextUniform()), alpha: 1.0)
        
    }
}

extension CGPoint {
    static func random(constraintedTo bounds: CGRect) -> CGPoint {
        
        let random = GKRandomSource()
        
        let xFactor = CGFloat(random.nextUniform())
        let yFactor = CGFloat(random.nextUniform())
        
        let x = bounds.minX + xFactor * bounds.width
        let y = bounds.minY + yFactor * bounds.height
        
        return CGPoint(x:x.rounded() , y: y.rounded())
    }
}

extension CGRect {
    static func box(p1: CGPoint, p2: CGPoint) -> CGRect {
        
        let minX = min(p1.x, p2.x)
        let maxX = max(p1.x, p2.x)
        
        let minY = min(p1.y, p2.y)
        let maxY = max(p1.y, p2.y)
        
        let width = maxX - minX
        let height = maxY - minY
        
        // a------b
        // |      |
        // |      |
        // d------c
        
        return CGRect(x: minX, y: minY, width: width, height: height)
        
    }
    
    var a: CGPoint { return CGPoint(x: self.minX, y: self.minY) }
    var b: CGPoint { return CGPoint(x: self.maxX, y: self.minY) }
    var c: CGPoint { return CGPoint(x: self.maxX, y: self.maxY) }
    var d: CGPoint { return CGPoint(x: self.minX, y: self.maxY) }
}


