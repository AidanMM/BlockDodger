//
//  InstructionsScene.swift
//  BlockDodger
//
//  Created by igmstudent on 3/17/16.
//  Copyright © 2016 Aidan McInerny. All rights reserved.
//

import Foundation
import SpriteKit

//Game Over Screen
//No longer takes params for win or lose, since game doesn't have a "win state" in the traditional sense
class InstructionsScene: SKScene {
    
    /*required init(coder aDecoder: NSCoder){
    fatalError("init(coder:) has not been implemented")
    }*/
    
    override func didMoveToView(view: SKView) {
        
        let label = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label.text = "Instructions"
        label.position = CGPointMake(self.size.width/2, self.size.height/2 + 50)
        label.verticalAlignmentMode = .Center
        label.horizontalAlignmentMode = .Center
        label.fontColor = SKColor.blackColor()
        label.fontSize = 40
        addChild(label)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let myScene = GameScene(fileNamed: "GameScene")
        myScene!.scaleMode = self.scaleMode
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        self.view?.presentScene(myScene!, transition: reveal)
    }
}
