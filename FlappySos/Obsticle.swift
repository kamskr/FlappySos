//
//  Obsticle.swift
//  FlappySos
//
//  Created by Kamil Sikora on 13/12/2019.
//  Copyright © 2019 Kamil Sikora. All rights reserved.
//

import SpriteKit

class Obsticle {
    var scene: GameScene!
    var pillar: SKSpriteNode!
    static var speed: CGFloat = 1
    
    init(_ scene: GameScene) {
        self.scene = scene
        initializeObsticles()
    }
    
    private func initializeObsticles() {
        
        pillar = SKSpriteNode(imageNamed: "piller")
        pillar.zPosition = 1
        pillar.position = CGPoint(x: 200, y: 0.0)
        pillar.isUserInteractionEnabled = false
        pillar.physicsBody = SKPhysicsBody(texture: pillar.texture!, size: pillar.texture!.size())
        pillar.physicsBody?.usesPreciseCollisionDetection = true
        pillar.physicsBody?.restitution = 0
        pillar.physicsBody?.categoryBitMask = 0b001 << 2
        pillar.physicsBody?.contactTestBitMask = 0b001
        pillar.physicsBody?.isDynamic = true
        pillar.physicsBody?.affectedByGravity = false
        pillar.physicsBody?.allowsRotation = false
        
        scene.addChild(pillar)
    }
    
    func changePosition() {
        if scene.player.gameStarted {
             pillar.position.x -= Obsticle.speed
        }
       
    }
    
}
