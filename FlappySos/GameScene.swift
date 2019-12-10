//
//  GameScene.swift
//  FlappySos
//
//  Created by Kamil Sikora on 10/12/2019.
//  Copyright © 2019 Kamil Sikora. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameLogo: SKLabelNode!
    var background: SKSpriteNode!
    var player: Player!

    override func didMove(to view: SKView) {
        player = Player()
        initializeMenu()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    private func initializeMenu() {
        background = SKSpriteNode(imageNamed: "bg")
        background.position = CGPoint(x: 0, y: 0)
        self.addChild(background)
        
        gameLogo = SKLabelNode(fontNamed: "HoeflerText-BlackItalic")
        gameLogo.zPosition = 1
        gameLogo.position = CGPoint(x: 0, y: (frame.size.height / 2) - 400)
        gameLogo.fontSize = 100
        gameLogo.text = "Flappy Sos"
        gameLogo.fontColor = SKColor.orange
        self.addChild(gameLogo)
        
        player.playerNode?.zPosition = 1
        player.playerNode?.position = CGPoint(x: 0.0 , y: 0.0)
        let animation = SKAction.animate(with: player.playerAnimation, timePerFrame: 0.2)
        player.playerNode?.run(SKAction.repeatForever(animation))
        self.addChild(player.playerNode)
    }
}
