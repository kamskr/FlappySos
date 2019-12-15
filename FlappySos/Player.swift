//
//  Player.swift
//  FlappySos
//
//  Created by Kamil Sikora on 10/12/2019.
//  Copyright © 2019 Kamil Sikora. All rights reserved.
//

import SpriteKit

class Player {
    
    enum Character {
           case bird
       }
    var nextTime: Double?
    var timeExtension: Double = 0.01
    var scene: GameScene!
    var playerAnimation: [SKTexture]!
    var playerNode: SKSpriteNode!
    var animation: SKAction?
    var character: Character!
    var readyToPlay: Bool!
    var gameStarted: Bool!
    var ground: SKShapeNode!
    var sky: SKShapeNode!
    var obsticle: Obsticle!
    var groundBitMask = UInt32(1)
    var obsticleBitMask = UInt32(2)
    var playerBitMask = UInt32(4)
    var score = 0
    var scoreLabel: SKLabelNode!
    
         
    

    init(scene: GameScene){
        self.scene = scene
        self.readyToPlay = false
        self.gameStarted = false
        
        initializePlayer()
    }
    
    private func initializePlayer() {
        
        character = Character.bird
        
        if character == Character.bird {
            playerAnimation = [SKTexture.init(imageNamed: "bird1"), SKTexture.init(imageNamed: "bird2"), SKTexture.init(imageNamed: "bird3"), SKTexture.init(imageNamed: "bird4"), SKTexture.init(imageNamed: "bird1")]
            playerNode = SKSpriteNode(imageNamed: "bird1")
            playerNode.zPosition = 1
            playerNode.position = CGPoint(x: 0.0 , y: 0.0)
            playerNode.physicsBody = SKPhysicsBody(texture: playerNode.texture!, size: playerNode.texture!.size())
            playerNode.physicsBody?.usesPreciseCollisionDetection = true
            playerNode.physicsBody?.isDynamic = false
            playerNode.physicsBody?.restitution = 0
            playerNode.physicsBody?.contactTestBitMask = groundBitMask | obsticleBitMask
            playerNode.physicsBody?.categoryBitMask = playerBitMask
            animation = SKAction.animate(with: playerAnimation, timePerFrame: 0.1)
            playerNode?.run(SKAction.repeatForever(animation!))
            scene.addChild(playerNode)
        }
    }

    func prepareForGame () {


        var splinePointsGround = [CGPoint(x: -500, y: (-scene.frame.size.height / 2) + 30),
                            CGPoint(x: 500, y: (-scene.frame.size.height / 2) + 30)]
        ground = SKShapeNode(splinePoints: &splinePointsGround,
                                         count: splinePointsGround.count)
        ground.lineWidth = 5
        ground.zPosition = 1
        ground.physicsBody = SKPhysicsBody(edgeChainFrom: ground.path!)
        ground.physicsBody?.restitution = 0
        ground.alpha = 0
        ground.physicsBody?.categoryBitMask = groundBitMask
        ground.physicsBody?.collisionBitMask = playerBitMask
        ground.physicsBody?.isDynamic = false
        
        animation = SKAction.animate(with: playerAnimation, timePerFrame: 0.05)
        playerNode.removeAllActions()
        playerNode.texture = playerAnimation[0]
        playerNode.run(SKAction.scale(to: 0.5, duration: 0.6)) {
            self.playerNode?.run(SKAction.move(to: CGPoint(x: -((self.scene.scene!.frame.size.width) / 4), y: 0), duration: 0.2))
            self.readyToPlay = true
        }
      
       
        scoreLabel = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x: 0, y: (scene.scene!.frame.size.height / 2.7))
        scoreLabel.fontSize = 100
        scoreLabel.text = "\(score)"
        scoreLabel.fontColor = SKColor.white
        scene.addChild(scoreLabel)
    }
    
    func startGame() {
        if readyToPlay {
            readyToPlay = false
            obsticle = Obsticle(scene)
            playerNode.physicsBody?.isDynamic = true
            gameStarted = true
        }
    }
    
    func bounce() {
        playerNode.run(SKAction.repeat(animation!, count: 1))
        playerNode.physicsBody?.applyImpulse(CGVector(dx: 0,dy: 100))
        playerNode.run(SKAction.rotate(toAngle: 0.7, duration: 0.1)) {
            self.playerNode.run(SKAction.rotate(toAngle: -1.5, duration: 1.3))
        }
      
    }
    
    func updateScore(){
        score += 1
        scoreLabel.text = "\(score)"
    }
    
    func touchedTexture() {
        gameStarted = false
        playerNode.removeAllActions()
        playerNode.physicsBody?.isDynamic = false
        obsticle.pillar1.physicsBody?.isDynamic = false
        obsticle.pillarUD1.physicsBody?.isDynamic = false
        obsticle.pillar2.physicsBody?.isDynamic = false
        obsticle.pillarUD2.physicsBody?.isDynamic = false
        
        if score > UserDefaults.standard.integer(forKey: "bestScore") {
            UserDefaults.standard.set(score, forKey: "bestScore")
        }
        score = 0
        scene.bestScore.text = "Best Score: \(UserDefaults.standard.integer(forKey: "bestScore"))"

    }
    
    
}
