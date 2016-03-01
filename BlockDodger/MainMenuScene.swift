//
//  MainMenuScene.swift
//  BlockDodger
//
//  Created by Gregory McClellan on 2/29/16.
//  Copyright © 2016 Aidan McInerny. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        //For now it just displays text that says you won or lose, can be changed
        let label = SKLabelNode(fontNamed: "Arial")
        
        label.text = "Start Game"
        label.position = CGPointMake(self.size.width/2, self.size.height/2)
        label.verticalAlignmentMode = .Bottom
        label.horizontalAlignmentMode = .Left
        label.fontColor = SKColor.whiteColor()
        label.fontSize = 40
        addChild(label)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let myScene = GameScene(size: self.size)
        myScene.scaleMode = self.scaleMode
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        self.view?.presentScene(myScene, transition: reveal)
    }
}
