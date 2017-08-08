//
//  GameScene.swift
//  CowABunga2
//
//  Created by iD Student on 8/8/17.
//  Copyright © 2017 iD Student. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var touchLocation = CGPoint(x: 0,y: 0)
    var touchDown = false
    
    private var groundL = SKSpriteNode(imageNamed: "ground small")
    private var groundR = SKSpriteNode(imageNamed: "ground small")
    private var sea = SKSpriteNode(imageNamed: "sea")
    private var seaR = SKSpriteNode(imageNamed: "sea")
    
    private var player = SKSpriteNode(imageNamed: "boat")
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.black
        
        groundL.size.height = size.height/2
        groundL.size.width = size.width/4
        
        let xCoord = groundL.size.width * 0.5
        let yCoord = groundL.size.height * 0.5
        
        
        
        groundR.size.height = size.height/2
        groundR.size.width = size.width/4
        
        groundR.position = CGPoint(x: CGFloat(xCoord + size.width*6/8), y: yCoord)
        groundL.position = CGPoint(x: xCoord, y: yCoord)
        
        sea.size.height = size.height/8
        sea.size.width = size.width/4
        
        seaR.size.height = size.height/8
        seaR.size.width = size.width/4
        
        seaR.position = CGPoint(x: CGFloat(size.width/2 - size.width/8), y: sea.size.height/2)
        
        sea.position = CGPoint(x: CGFloat(size.width/2 + size.width/8), y: sea.size.height/2)
        
        addChild(groundL)
        addChild(groundR)
        addChild(sea)
        addChild(seaR)
        
        player.size.height = size.height/16
        player.size.width = size.width/12
        
        player.position = CGPoint(x: CGFloat(size.width/4 + player.size.width/2), y: sea.size.height)// + player.size.height/2)
       
        addChild(player)
        
    }
    
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchLocation = touch.location(in: self)
        touchDown = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchLocation = touch.location(in: self)
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchDown = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchDown = false
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if touchDown && touchLocation.x < 736*3/4 - player.size.width/2 && touchLocation.x > 736/4 + player.size.width/2
        {
            //player.position.x = touchLocation.x
            player.run(SKAction.move(to: CGPoint(x: touchLocation.x, y: player.position.y), duration: 0.1))
        }
        else if touchDown && touchLocation.x > 736*3/4 - player.size.width/2
        {
            player.run(SKAction.move(to: CGPoint(x: 736*3/4 - player.size.width/2, y: player.position.y), duration: 0.1))
        }
        else if touchDown && touchLocation.x < 736*4 + player.size.width/2
        {
            player.run(SKAction.move(to: CGPoint(x: 736/4 + player.size.width/2, y: player.position.y), duration: 0.1))
        }
    }
}
