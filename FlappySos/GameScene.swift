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
    var playButton: SKSpriteNode!
    var changeButton: SKSpriteNode!
    var player: Player!
    var bestScore: SKLabelNode!

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
        
        gameLogo = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        gameLogo.zPosition = 1
        gameLogo.position = CGPoint(x: 0, y: (frame.size.height / 2) - 400)
        gameLogo.fontSize = 100
        gameLogo.text = "Flappy Sos"
        gameLogo.fontColor = SKColor.white
        self.addChild(gameLogo)
        
        playButton = SKSpriteNode(imageNamed: "play")
        playButton.zPosition = 1
        playButton.position = CGPoint(x: -100, y: -200)
        playButton.setScale(0.2)
        
        self.addChild(playButton)
        
        changeButton = SKSpriteNode(imageNamed: "change")
        changeButton.zPosition = 1
        changeButton.position = CGPoint(x: 100, y: -200)
        changeButton.setScale(0.2)
        self.addChild(changeButton)
        
        bestScore = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        bestScore.zPosition = 1
        bestScore.position = CGPoint(x: 0, y: gameLogo.position.y - 70)
        bestScore.fontSize = 40
        bestScore.text = "Best Score: \(UserDefaults.standard.integer(forKey: "bestScore"))"
        bestScore.fontColor = SKColor.white
        self.addChild(bestScore)
        
        player.playerNode?.zPosition = 1
        player.playerNode?.position = CGPoint(x: 0.0 , y: 0.0)
        let animation = SKAction.animate(with: player.playerAnimation, timePerFrame: 0.2)
        player.playerNode?.run(SKAction.repeatForever(animation))
        self.addChild(player.playerNode)
    }
    
    private func startGame() {
        
    }
}
