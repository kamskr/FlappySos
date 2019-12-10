//
//  Player.swift
//  FlappySos
//
//  Created by Kamil Sikora on 10/12/2019.
//  Copyright © 2019 Kamil Sikora. All rights reserved.
//

import SpriteKit

class Player {
    var playerAnimation: [SKTexture]!
    var playerNode: SKSpriteNode!
    
    init(){
        playerAnimation = [SKTexture.init(imageNamed: "bird1"), SKTexture.init(imageNamed: "bird2"), SKTexture.init(imageNamed: "bird3"), SKTexture.init(imageNamed: "bird4")]
        playerNode = SKSpriteNode(imageNamed: "bird1")
        
    }
    
}
