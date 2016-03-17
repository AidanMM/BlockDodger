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
class GameOverScene: SKScene {
    
    let score:CGFloat
    
    //Takes size and score
    init(size: CGSize, score: CGFloat){
        self.score = score
        super.init(size: size)
    }
    
    required init(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        
        backgroundColor = UIColor(colorLiteralRed: 135/255, green: 206/255, blue: 250/255, alpha: 1.0)
        
        //Display Game over
        let label = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label.text = "Game Over"
        label.position = CGPointMake(self.size.width/2, self.size.height/2 + 150)
        label.verticalAlignmentMode = .Center
        label.horizontalAlignmentMode = .Center
        label.fontColor = SKColor.blackColor()
        label.fontSize = 60
        addChild(label)
        
        //And the score you get
        let label2 = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label2.text = "Your Score: \(self.score)"
        label2.position = CGPointMake(self.size.width/2, self.size.height/2)
        label2.verticalAlignmentMode = .Center
        label2.horizontalAlignmentMode = .Center
        label2.fontColor = SKColor.blackColor()
        label2.fontSize = 30
        addChild(label2)
        
        let label3 = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        label3.text = "Tap to return to menu"
        label3.position = CGPointMake(self.size.width/2, self.size.height/2 - 100)
        label3.verticalAlignmentMode = .Center
        label3.horizontalAlignmentMode = .Center
        label3.fontColor = SKColor.blackColor()
        label3.fontSize = 25
        addChild(label3)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //Tap to return to menu
        let myScene = MainMenuScene(fileNamed: "MainMenuScene")
        myScene!.scaleMode = self.scaleMode
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        self.view?.presentScene(myScene!, transition: reveal)
    }
}