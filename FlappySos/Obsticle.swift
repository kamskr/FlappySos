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
    var random: CGFloat = CGFloat.random(in: -300...300)
   
    var obsticleBitMask = UInt32(2)
    var playerBitMask = UInt32(4)
    static var speed: CGFloat = 2
    
    init(_ scene: GameScene) {
        self.scene = scene
        initializeObsticles()
    }
    
    private func initializeObsticles() {
        
        pillar1 = generatePillar(image: "piller")
        pillarUD1 = generatePillar(image: "pillerUD")
        
        pillar2 = generatePillar(image: "piller")
        pillarUD2 = generatePillar(image: "pillerUD")
        
        pillar3 = generatePillar(image: "piller")
        pillarUD3 = generatePillar(image: "pillerUD")
        
        pillar1.position = CGPoint(x: 300, y: -750)
        pillarUD1.position = CGPoint(x: 300, y: 750)
        
        pillar2.position = CGPoint(x: 600, y: (-750 + random))
        pillarUD2.position = CGPoint(x: 600, y: (750 + random))
        
        pillar3.position = CGPoint(x: 900, y: -750)
        pillarUD3.position = CGPoint(x: 900, y: 750)
        
        scene.addChild(pillar1)
        scene.addChild(pillarUD1)
        
        scene.addChild(pillar2)
        scene.addChild(pillarUD2)
        
        scene.addChild(pillar3)
        scene.addChild(pillarUD3)
    }
    
    func changePosition() {
        if scene.player.gameStarted {
             pillar1.position.x -= Obsticle.speed
             pillarUD1.position.x -= Obsticle.speed
            
            pillar2.position.x -= Obsticle.speed
            pillarUD2.position.x -= Obsticle.speed
            
            pillar3.position.x -= Obsticle.speed
            pillarUD3.position.x -= Obsticle.speed
            
            if checkPosition(node1: pillar1, node2: pillarUD1){
                pillar1.position.x = 500
                pillarUD1.position.x = 500
            }
            
            if checkPosition(node1: pillar2, node2: pillarUD2){
                pillar2.position.x = 500
                pillarUD2.position.x = 500
            }
            
            if checkPosition(node1: pillar3, node2: pillarUD3){
                pillar3.position.x = 500
                pillarUD3.position.x = 500
            }
        }
       
    }
    
    private func checkPosition(node1: SKSpriteNode, node2: SKSpriteNode) -> Bool {
        return (node1.position.x == -500 && node2.position.x == -500)
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
