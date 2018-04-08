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
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        normalMode = self.childNode(withName: "normalMode") as! SKLabelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            print("touch me")
        for touch in touches {
            let touchLocation = touch.location(in: self)

            if atPoint(touchLocation).name == "normalMode" {
                let gameScene = SKScene(fileNamed: "GameScene")!
                gameScene.scaleMode = .aspectFill
                view?.presentScene(gameScene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(2)))
            }
        }
    }
}
