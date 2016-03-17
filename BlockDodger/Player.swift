//
//  Player.swift
//  BlockDodger
//
//  Created by Aidan McInerny on 3/8/16.
//  Copyright © 2016 Aidan McInerny. All rights reserved.
//

import Foundation
import SpriteKit

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Block     : UInt32 = 0b1       // 1
    static let Projectile: UInt32 = 0b10      // 2
    static let Player    : UInt32 = 0b11      // 3
    static let AmmoBlock : UInt32 = 0b100     // 4
    static let sizeBlock : UInt32 = 0b101     // 5
    static let scaleBlock: UInt32 = 0b110     // 6
}

class Player : SKSpriteNode, SKPhysicsContactDelegate {
    
    var myScene:SKScene?
    var total:Int = 0
    var previousPanX:CGFloat = 0.0
    var level:CGFloat = 0
    var emptySlot:Int = 0
    var playerScale:CGFloat = 0.5
    var blockScale:CGFloat = 2.0
    var ammo:Int = 3
    var ammoTimer:Int = 0
    
    func initialize(scene:GameScene) {
        myScene = scene
        //Set up initial location
        total = Int(scene.size.height / self.size.width)
        //self.position = CGPointMake(self.size.width / 2, (size.height / 2  % self.size.height) + self.size.height * CGFloat(total / 2) )
        self.setScale(playerScale)
        self.position = CGPointMake(scene.size.width / 2, scene.size.height - self.size.height / 2)
        self.colorBlendFactor = 1.0
        self.color = SKColor.redColor()
        
        let moveAction = SKAction.moveByX(0, y: -200, duration: 2.0)
        runAction(moveAction)
        
        
        //set up physics body
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.size.width / 2.0, height: self.size.width / 2.0))
        self.physicsBody?.dynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Block
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.usesPreciseCollisionDetection = true
        
        scene.physicsWorld.contactDelegate = self
        scene.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
        
        //set up gestures
        let pan = UIPanGestureRecognizer(target: self, action: "panDetected:")
        //pan.minimumNumberOfTouches = 2
        pan.delegate = scene
        scene.view!.addGestureRecognizer(pan)
        
        // set up tap gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: "tapDetected:")
        //tap.numberOfTapsRequired = 1
        //tap.numberOfTouchesRequired = 2
        tap.delegate = scene
        scene.view!.addGestureRecognizer(tap)
        
        emptySlot = Int(arc4random()) % (total - 2)
        
        if emptySlot <= 3 {
            emptySlot = 4
        }
        print(emptySlot)
        generateBlockRow()
    }
    
    //MARK: - Gameplay Functions
    
    func shoot() {
        if ammo > 0 {
            let projectile = SKSpriteNode(imageNamed: "Box")
            projectile.colorBlendFactor = 1.0
        	projectile.color = SKColor.blackColor()
            projectile.position = CGPointMake(self.position.x, self.position.y)
            projectile.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.size.width / 2.0, height: self.size.width / 2.0))
            projectile.physicsBody?.dynamic = true
            projectile.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
            projectile.physicsBody?.contactTestBitMask = PhysicsCategory.Block
            projectile.physicsBody?.collisionBitMask = PhysicsCategory.None
            projectile.physicsBody?.usesPreciseCollisionDetection = true
            projectile.setScale(playerScale)
            
            let moveAction = SKAction.moveByX(0, y: -myScene!.size.height, duration: 2.0)
            let deleteAction = SKAction.removeFromParent()
            let blockAction = SKAction.runBlock({print("Done moving, deleting")})
            projectile.runAction(SKAction.sequence([moveAction,blockAction,deleteAction]))
            myScene!.addChild(projectile)
            ammo--;
        }
    }
    
    func update(dt:Float) {
        
    }
    
    func generateBlockRow() {
        let slotOffset = drand48() > 0.5 ? -1 : 1
        if emptySlot - slotOffset < 3 {
            emptySlot = 3
        } else if emptySlot + slotOffset >= total {
            emptySlot = total - 2
        } else if emptySlot < 5 {
            emptySlot = 5
        } else {
            emptySlot += slotOffset
        }
        print(emptySlot)
        let colorize = SKAction.colorizeWithColor(SKColor(colorLiteralRed: 87/255, green: 59/255, blue: 12/255, alpha: 1.0), colorBlendFactor: 1, duration: (5.0 - Double(level / 500.0)))
        for var i = 0; i <= total; i++ {
            if i != emptySlot && i != emptySlot + 1 && i != emptySlot - 1 {
                let block = SKSpriteNode(imageNamed: "Box")
                block.position = CGPointMake(block.size.width * CGFloat(i) + block.size.width / 2, 0 - block.size.height)
                
                block.color = SKColor(colorLiteralRed: 57/255, green: 39/255, blue: 0/255, alpha: 1.0)
                block.colorBlendFactor = 1.0
                
                block.runAction(colorize)
                
                //Give the blocks physics bodies
                //add collision
                block.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: block.size.width, height: block.size.width)) // 1
                block.physicsBody?.dynamic = true // 2
                block.physicsBody?.categoryBitMask = PhysicsCategory.Block // 3
                block.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile // 4
                block.physicsBody?.collisionBitMask = PhysicsCategory.None // 5
                
                // Create the actions
                let actionMove = SKAction.moveTo(CGPointMake(block.position.x, myScene!.size.height + block.size.height), duration: (5.0 - Double(level / 500.0)) )
                let actionMoveDone = SKAction.runBlock( {
                    SKAction.removeFromParent()
                })
                block.runAction(SKAction.sequence([actionMove, actionMoveDone]))
                
                myScene!.self.addChild(block)
            }
        }
        level++;
        ammoTimer++;
        if(ammoTimer >= 75){
            ammo++
            ammoTimer = 0
        }
        runAction(SKAction.repeatAction(
            SKAction.sequence([
                SKAction.waitForDuration(0.2),
                SKAction.runBlock(generateBlockRow)
                ]), count: 1
            ))
    }
    
    //MARK: - Gestures -
    func panDetected(sender:UIPanGestureRecognizer) {
        if myScene!.view != nil {
        // retrieve pan movement along the x-axis of the view since the gesture began
        let currentPanX = sender.translationInView(myScene!.view!).x
        
        // calculate deltaX since last measurement
        let deltaX = currentPanX - previousPanX
        
        var newLoc = CGPointMake(self.position.x + deltaX * 2.0 , self.position.y)
        if newLoc.x > myScene?.size.height {
            newLoc.x = (myScene?.size.height)!
        } else if newLoc.x < myScene!.size.width - (myScene?.size.height)! {
            newLoc.x = myScene!.size.width - (myScene?.size.height)!
        }
        self.position = newLoc
        
        // if the gesture has completed
        if sender.state == .Ended {
            previousPanX = 0
        } else {
            previousPanX = currentPanX
        }
        }
    }
    
    func tapDetected(sender:UITapGestureRecognizer) {
        // fire bullet
        shoot();
    }
    
    //MARK: - Collision -
    func projectileDidCollideWithBlock(projectile:SKSpriteNode, block:SKSpriteNode) {
        projectile.removeFromParent()
        //block.removeFromParent()
    }
    
    func blockDidCollideWithPlayer(projectile:SKSpriteNode, block:SKSpriteNode) {
        
        let gameOverScene = GameOverScene(size: (myScene?.size)!, score: self.level)
        gameOverScene.scaleMode = (myScene?.scaleMode)!
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        myScene!.view!.presentScene(gameOverScene, transition: reveal)
        removeFromParent()
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask == PhysicsCategory.Block) &&
            (secondBody.categoryBitMask == PhysicsCategory.Projectile)) {
                projectileDidCollideWithBlock(firstBody.node as! SKSpriteNode, block: secondBody.node as! SKSpriteNode)
        }
        else if ((firstBody.categoryBitMask == PhysicsCategory.Block ) &&
            (secondBody.categoryBitMask == PhysicsCategory.Player )) {
                blockDidCollideWithPlayer(firstBody.node as! SKSpriteNode, block: secondBody.node as! SKSpriteNode)
        }
    }

}