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
        
        let label = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label.text = "Game Over"
        label.position = CGPointMake(self.size.width/2, self.size.height/2 + 50)
        label.verticalAlignmentMode = .Center
        label.horizontalAlignmentMode = .Center
        label.fontColor = SKColor.blackColor()
        label.fontSize = 40
        addChild(label)
        
        let label2 = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label2.text = "Your Score: "
        label2.position = CGPointMake(self.size.width/2, self.size.height/2)
        label2.verticalAlignmentMode = .Center
        label2.horizontalAlignmentMode = .Center
        label2.fontColor = SKColor.blackColor()
        label2.fontSize = 30
        addChild(label2)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let myScene = MainMenuScene(fileNamed: "MainMenuScene")
        myScene!.scaleMode = self.scaleMode
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        self.view?.presentScene(myScene!, transition: reveal)
    }
}