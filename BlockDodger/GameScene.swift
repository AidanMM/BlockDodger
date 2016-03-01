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
    var win = 0 //Temporary variable to make game over screen
    var lose = 0 //Temporary variable to make game over screen
    var gameOver = false //Determines if game is over or not
    
    
    override func didMoveToView(view: SKView) {
        total = Int(self.size.height / player.size.width)
        player.position = CGPointMake(player.size.width / 2, (size.height / 2  % player.size.height) + player.size.height * CGFloat(total / 2) )
        
        addChild(player)
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "generateBlockRow", userInfo: nil, repeats: true)
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
        
        //These are the temporary lose and win states
        //When you get the correct ones just replace my random variable with the one you want them hooked up with
        if lose >= 10 && !gameOver {
            gameOver = true
            let gameOverScene = GameOverScene(size: size, won: false)
            gameOverScene.scaleMode = scaleMode
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            view?.presentScene(gameOverScene, transition: reveal)
        }
        if win >= 100 && !gameOver {
            gameOver = true
            let gameOverScene = GameOverScene(size: size, won: false)
            gameOverScene.scaleMode = scaleMode
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            view?.presentScene(gameOverScene, transition: reveal)
        }
        win++
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
