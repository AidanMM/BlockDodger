//
//  GameOverScene.swift
//  BlockDodger
//
//  Created by Gregory McClellan on 2/29/16.
//  Copyright © 2016 Aidan McInerny. All rights reserved.
//

import Foundation
import SpriteKit

//Game Over Screen
//No longer takes params for win or lose, since game doesn't have a "win state" in the traditional sense
class GameOverScene: SKScene {
    
    /*required init(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }*/
    
    override func didMoveToView(view: SKView) {
        let label = SKLabelNode(fontNamed: "Arial")
        label.text = "Game Over"
        label.position = CGPointMake(self.size.width/2, self.size.height/2)
        label.verticalAlignmentMode = .Center
        label.horizontalAlignmentMode = .Center
        label.fontColor = SKColor.whiteColor()
        label.fontSize = 20
        addChild(label)
        
        let wait = SKAction.waitForDuration(3.0)
        let block = SKAction.runBlock{
            let myScene = MainMenuScene(fileNamed: "MainMenuScene")
            myScene!.scaleMode = self.scaleMode
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            self.view?.presentScene(myScene!, transition: reveal)
        }
        self.runAction(SKAction.sequence([wait,block]))
    }
}