//
//  BouncyRock.swift
//  SpaceGame
//
//  Created by Phoom Punpeng on 10/4/18.
//  Copyright © 2018 Phoom Punpeng. All rights reserved.
//

import SpriteKit
import GameplayKit

class BouncyRock: SKScene, SKPhysicsContactDelegate {
    var playerShip = SKSpriteNode()
    var score = 0;
    var gameOverAlready = 0
    
    override func didMove(to view: SKView) {
        Timer.scheduledTimer(timeInterval: 0.00000001, target: self, selector: #selector(BouncyRock.checkRock), userInfo: nil, repeats: true)
        playerShip = self.childNode(withName: "playerShip") as! SKSpriteNode
        playerShip.physicsBody = SKPhysicsBody(circleOfRadius: playerShip.size.height/2)
        playerShip.physicsBody?.affectedByGravity = false
        addChild(playerShip)
        createSpaceRock()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            playerShip.position.x = touchLocation.x
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            playerShip.position.x = touchLocation.x
        }
    }
    
    @objc func checkRock() {
        for child in children {
            if child.position.y <= -670 && gameOverAlready == 0 {
            gameOver()
            gameOverAlready = 1
            }
        }
    }
    
    @objc func moveSpaceRocks() {
        //move the SpaceRocks.name = SpaceRocks
    }

    func gameOver() {
        let menuScene = SKScene(fileNamed: "GameMenu")!
        menuScene.scaleMode = .aspectFill
        view?.presentScene(menuScene, transition: SKTransition.doorsCloseHorizontal(withDuration: TimeInterval(2)))
    }
    
    func createSpaceRock() {
        let texture = SKTexture(imageNamed: "spaceRock")
        let rock = SKSpriteNode(texture: texture)
        let randomNumber = 320
        
        rock.position.x = CGFloat(randomNumber - 320)
        rock.position.y = 750
        rock.name = "spaceRocks"
        rock.zPosition = -100
        rock.physicsBody = SKPhysicsBody(circleOfRadius: rock.size.height/2)
        rock.physicsBody?.affectedByGravity = true
        addChild(rock)
    }
    

}
