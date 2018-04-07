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
    var difficultLevel = 95

    // array of space rock
    var spaceRocks: [SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(GameScene.moveAllObjects), userInfo: nil, repeats: true)
        playerShip = self.childNode(withName: "playerShip") as! SKSpriteNode
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(GameScene.removeAllObjects), userInfo: nil, repeats: true)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            playerShip.position.x = touchLocation.x
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            let bullets = SKShapeNode(rectOf: CGSize(width: 8, height: 40))
            bullets.strokeColor = SKColor.green
            bullets.fillColor = SKColor.green
            bullets.alpha = 0.4
            bullets.name = "bullets"
            bullets.zPosition = 10
            bullets.position.x = playerShip.position.x
            bullets.position.y = -480
            addChild(bullets)
        }
    }
    
    @objc func moveAllObjects() {
        moveBullets()
        moveSpaceRock()
        createSpaceRock()
    }
    
    @objc func moveBullets() {
        enumerateChildNodes(withName: "bullets", using: { (bullets, stop) in
            bullets.position.y += 30
        })
    }
    
    @objc func removeAllObjects() {
        removeBullets()
    }
    
    @objc func removeBullets() {
        for child in children {
            if child.position.y > 900 {
                child.removeFromParent()
            }
        }
    }
    
    func createSpaceRock() {
        if arc4random_uniform(100) >= difficultLevel {
            let texture = SKTexture(imageNamed: "spaceRock")
            let rock = SKSpriteNode(texture: texture)
            let height = self.view!.frame.height
            let width = self.view!.frame.width
            let randomPosition = CGPoint( x:CGFloat(arc4random_uniform( UInt32( floor( width  ) ) ) ),
                                          y:CGFloat(arc4random_uniform( UInt32( floor( height ) ) ) ))
            rock.position = randomPosition
            rock.name = "spaceRocks"
            rock.zPosition = -100
            addChild(rock)
        }
    }
    
    func moveSpaceRock() {
        enumerateChildNodes(withName: "spaceRocks", using: { (rock, stop) in
            rock.position.y -= 5
            rock.zRotation += 0.1
        })
    }
}
