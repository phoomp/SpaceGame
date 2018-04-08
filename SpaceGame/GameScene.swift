//
//  GameScene.swift
//  SpaceGame
//
//  Created by Phoom Punpeng on 6/4/18.
//  Copyright © 2018 Phoom Punpeng. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ScoreLabel = SKLabelNode()
    var playerShip = SKSpriteNode()
    var bullets = SKSpriteNode()
    var bulletSpawnPointX : CGFloat! = nil
    var bulletSpawnPointY : CGFloat! = nil
    var difficultLevel = 99
    var score = 0;

    // array of space rock
    var spaceRocks: [SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(GameScene.moveAllObjects), userInfo: nil, repeats: true)
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
            bullets.zPosition = -100
            bullets.position.x = playerShip.position.x
            bullets.position.y = -480
            bullets.physicsBody = SKPhysicsBody(circleOfRadius: 20)
            bullets.physicsBody?.categoryBitMask = 0
            bullets.physicsBody?.contactTestBitMask = 1
            bullets.physicsBody?.collisionBitMask = 0x0001
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
    
    @objc func gameOver() {
        let menuScene = SKScene(fileNamed: "GameMenu")!
        menuScene.scaleMode = .aspectFill
        view?.presentScene(menuScene, transition: SKTransition.doorsCloseHorizontal(withDuration: TimeInterval(2)))
    }
    
    func createSpaceRock() {
        if arc4random_uniform(100) >= difficultLevel {
            let texture = SKTexture(imageNamed: "spaceRock")
            let rock = SKSpriteNode(texture: texture)
            let randomNumber = CGFloat(arc4random_uniform(640))
            
            rock.position.x = randomNumber - 320
            rock.position.y = 750
            rock.name = "spaceRocks"
            rock.zPosition = -100
            rock.physicsBody = SKPhysicsBody(circleOfRadius: rock.size.height/2)
            rock.physicsBody?.categoryBitMask = 0b0001
            rock.physicsBody?.contactTestBitMask = 1
            rock.physicsBody?.collisionBitMask = 0b0011
            addChild(rock)
        }
    }
    func moveSpaceRock() {
        enumerateChildNodes(withName: "spaceRocks", using: { (rock, stop) in
            rock.position.y -= 1
            rock.zRotation += 0.1
        })
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "spaceRocks" || contact.bodyB.node?.name == "spaceRocks" {
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            if contact.bodyA.node?.name == "playerShip" || contact.bodyB.node?.name == "playerShip" {
                gameOver()
            }
            else if contact.bodyA.node?.name == "bullets" || contact.bodyB.node?.name == "bullets" {
                score += 1;
                print(score)
                ScoreLabel.text = "Score: " + String(score)
            }
        }
    }
}
