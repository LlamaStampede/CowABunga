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
    private var groundR = SKSpriteNode(imageNamed: "groundR")
    private var groundR1 = SKSpriteNode(imageNamed: "groundR2")
    private var groundR2 = SKSpriteNode(imageNamed: "groundR3")
    private var sea = SKSpriteNode(imageNamed: "sea")
    private var seaR = SKSpriteNode(imageNamed: "sea")
    
    let playerTexture = SKTexture(imageNamed: "boat")
    
    private var player = SKSpriteNode(imageNamed: "boat")
    
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.black
        
        groundL.size.height = size.height/2
        groundL.size.width = size.width/4
        
        
        let xCoord = groundL.size.width * 0.5
        let yCoord = groundL.size.height * 0.5
        groundL.position = CGPoint(x: xCoord, y: yCoord)
        
        
        groundR.size.height = size.height
        groundR.size.width = size.width/4
        groundR.position = CGPoint(x: CGFloat(xCoord + size.width*6/8), y: size.height/2 - 30)
        
        groundR1.size.height = size.height
        groundR1.size.width = size.width/4
        groundR1.position = CGPoint(x: CGFloat(xCoord + size.width*6/8), y: size.height/2 - 30)
        
        groundR2.size.height = size.height
        groundR2.size.width = size.width/4
        groundR2.position = CGPoint(x: CGFloat(xCoord + size.width*6/8), y: size.height/2 - 30)
        
        
        groundL.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: groundL.size.width, height: groundL.size.height - 25))
        groundL.physicsBody?.affectedByGravity = false
        groundL.physicsBody?.pinned = true
        groundL.physicsBody?.allowsRotation = false
        
        sea.size.height = size.height/8
        sea.size.width = size.width/4
        
        seaR.size.height = size.height/8
        seaR.size.width = size.width/4
        
        seaR.position = CGPoint(x: CGFloat(size.width/2 - size.width/8), y: sea.size.height/2)
        
        sea.position = CGPoint(x: CGFloat(size.width/2 + size.width/8), y: sea.size.height/2)
        
        groundR.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 186, height: 10), center: CGPoint(x: 0, y: -140))
        groundR.physicsBody?.affectedByGravity = false
        groundR.physicsBody?.pinned = true
        groundR.physicsBody?.allowsRotation = false
        
        groundR1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 186, height: 10), center: CGPoint(x: 0, y: 0))
        groundR1.physicsBody?.affectedByGravity = false
        groundR1.physicsBody?.pinned = true
        groundR1.physicsBody?.allowsRotation = false
        
        groundR2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 186, height: 10), center: CGPoint(x: 0, y: 180))
        groundR2.physicsBody?.affectedByGravity = false
        groundR2.physicsBody?.pinned = true
        groundR2.physicsBody?.allowsRotation = false
        
        addChild(groundL)
        addChild(groundR)
        addChild(groundR1)
        addChild(groundR2)
        addChild(sea)
        addChild(seaR)
        
        print(size.height, "Height,  ", size.width, "Width")
        
        player.size.height = size.height/16
        player.size.width = size.width/12
        
        player.position = CGPoint(x: CGFloat(size.width/4 + player.size.width/2), y: sea.size.height)// + player.size.height/2)
       
        
        
        
        
        
        //player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        //player.physicsBody = SKPhysicsBody(texture: playerTexture, size: CGSize(width: player.size.width, height: player.size.height))
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height - 25))
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.pinned = false
        //player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        //player.physicsBody?.applyTorque(CGFloat(nan: 0,signaling: false))
        //player.physicsBody?.isResting = true
        player.physicsBody?.mass = CGFloat(0)
        player.physicsBody?.isDynamic = false
        
        
        
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
        
        cow.position = CGPoint(x: cow.size.width/2, y: size.height/2 + cow.size.height/2 - 25)
        
        cow.physicsBody = SKPhysicsBody(circleOfRadius: 17.5/2)
        cow.physicsBody?.isDynamic = true
        cow.physicsBody?.restitution = 1.05
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
        print(touchLocation)
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
