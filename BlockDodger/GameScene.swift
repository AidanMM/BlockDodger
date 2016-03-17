//
//  GameScene.swift
//  BlockDodger
//
//  Created by Aidan McInerny on 2/9/16.
//  Copyright (c) 2016 Aidan McInerny. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene: SKScene, UIGestureRecognizerDelegate {
    
    let player = Player(imageNamed:"Box");
    var total:Int = 0
    var scaleFactor = CGFloat(2.0)
    var interval = 2.0
    var blocksList: [SKSpriteNode] = []
    var gameOver = false //Determines if game is over or not
    let label = SKLabelNode(fontNamed: "Arial")
    let scoreLabel = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
    let ammoLabel = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
    
    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor(colorLiteralRed: 135/255, green: 206/255, blue: 250/255, alpha: 1.0)
        player.initialize(self)
        addChild(player)
        
        label.position = CGPointMake(size.width - size.height, 0)
        label.fontSize = 20
        addChild(label)
        
        //Score label shows score
        scoreLabel.position = CGPointMake(self.size.width/2 - 200,self.size.height/2 + 350)
        scoreLabel.verticalAlignmentMode = .Top
        scoreLabel.horizontalAlignmentMode = .Left
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = SKColor.blackColor()
        scoreLabel.zPosition = 100
        addChild(scoreLabel)
        
        //Ammo label shows remaining ammo
        ammoLabel.position = CGPointMake(self.size.width/2 + 180,self.size.height/2 + 350)
        ammoLabel.verticalAlignmentMode = .Top
        ammoLabel.horizontalAlignmentMode = .Right
        ammoLabel.fontSize = 30
        ammoLabel.fontColor = SKColor.blackColor()
        ammoLabel.zPosition = 100
        addChild(ammoLabel)
        
        let colorize = SKAction.colorizeWithColor(UIColor(colorLiteralRed: 0, green: 25/255, blue: 50/255, alpha: 1.0), colorBlendFactor: 1, duration: 10)
        runAction(colorize)
    }
    
    override func update(currentTime: CFTimeInterval) {
        scoreLabel.text = "Score: \(player.level)"
        ammoLabel.text = "Ammo: \(player.ammo)"
        
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool{
            return true
    }
    
    /*func didBeginContact(contact: SKPhysicsContact) {
        player.didBeginContact(contact);
    }*/
    
}