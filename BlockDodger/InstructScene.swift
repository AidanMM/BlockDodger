//
//  InstructScene.swift
//  BlockDodger
//
//  Created by Gregory McClellan on 3/17/16.
//  Copyright © 2016 Aidan McInerny. All rights reserved.
//

import Foundation
import SpriteKit

//Main menu
class InstructScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        backgroundColor = UIColor(colorLiteralRed: 135/255, green: 206/255, blue: 250/255, alpha: 1.0)
        
        let label = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label.text = "Instructions"
        label.position = CGPointMake(self.size.width/2, self.size.height/2 + 300)
        label.verticalAlignmentMode = .Center
        label.horizontalAlignmentMode = .Center
        label.fontColor = SKColor.blackColor()
        label.fontSize = 60
        self.addChild(label)
        
        
        let label2 = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label2.text = "Press and hold and move finger"
        label2.position = CGPointMake(self.size.width/2, self.size.height/2 + 150)
        label2.verticalAlignmentMode = .Center
        label2.horizontalAlignmentMode = .Center
        label2.fontColor = SKColor.blackColor()
        label2.fontSize = 30
        self.addChild(label2)
        
        let label4 = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label4.text = "left and right to move"
        label4.position = CGPointMake(self.size.width/2, self.size.height/2 + 115)
        label4.verticalAlignmentMode = .Center
        label4.horizontalAlignmentMode = .Center
        label4.fontColor = SKColor.blackColor()
        label4.fontSize = 30
        self.addChild(label4)
        
        let label3 = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label3.text = "Let go and tap to shoot and"
        label3.position = CGPointMake(self.size.width/2, self.size.height/2 - 30)
        label3.verticalAlignmentMode = .Center
        label3.horizontalAlignmentMode = .Center
        label3.fontColor = SKColor.blackColor()
        label3.fontSize = 30
        self.addChild(label3)
        
        let label5 = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label5.text = "destroy terrain in front of you"
        label5.position = CGPointMake(self.size.width/2, self.size.height/2 - 65)
        label5.verticalAlignmentMode = .Center
        label5.horizontalAlignmentMode = .Center
        label5.fontColor = SKColor.blackColor()
        label5.fontSize = 30
        self.addChild(label5)
        
        let label6 = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label6.text = "Every 75 points you get"
        label6.position = CGPointMake(self.size.width/2, self.size.height/2 - 210)
        label6.verticalAlignmentMode = .Center
        label6.horizontalAlignmentMode = .Center
        label6.fontColor = SKColor.blackColor()
        label6.fontSize = 30
        self.addChild(label6)
        
        let label7 = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label7.text = "you get another bullet"
        label7.position = CGPointMake(self.size.width/2, self.size.height/2 - 245)
        label7.verticalAlignmentMode = .Center
        label7.horizontalAlignmentMode = .Center
        label7.fontColor = SKColor.blackColor()
        label7.fontSize = 30
        self.addChild(label7)
        
        let label8 = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label8.text = "Tap to continue"
        label8.position = CGPointMake(self.size.width/2, self.size.height/2 - 300)
        label8.verticalAlignmentMode = .Center
        label8.horizontalAlignmentMode = .Center
        label8.fontColor = SKColor.blackColor()
        label8.fontSize = 20
        self.addChild(label8)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let myScene = GameScene(fileNamed: "GameScene")
        myScene!.scaleMode = self.scaleMode
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        self.view?.presentScene(myScene!, transition: reveal)
    }
}

