//
//  GameScene.swift
//  SpaceGame
//
//  Created by Phoom Punpeng on 6/4/18.
//  Copyright © 2018 Phoom Punpeng. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var playerShip = SKSpriteNode()
    var bullets = SKSpriteNode()
    var bulletSpawnPointX : CGFloat! = nil
    var bulletSpawnPointY : CGFloat! = nil
    
    override func didMove(to view: SKView) {
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GameScene.moveBullets), userInfo: nil, repeats: true)
        playerShip = self.childNode(withName: "playerShip") as! SKSpriteNode
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            playerShip.position.x = touchLocation.x
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            let bullets = SKShapeNode(rectOf: CGSize(width: 3, height: 40))
            bullets.strokeColor = SKColor.white
            bullets.fillColor = SKColor.white
            bullets.alpha = 0.4
            bullets.name = "bullets"
            bullets.zPosition = 10
            bullets.position.x = playerShip.position.x
            bullets.position.y = -480
            addChild(bullets)
        }
    }
    
    @objc func moveBullets() {
        enumerateChildNodes(withName: "bullets", using: { (bullets, stop) in
            bullets.position.y += 30
        })
    }
}
