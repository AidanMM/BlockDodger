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
    
    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor(colorLiteralRed: 135/255, green: 206/255, blue: 250/255, alpha: 1.0)
        player.initialize(self)
        addChild(player)
        
        label.position = CGPointMake(size.width - size.height, 0)
        label.fontSize = 20
        addChild(label)
        
        scoreLabel.position = CGPointMake(10, size.height)
        scoreLabel.text = ("Score: ")
        scoreLabel.fontSize = 20
        addChild(scoreLabel)
        
        let colorize = SKAction.colorizeWithColor(UIColor(colorLiteralRed: 0, green: 25/255, blue: 50/255, alpha: 1.0), colorBlendFactor: 1, duration: 10)
        runAction(colorize)
    }
    
    override func update(currentTime: CFTimeInterval) {
        label.text = "\(player.level)"
        
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool{
            return true
    }
    
    /*func didBeginContact(contact: SKPhysicsContact) {
        player.didBeginContact(contact);
    }*/
    
}