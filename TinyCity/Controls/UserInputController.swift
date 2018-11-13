//
//  UserInputController.swift
//  TinyCity
//
//  Created by Pedro Gomes on 31/10/2018.
//  Copyright © 2018 Pedro Gomes. All rights reserved.
//

import AppKit

class UserInputController: NSResponder {
    // MARK: - Mouse/Touches/Keyboard
    
    private let mouse = MouseController()
    private let keyboard = KeyboardController()
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func mouseDown(with event: NSEvent)    { self.mouse.mouseDown(with: event)     }
    override func mouseDragged(with event: NSEvent) { self.mouse.mouseDragged(with: event)  }
    override func mouseUp(with event: NSEvent)      { self.mouse.mouseUp(with: event)       }

    override func keyDown(with event: NSEvent)      { self.keyboard.keyDown(with: event)    }
}

class MouseController: NSResponder {
    override func mouseDown(with event: NSEvent) {
        
    }
    
    override func mouseDragged(with event: NSEvent) {
        
    }
    
    override func mouseUp(with event: NSEvent) {
        
    }

}

class KeyboardController: NSResponder {
    override func keyDown(with event: NSEvent) {
        print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        
        switch event.keyCode {
        case 0x31: break
        case 53:
            break
        default: break
        }
    }
}
