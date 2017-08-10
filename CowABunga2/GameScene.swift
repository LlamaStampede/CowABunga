//
//  GameScene.swift
//  CowABunga2
//
//  Created by iD Student on 8/8/17.
//  Copyright © 2017 iD Student. All rights reserved.
//

import SpriteKit
import GameplayKit

struct BodyType {
    
    static let None: UInt32 = 0
    static let Player: UInt32 = 1
    static let Cow: UInt32 = 2
    static let Sea: UInt32 = 3
    static let Ground: UInt32 = 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var touchLocation = CGPoint(x: 0,y: 0)
    var touchDown = false
    
    var randomBounce = 0
    var randomSpeed = 0
    
    private var groundL = SKSpriteNode(imageNamed: "ground small")
    private var groundR = SKSpriteNode(imageNamed: "groundR")
    private var groundR1 = SKSpriteNode(imageNamed: "groundR2")
    private var groundR2 = SKSpriteNode(imageNamed: "groundR3")
    private var sea = SKSpriteNode(imageNamed: "sea")
    private var seaR = SKSpriteNode(imageNamed: "sea")
    private var jumpButton = SKSpriteNode(imageNamed: "jumpButton")
    
    let playerTexture = SKTexture(imageNamed: "boat")
    
    private var player = SKSpriteNode(imageNamed: "boat")
    
    var cowArray : [SKSpriteNode] = []
    
    
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
        groundL.physicsBody?.collisionBitMask = 1
        
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
        groundR.physicsBody?.collisionBitMask = 1
        
        groundR1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 186, height: 10), center: CGPoint(x: 0, y: 0))
        groundR1.physicsBody?.affectedByGravity = false
        groundR1.physicsBody?.pinned = true
        groundR1.physicsBody?.allowsRotation = false
        groundR1.physicsBody?.collisionBitMask = 1
        
        
        groundR2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 186, height: 10), center: CGPoint(x: 0, y: 180))
        groundR2.physicsBody?.affectedByGravity = false
        groundR2.physicsBody?.pinned = true
        groundR2.physicsBody?.allowsRotation = false
        groundR2.physicsBody?.collisionBitMask = 1
        
        sea.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 368, height: 10), center: CGPoint(x: 0, y: -180))
        sea.physicsBody?.affectedByGravity = false
        sea.physicsBody?.pinned = true
        sea.physicsBody?.allowsRotation = false
        sea.physicsBody?.collisionBitMask = 1
        
        addChild(groundL)
        addChild(groundR)
        addChild(groundR1)
        addChild(groundR2)
        addChild(sea)
        addChild(seaR)
        
        print(size.height, "Height,  ", size.width, "Width")
        
        
        jumpButton.size.width = 75
        jumpButton.size.height = 75
        
        jumpButton.position = CGPoint(x: groundL.size.width/2 , y: groundL.size.height/2 )
        addChild(jumpButton)
        
        player.size.height = size.height/16
        player.size.width = size.width/12
        
        player.position = CGPoint(x: CGFloat(size.width/4 + player.size.width/2), y: sea.size.height)// + player.size.height/2)
       
        
        
        
        
        
        //player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        
        var platformMode = 1
        if platformMode == 0
        {
        player.physicsBody = SKPhysicsBody(texture: playerTexture, size: CGSize(width: player.size.width, height: player.size.height))
        }
        else if platformMode == 1
        {
            player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height - 25))
        }
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.pinned = false
        player.physicsBody?.mass = CGFloat(0)
        player.physicsBody?.isDynamic = false
        player.physicsBody?.collisionBitMask = 1
        
        
        
        addChild(player)
        
        
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addCow), SKAction.wait(forDuration: 5.0)])))
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -4.45)
        physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {

        print("woerkign")
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        switch bodyA.categoryBitMask {
        case BodyType.Cow:
            switch bodyB.categoryBitMask {
            case BodyType.Cow:
                break //for later
            case BodyType.Ground:
                break
            case BodyType.Player:
                if let cowNode = bodyA.node as? Cow, let playerNode = bodyB.node as? SKSpriteNode
                {
                    cowHitPlayer(cowNode : cowNode, playerNode : playerNode)
                }
            case BodyType.Sea:
                if let cowNode = bodyA.node as? Cow, let seaNode = bodyB.node as? SKSpriteNode
                {
                    cowHitSea(cowNode : cowNode, seaNode : seaNode)
                }
            default:
                break
            }
        case BodyType.Ground:
            switch bodyB.categoryBitMask {
            case BodyType.Cow:
                break
            case BodyType.Player:
                break
            case BodyType.Sea:
                break
            default:
                break
            }
        case BodyType.Player:
            switch bodyB.categoryBitMask {
            case BodyType.Cow:
                if  let playerNode = bodyA.node as? SKSpriteNode, let cowNode = bodyB.node as? Cow
                {
                    cowHitPlayer(cowNode : cowNode, playerNode : playerNode)
                }
            case BodyType.Ground:
                break
            case BodyType.Sea:
                break
            default:
                break
            }
        case BodyType.Sea:
            switch bodyB.categoryBitMask {
            case BodyType.Cow:
                if let cowNode = bodyB.node as? Cow, let seaNode = bodyA.node as? SKSpriteNode
                {
                    cowHitSea(cowNode : cowNode, seaNode : seaNode)
                }

            case BodyType.Ground:
                break
            case BodyType.Player:
                break
            default:
                break
            }
        default:
            break
        }
    }
    
    func cowHitPlayer(cowNode : Cow, playerNode : SKSpriteNode)
    {
        print("cow hit player")
        cowNode.physicsBody?.restitution = 1
    }
    
    func cowHitSea(cowNode : Cow, seaNode : SKSpriteNode)
    {
        print("removing cow")
        cowNode.removeFromParent()
    }
    
    func addCow()
    {
        var cow : Cow
        
        randomBounce = Int(arc4random_uniform(10))
        randomSpeed = Int(arc4random_uniform(10))
        
        cow = Cow(imageNamed: "Cow")
        
        cow.size.height = 15
        cow.size.width = 20
        
        cow.position = CGPoint(x: cow.size.width/2, y: size.height/2 + cow.size.height/2 - 25)
        
        cow.physicsBody = SKPhysicsBody(circleOfRadius: 17.5/2)
        cow.physicsBody?.isDynamic = true
        cow.physicsBody?.restitution = CGFloat(0.75) + CGFloat(randomBounce/10)
        cowArray.append(cow)
        addChild(cow)
        
        var moveCow : SKAction
        
        //moveCow = SKAction.move(to: CGPoint(x: size.width, y: cow.position.y), duration: 10)
        moveCow = SKAction.repeatForever(SKAction.moveBy(x: 10, y: 0, duration: Double(0.05) + Double(randomSpeed)/100))
        
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
        for cow in cowArray
        {
            if (cow.physicsBody?.velocity.dy)! >= CGFloat(0)
            {
                cow.physicsBody?.collisionBitMask = 0
            }
            else
            {
                cow.physicsBody?.collisionBitMask = 1
            }
            //cow.physicsBody.
        }
    }
}
