//
//  GameScene.swift
//  FlappySos
//
//  Created by Kamil Sikora on 10/12/2019.
//  Copyright © 2019 Kamil Sikora. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
        
        var gameLogo: SKLabelNode!
        var background: SKSpriteNode!
        var playButton: SKSpriteNode!
        var changeButton: SKSpriteNode!
        var player: Player!
        var bestScore: SKLabelNode!
        var character: Character!
        var ground: SKShapeNode!
        var sky: SKShapeNode!
        var obsticle: Obsticle!

        override func didMove(to view: SKView) {
//            creates detection of collision
            self.physicsWorld.contactDelegate = self
            
            background = SKSpriteNode(imageNamed: "bg")
            background.zPosition = 0
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
            playButton.name = "play_button"
            playButton.zPosition = 1
            playButton.position = CGPoint(x: -100, y: -200)
            playButton.setScale(0.2)

            self.addChild(playButton)

            changeButton = SKSpriteNode(imageNamed: "change")
            changeButton.name = "change_button"
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
            player = Player(scene: self)
        }
    
    
        override func update(_ currentTime: TimeInterval) {
            if player.gameStarted{
                obsticle.changePosition()
            }
        }
    
         override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        this fun runs everytime someone touches the screen. It looks what was touched and if the play_button was touched it will start the game
            var counter: Int = 0
            for touch in touches {
                let location = touch.location(in: self)
                let touchedNode = self.nodes(at: location)
                for node in touchedNode {
                    counter += 1
                    if node.name == "play_button" {
                        startGame()
                    }
                    if node.name == "change_button" {
                        changeCharacter()
                    }
                    if player.readyToPlay {
                        player.startGame()
                    }
                    
                    if player.gameStarted {
                        player.bounce()
                    }
                }
            }
            counter = 0
        }
    
//    Triggered when contact occurs
        func didBegin(_ contact: SKPhysicsContact) {
            
            let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
            
            if collision == (0b001 << 2) | 0b001 {
                player.touchedTexture()
            }
            
            
        }
    

        private func startGame() {
            print("start game")
            
            playButton.run(SKAction.scale(to: 0.25, duration: 0.05)){
                self.playButton.run(SKAction.scale(to: 0.2, duration: 0.05))
                self.playButton.run(SKAction.move(by: CGVector(dx: -500, dy: 0), duration: 0.5)){
                    self.playButton.isHidden = true
                }
            }
            
            changeButton.run(SKAction.move(by: CGVector(dx: 500, dy: 0), duration: 0.5)){
                           self.changeButton.isHidden = true
                       }
            
            gameLogo.run(SKAction.move(by: CGVector(dx: 0, dy: 600), duration: 0.5)){
                self.gameLogo.isHidden = true
            }
            
            bestScore.run(SKAction.move(by: CGVector(dx: 0, dy: 600), duration: 0.5)){
                self.bestScore.isHidden = true
            }
            
           
            player.prepareForGame()
            ground = player.ground
            sky = player.sky
            obsticle = Obsticle(self)
            
            self.addChild(ground)
        }
    
        private func changeCharacter() {
            print("to create...")
        }
    
}
