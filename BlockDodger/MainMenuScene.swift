//
//  MainMenuScene.swift
//  BlockDodger
//
//  Created by Gregory McClellan on 2/29/16.
//  Copyright © 2016 Aidan McInerny. All rights reserved.
//

import Foundation
import SpriteKit

//Main menu
class MainMenuScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        let label = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label.text = "Block Dodger"
        label.position = CGPointMake(self.size.width/2, self.size.height/2 + 200)
        label.verticalAlignmentMode = .Center
        label.horizontalAlignmentMode = .Center
        label.fontColor = SKColor.blackColor()
        label.fontSize = 60
        self.addChild(label)
        
        
        let label2 = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label2.text = "Start Game"
        label2.position = CGPointMake(self.size.width/2, self.size.height/2)
        label2.verticalAlignmentMode = .Center
        label2.horizontalAlignmentMode = .Center
        label2.fontColor = SKColor.blackColor()
        label2.fontSize = 40
        self.addChild(label2)
        
        /*let startButton = TWButton(normalText: "Start Game", highlightedText: "Let's Go")
        self.addChild(startButton);*/
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let myScene = InstructionsScene(fileNamed: "InstructionsScene")
        myScene!.scaleMode = self.scaleMode
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        self.view?.presentScene(myScene!, transition: reveal)
    }
}
