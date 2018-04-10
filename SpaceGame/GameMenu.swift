//
//  GameMenu.swift
//  SpaceGame
//
//  Created by Phoom Punpeng on 7/4/18.
//  Copyright © 2018 Phoom Punpeng. All rights reserved.
//

import Foundation
import SpriteKit

class GameMenu: SKScene {
    
    var normalMode = SKLabelNode()
    var hardMode = SKLabelNode()
    var bounceRocks = SKLabelNode()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        normalMode = self.childNode(withName: "normalMode") as! SKLabelNode
        hardMode = self.childNode(withName: "hardMode") as! SKLabelNode
        bounceRocks = self.childNode(withName: "bounceRocks") as! SKLabelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let touchLocation = touch.location(in: self)

            if atPoint(touchLocation).name == "normalMode" {
                let gameScene = SKScene(fileNamed: "GameScene")!
                gameScene.scaleMode = .aspectFill
                view?.presentScene(gameScene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(2)))
            }
            else if atPoint(touchLocation).name == "hardMode" {
                let gameScene = SKScene(fileNamed: "HardMode")!
                gameScene.scaleMode = .aspectFill
                view?.presentScene(gameScene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(2)))
            }
            else if atPoint(touchLocation).name == "bounceRocks" {
                print("touch me")
                let gameScene = SKScene(fileNamed: "BouncyRock")!
                gameScene.scaleMode = .aspectFill
                view?.presentScene(gameScene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(2)))
            }
        }
    }
}
