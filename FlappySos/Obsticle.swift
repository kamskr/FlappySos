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
    var pillar1: SKSpriteNode!
    var pillarUD1: SKSpriteNode!
    var pillar2: SKSpriteNode!
    var pillarUD2: SKSpriteNode!
    var pillar3: SKSpriteNode!
    var pillarUD3: SKSpriteNode!
    
    var y: CGFloat = 750
   
    var obsticleBitMask = UInt32(2)
    var playerBitMask = UInt32(4)
    static var speed: CGFloat = 2
    var jump: CGFloat!
    var border: CGFloat = -500
    init(_ scene: GameScene) {
        self.scene = scene
        initializeObsticles()
    }
    
    private func initializeObsticles() {
        let ran1 = CGFloat.random(in: -300...300)
        let ran2 = CGFloat.random(in: -300...300)
        
        pillar1 = generatePillar(image: "piller")
        pillarUD1 = generatePillar(image: "pillerUD")
        
        pillar2 = generatePillar(image: "piller")
        pillarUD2 = generatePillar(image: "pillerUD")
        
        pillar1.position = CGPoint(x: scene.scene!.frame.size.width, y: (-750 + ran1))
        pillarUD1.position = CGPoint(x: scene.scene!.frame.size.width, y: (750 + ran1))
        
        pillar2.position = CGPoint(x: scene.scene!.frame.size.width * 1.5, y: (-750 + ran2))
        pillarUD2.position = CGPoint(x: scene.scene!.frame.size.width * 1.5, y: (750 + ran2))
        

        scene.addChild(pillar1)
        scene.addChild(pillarUD1)
        
        scene.addChild(pillar2)
        scene.addChild(pillarUD2)
        jump = scene.scene!.frame.size.width

    }
    
    func changePosition() {
        if scene.player.gameStarted {
             pillar1.position.x -= Obsticle.speed
             pillarUD1.position.x -= Obsticle.speed
            
            pillar2.position.x -= Obsticle.speed
            pillarUD2.position.x -= Obsticle.speed
            
            if (pillar1.position.x < CGFloat(-(scene.scene!.frame.size.width)/2)) {
                let randomTemp = CGFloat.random(in: -300...300)
                pillar1.position.x += jump
                pillarUD1.position.x += jump
                
                pillar1.position.y = (-750 + randomTemp)
                pillarUD1.position.y = (750 + randomTemp)
                
            }
            
            if (pillar2.position.x < CGFloat(-(scene.scene!.frame.size.width)/2)) {
                let randomTemp = CGFloat.random(in: -300...300)
                pillar2.position.x += jump
                pillarUD2.position.x += jump
                
                pillar2.position.y = (-750 + randomTemp)
                pillarUD2.position.y = (750 + randomTemp)
            }
            

        }
       
    }
    
   
        
       
    private func generatePillar(image: String) -> SKSpriteNode {
        let pillar = SKSpriteNode(imageNamed: image)
        pillar.zPosition = 1
        
        pillar.name = "pillar"
        pillar.position = CGPoint(x: 200, y: 0.0)
        pillar.isUserInteractionEnabled = false
        pillar.physicsBody = SKPhysicsBody(texture: pillar.texture!, size: pillar.texture!.size())
        pillar.physicsBody?.usesPreciseCollisionDetection = true
        pillar.physicsBody?.restitution = 0
        pillar.physicsBody?.categoryBitMask = obsticleBitMask
        pillar.physicsBody?.collisionBitMask = playerBitMask
        pillar.physicsBody?.isDynamic = true
        pillar.physicsBody?.affectedByGravity = false
        pillar.physicsBody?.allowsRotation = false

        return pillar
    }
}
