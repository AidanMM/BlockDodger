//
//  TWControls+NestedTypes.swift
//  BlockDodger
//
//  Created by Gregory McClellan on 3/16/16.
//  Copyright © 2016 Aidan McInerny. All rights reserved.
//


// Not my code
// Got from https://github.com/txaidw/TWControls/
import SpriteKit

public extension TWControl {
    
    // MARK: Nested Types
    public enum ControlEvent {
        
        case TouchDown // on all touch downs
        case TouchUpInside
        case TouchUpOutside
        case TouchCancel
        case TouchDragExit
        case TouchDragOutside
        case TouchDragEnter
        case TouchDragInside
        case ValueChanged // sliders, etc.
        case DisabledTouchDown
    }
    
    internal enum TWControlState {
        case Normal
        case Highlighted
        case Selected
        case Disabled
        func asString() -> String {
            switch self {
            case Normal:
                return "Normal"
            case Highlighted:
                return "Highlighted"
            case Selected:
                return "Selected"
            case Disabled:
                return "Disabled"
            }
        }
    }
    
    internal enum TWControlType {
        case Texture
        case Shape
        case Color
        case Label
    }
    
    internal class TWShapeNode:SKShapeNode {
        weak var control:TWControl?
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            super.touchesBegan(touches, withEvent: event)
            control?.touchesBegan(touches, withEvent: event)
        }
        override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
            super.touchesMoved(touches, withEvent: event)
            control?.touchesMoved(touches, withEvent: event)
        }
        override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
            super.touchesEnded(touches, withEvent: event)
            control?.touchesEnded(touches, withEvent: event)
        }
        override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
            super.touchesCancelled(touches, withEvent: event)
            control?.touchesCancelled(touches, withEvent: event)
        }
    }
    
    internal class TWSpriteNode:SKSpriteNode {
        weak var control:TWControl?
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            super.touchesBegan(touches, withEvent: event)
            control?.touchesBegan(touches, withEvent: event)
        }
        override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
            super.touchesMoved(touches, withEvent: event)
            control?.touchesMoved(touches, withEvent: event)
        }
        override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
            super.touchesEnded(touches, withEvent: event)
            control?.touchesEnded(touches, withEvent: event)
        }
        override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
            super.touchesCancelled(touches, withEvent: event)
            control?.touchesCancelled(touches, withEvent: event)
        }
    }
}


public extension SKShapeNode {
    public convenience init(definition:Definition) {
        self.init()
        self.redefine(definition)
    }
    func redefine(definition:Definition) {
        self.path = definition.path
        self.strokeColor = definition.strokeColor
        self.fillColor = definition.fillColor
        self.lineWidth = definition.lineWidth
        self.glowWidth = definition.glowWidth
        self.fillTexture = definition.fillTexture
    }
    
    func definition() -> Definition {
        var shapeDef = Definition(path: self.path!)
        shapeDef.path = self.path!
        shapeDef.strokeColor = self.strokeColor
        shapeDef.fillColor = self.fillColor
        shapeDef.lineWidth = self.lineWidth
        shapeDef.glowWidth = self.glowWidth
        shapeDef.fillTexture = self.fillTexture
        return shapeDef
    }
    
    // MARK: Shape Definition - Description
    public struct Definition {
        var path: CGPath
        var strokeColor: UIColor = SKColor.whiteColor()
        var fillColor: UIColor = SKColor.clearColor()
        var lineWidth: CGFloat = 1.0
        var glowWidth: CGFloat = 0.0
        var fillTexture: SKTexture? = nil
        
        public init(path:CGPath) {
            self.path = path
        }
        public init(path:CGPath, color:SKColor) {
            self.path = path
            self.fillColor = color
            self.strokeColor = color
        }
        public init(_ node:SKShapeNode) {
            self = node.definition()
        }
        public init?(_ node:SKShapeNode?) {
            if let shape = node { self.init(shape) }
            else { return nil }
        }
    }
}
