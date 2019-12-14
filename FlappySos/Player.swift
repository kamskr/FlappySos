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
            playerNode.physicsBody?.collisionBitMask = 0b001 << 2
            playerNode.physicsBody?.categoryBitMask = 0b001
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
//        ground.alpha = 0
        ground.physicsBody?.categoryBitMask = 0b001 << 2
        ground.physicsBody?.contactTestBitMask = 0b001
        ground.physicsBody?.isDynamic = false
        
        animation = SKAction.animate(with: playerAnimation, timePerFrame: 0.05)
        playerNode.removeAllActions()
        playerNode.texture = playerAnimation[0]
        playerNode.run(SKAction.scale(to: 0.5, duration: 0.6)) {
            self.playerNode?.run(SKAction.move(to: CGPoint(x: -((self.scene.scene!.frame.size.width) / 4), y: 0), duration: 0.2))
            self.readyToPlay = true
        }
    }
    
    func startGame() {
        if readyToPlay {
            readyToPlay = false
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
    
    
    
    func touchedTexture() {
        gameStarted = false
        playerNode.physicsBody?.isDynamic = false
        playerNode.removeAllActions()
    
    }
    
    
}
