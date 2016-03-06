//
//  GameScene.swift
//  BlockDodger
//
//  Created by Aidan McInerny on 2/9/16.
//  Copyright (c) 2016 Aidan McInerny. All rights reserved.
//

import Foundation
import AVFoundation
import SpriteKit

class GameScene: SKScene, UIGestureRecognizerDelegate {
    
    let player = SKSpriteNode(imageNamed:"Box");
    var total:Int = 0
    var interval = 4
    var blocksList: [SKSpriteNode] = []
    var win = 0 //Temporary variable to make game over screen
    var lose = 0 //Temporary variable to make game over screen
    var gameOver = false //Determines if game is over or not
    
    var engine = AVAudioEngine();
    var tone = AVTonePlayerUnit();
    
    
    override func didMoveToView(view: SKView) {
        total = Int(self.size.height / player.size.width)
        
        player.position = CGPointMake(player.size.width / 2, (size.height / 2  % player.size.height) + player.size.height * CGFloat(total / 2) )
        
        addChild(player)
        
        // Set up timer to recognize when to spawn next line of blocks
        _ = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "generateBlockRow", userInfo: nil, repeats: true)
        
        //Set up swiping gestures
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Up
        self.view!.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view!.addGestureRecognizer(swipeDown)
        
        // set up tap gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: "tapDetected:")
        //        tap.numberOfTapsRequired = 2
        //        tap.numberOfTouchesRequired = 2
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        let format = AVAudioFormat(standardFormatWithSampleRate: tone.sampleRate, channels: 1);
        engine.attachNode(tone)
        let mixer = engine.mainMixerNode;
        engine.connect(tone, to: mixer, format: format)
        do {
            try engine.start()
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            var playerAction:SKAction
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Down:
                playerAction = SKAction.moveTo(CGPointMake(player.position.x, player.position.y - player.size.height), duration: 0.01)
            case UISwipeGestureRecognizerDirection.Up:
                playerAction = SKAction.moveTo(CGPointMake(player.position.x, player.position.y + player.size.height), duration: 0.01)
            default:
                 playerAction = SKAction.moveTo(CGPointMake(player.position.x, player.position.y), duration: 0.01)
                break
            }
            
            player.runAction(playerAction);
        }
    }
    
    
    func tapDetected(sender:UITapGestureRecognizer) {
        // fire bullet
        let circle = SKShapeNode.init(circleOfRadius: 10)
        circle.fillColor = SKColor.redColor()
        circle.position = CGPointMake(player.position.x, player.position.y + player.size.height/2 + 5)
        let moveAction = SKAction.moveByX(2000, y: 0, duration: 2)
        let deleteAction = SKAction.removeFromParent()
        let blockAction = SKAction.runBlock({print("Done moving, deleting")})
        circle.runAction(SKAction.sequence([moveAction,blockAction,deleteAction]))
        addChild(circle)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered

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
        win++*/
        
    }
    
    func generateBlockRow() {
        let emptySlot = Int(arc4random()) % total
        
        let peak = Int(arc4random()) % total
        
        for var i = 0; i < total; i++ {
            if i != emptySlot {
                let offSet = CGFloat(abs(peak - i)) * 2;
                let double = Double(abs(peak - i));
                playTone(double * 50 + 400);
                let block = SKSpriteNode(imageNamed: "Box")
                block.position = CGPointMake(size.width + block.size.width / 2 * offSet , (size.height / 2  % player.size.height) + player.size.height * CGFloat(i) )
                
                // Create the actions
                let actionMove = SKAction.moveTo(CGPointMake(-block.size.width / 2, block.position.y), duration: 5)
                let actionMoveDone = SKAction.removeFromParent()
                block.runAction(SKAction.sequence([actionMove, actionMoveDone]))
                
                addChild(block)
            }
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool{
            return true
    }
    
    func playTone(freq: Double) {
        engine.mainMixerNode.volume = 1.0
        tone.frequency = freq;
        //tone.amplitude = 1.0;
        tone.preparePlaying()
        tone.play()
        print(tone.playing)
    }
}


class AVTonePlayerUnit: AVAudioPlayerNode {
    let bufferCapacity: AVAudioFrameCount = 512
    let sampleRate: Double = 44_100.0
    
    var frequency: Double = 440.0
    var amplitude: Double = 0.25
    
    private var theta: Double = 0.0
    private var audioFormat: AVAudioFormat!
    
    override init() {
        super.init()
        audioFormat = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)
    }
    
    func prepareBuffer() -> AVAudioPCMBuffer {
        let buffer = AVAudioPCMBuffer(PCMFormat: audioFormat, frameCapacity: bufferCapacity)
        fillBuffer(buffer)
        return buffer
    }
    
    func fillBuffer(buffer: AVAudioPCMBuffer) {
        let data = buffer.floatChannelData[0]
        let numberFrames = buffer.frameCapacity
        var theta = self.theta
        let theta_increment = 2.0 * M_PI * self.frequency / self.sampleRate
        
        for frame in 0..<Int(numberFrames) {
            data[frame] = Float32(sin(theta) * amplitude)
            
            theta += theta_increment
            if theta > 2.0 * M_PI {
                theta -= 2.0 * M_PI
            }
        }
        buffer.frameLength = numberFrames
        self.theta = theta
    }
    
    func scheduleBuffer() {
        let buffer = prepareBuffer()
        self.scheduleBuffer(buffer) {
            if self.playing {
                self.scheduleBuffer()
            }
        }
    }
    
    func preparePlaying() {
        scheduleBuffer()
        scheduleBuffer()
        scheduleBuffer()
        scheduleBuffer()
    }
}