//
//  GameScene.swift
//  BlockDodger
//
//  Created by Aidan McInerny on 2/9/16.
//  Copyright (c) 2016 Aidan McInerny. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let player = SKSpriteNode(imageNamed:"Box");
    var total:Int = 0
    var interval = 4
    var blocksList: [SKSpriteNode] = []
    
    
    override func didMoveToView(view: SKView) {
        total = Int(self.size.height / player.size.width)
        player.position = CGPointMake(player.size.width / 2, (size.height / 2  % player.size.height) + player.size.height * CGFloat(total / 2) )
        
        addChild(player)
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "generateBlockRow", userInfo: nil, repeats: true);
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            var playerAction:SKAction
            
            if location.x < size.width / 2 {
                playerAction = SKAction.moveTo(CGPointMake(player.position.x, player.position.y + player.size.height), duration: 0.01)
            } else {
                playerAction = SKAction.moveTo(CGPointMake(player.position.x, player.position.y - player.size.height), duration: 0.01)
            }
            
            player.runAction(playerAction);
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func generateBlockRow() {
        let emptySlot = Int(arc4random()) % total
        
        for var i = 0; i < total; i++ {
            if i != emptySlot {
                let block = SKSpriteNode(imageNamed: "Box")
                block.position = CGPointMake(size.width + block.size.width / 2 , (size.height / 2  % player.size.height) + player.size.height * CGFloat(i) )
                
                // Create the actions
                let actionMove = SKAction.moveTo(CGPointMake(-block.size.width / 2, block.position.y), duration: 5)
                let actionMoveDone = SKAction.removeFromParent()
                block.runAction(SKAction.sequence([actionMove, actionMoveDone]))
                
                addChild(block)
            }
        }
    }
}
