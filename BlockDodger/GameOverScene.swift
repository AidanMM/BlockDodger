//
//  GameOverScene.swift
//  BlockDodger
//
//  Created by Gregory McClellan on 2/29/16.
//  Copyright © 2016 Aidan McInerny. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    let won:Bool
    
    init(size: CGSize, won: Bool) {
        self.won = won
        super.init(size: size)
    }
    
    required init(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        //For now it just displays text that says you won or lose, can be changed
        let label = SKLabelNode(fontNamed: "Arial")
        if (won) {
            label.text = "You Win"
        } else {
            label.text = "You Lose"
        }
        
        label.position = CGPointMake(self.size.width/2, self.size.height/2)
        label.verticalAlignmentMode = .Bottom
        label.horizontalAlignmentMode = .Left
        label.fontColor = SKColor.whiteColor()
        label.fontSize = 20
        addChild(label)
        
        let wait = SKAction.waitForDuration(3.0)
        let block = SKAction.runBlock{
            let myScene = GameScene(size: self.size)
            myScene.scaleMode = self.scaleMode
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            self.view?.presentScene(myScene, transition: reveal)
        }
        self.runAction(SKAction.sequence([wait,block]))
    }
}