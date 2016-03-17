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
        
        backgroundColor = UIColor(colorLiteralRed: 135/255, green: 206/255, blue: 250/255, alpha: 1.0)
        
        //Title label
        let label = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label.text = "Block Dodger"
        label.position = CGPointMake(self.size.width/2, self.size.height/2 + 200)
        label.verticalAlignmentMode = .Center
        label.horizontalAlignmentMode = .Center
        label.fontColor = SKColor.blackColor()
        label.fontSize = 60
        self.addChild(label)
        
        //Start Game label
        let label2 = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label2.text = "Start Game"
        label2.position = CGPointMake(self.size.width/2, self.size.height/2)
        label2.verticalAlignmentMode = .Center
        label2.horizontalAlignmentMode = .Center
        label2.fontColor = SKColor.blackColor()
        label2.fontSize = 40
        self.addChild(label2)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //Go to instructions screen when tapped
        let myScene = InstructScene(fileNamed: "InstructScene")
        myScene!.scaleMode = self.scaleMode
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        self.view?.presentScene(myScene!, transition: reveal)
    }
}
