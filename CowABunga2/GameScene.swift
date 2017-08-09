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
        
        groundL.physicsBody = SKPhysicsBody(rectangleOf: groundL.size)
        groundL.physicsBody?.affectedByGravity = false
        groundL.physicsBody?.pinned = true
        groundL.physicsBody?.allowsRotation = false
        
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
       
        
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.pinned = false
        
        
        addChild(player)
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addCow), SKAction.wait(forDuration: 5.0)])))
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -4.45)
    }
    
    func addCow()
    {
        var cow : Cow
        
        cow = Cow(imageNamed: "Cow")
        
        cow.size.height = 15
        cow.size.width = 20
        
        cow.position = CGPoint(x: cow.size.width/2, y: size.height/2 + cow.size.height/2)
        
        cow.physicsBody = SKPhysicsBody(circleOfRadius: 17.5/2)
        cow.physicsBody?.isDynamic = true
        
        addChild(cow)
        
        var moveCow : SKAction
        
        //moveCow = SKAction.move(to: CGPoint(x: size.width, y: cow.position.y), duration: 10)
        moveCow = SKAction.repeatForever(SKAction.moveBy(x: 10, y: 0, duration: 0.1))
        
        cow.run(SKAction.sequence([moveCow, SKAction.removeFromParent()]))
        
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
            player.run(SKAction.move(to: CGPoint(x: touchLocation.x, y: sea.size.height), duration: 0.1))
        }
        else if touchDown && touchLocation.x > 736*3/4 - player.size.width/2
        {
            player.run(SKAction.move(to: CGPoint(x: 736*3/4 - player.size.width/2, y: sea.size.height), duration: 0.1))
        }
        else if touchDown && touchLocation.x < 736*4 + player.size.width/2
        {
            player.run(SKAction.move(to: CGPoint(x: 736/4 + player.size.width/2, y: sea.size.height), duration: 0.1))
        }
    }
}
