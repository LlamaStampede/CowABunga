//
//  Cow.swift
//  CowABunga2
//
//  Created by iD Student on 8/8/17.
//  Copyright © 2017 iD Student. All rights reserved.
//

import Foundation
import SpriteKit

class Cow : SKSpriteNode {
    
    init(imageNamed: String) {
        let texture = SKTexture(imageNamed: "\(imageNamed)")
        
        super.init(texture: texture, color: UIColor(), size: texture.size())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    
    }
}
