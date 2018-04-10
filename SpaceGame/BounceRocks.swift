//
//  BounceRocks.swift
//  SpaceGame
//
//  Created by Phoom Punpeng on 9/4/18.
//  Copyright © 2018 Phoom Punpeng. All rights reserved.
//

import Foundation
import SpriteKit



class BounceRocks: SKScene, SKPhysicsContact {
    
    var 
    
    override func didMove(to view: SKView) {
        Timer.scheduledTimer(timeInterval: 0.007, target: self, selector: #selector(GameScene.moveAllObjects), userInfo: nil, repeats: true)
        playerShip = self.childNode(withName: "playerShip") as! SKSpriteNode
        playerShip.physicsBody = SKPhysicsBody(circleOfRadius: playerShip.size.height/2)
        playerShip.physicsBody?.categoryBitMask = 0b0010
        playerShip.physicsBody?.contactTestBitMask = 1
        playerShip.physicsBody?.collisionBitMask = 0b0000
        playerShip.physicsBody?.affectedByGravity = false
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(GameScene.removeAllObjects), userInfo: nil, repeats: true)
        
        self.physicsWorld.contactDelegate = self
        
        ScoreLabel.name = "score"
        ScoreLabel.fontName = "AvenirNext-Bold"
        ScoreLabel.text = "Score: 0"
        ScoreLabel.fontColor = SKColor.white
        ScoreLabel.position = CGPoint(x: 0, y: 600)
        ScoreLabel.fontSize = 50
        ScoreLabel.zPosition = 4
        addChild(ScoreLabel)
    }
}
