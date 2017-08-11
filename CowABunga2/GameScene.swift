//
//  GameScene.swift
//  CowABunga2
//
//  Created by iD Student on 8/8/17.
//  Copyright © 2017 iD Student. All rights reserved.
//
/*
 
 
-=-------- Why does the player move the ground?
 How do you get the second touch?
 Can i have more than one physicsBody per SKSpriteNode or just have a physicsBody without a SKSpriteNode\
 How to generate them faster
 SKsprite node alpha three indibviduals
 SOLVED -----When i hit the sea it says player hit??
 
 Project:
 
 add the different point groups
 */
import SpriteKit
import GameplayKit

struct BodyType {
    
    static let None: UInt32 = 0
    static let Player: UInt32 = 1
    static let Cow: UInt32 = 2
    static let Sea: UInt32 = 3
    static let Ground: UInt32 = 4
    static let Winner: UInt32 = 5
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var lives = 3
    var score = 0
    var waitTime = 5.0
    var touchLocation = CGPoint(x: 0,y: 0)
    var touchLocation2 = CGPoint(x: 0,y: 0)
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
    
    private var scoreLabel = SKLabelNode(fontNamed: "Arial")
    private var livesLabel = SKLabelNode(fontNamed: "Arial")
    
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
        groundL.physicsBody?.collisionBitMask = BodyType.Ground
        groundL.physicsBody?.categoryBitMask = BodyType.Ground
        groundL.physicsBody?.contactTestBitMask = BodyType.Cow
        
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
        groundR.physicsBody?.categoryBitMask = BodyType.Ground
        groundR.physicsBody?.contactTestBitMask = BodyType.Cow
        groundR.physicsBody?.collisionBitMask = BodyType.Ground
        
        groundR1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 186, height: 10), center: CGPoint(x: 0, y: 0))
        groundR1.physicsBody?.affectedByGravity = false
        groundR1.physicsBody?.pinned = true
        groundR1.physicsBody?.allowsRotation = false
        groundR1.physicsBody?.collisionBitMask = BodyType.Ground
        groundR1.physicsBody?.categoryBitMask = BodyType.Ground
        groundR1.physicsBody?.contactTestBitMask = BodyType.Cow
        
        
        groundR2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 186, height: 10), center: CGPoint(x: 0, y: 180))
        groundR2.physicsBody?.affectedByGravity = false
        groundR2.physicsBody?.pinned = true
        groundR2.physicsBody?.allowsRotation = false
        groundR2.physicsBody?.collisionBitMask = BodyType.Ground
        groundR2.physicsBody?.categoryBitMask = BodyType.Ground
        groundR2.physicsBody?.contactTestBitMask = BodyType.Cow
        
        sea.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 736, height: 10), center: CGPoint(x: 0, y: -180))
        sea.physicsBody?.affectedByGravity = false
        sea.physicsBody?.pinned = true
        sea.physicsBody?.allowsRotation = false
        sea.physicsBody?.collisionBitMask = BodyType.Ground
        sea.physicsBody?.categoryBitMask = BodyType.Sea
        sea.physicsBody?.contactTestBitMask = BodyType.Cow
        
        seaR.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 400), center: CGPoint(x: 475, y: 175))
        seaR.physicsBody?.affectedByGravity = false
        seaR.physicsBody?.pinned = true
        seaR.physicsBody?.allowsRotation = false
        seaR.physicsBody?.collisionBitMask = BodyType.Ground
        seaR.physicsBody?.categoryBitMask = BodyType.Winner
        seaR.physicsBody?.contactTestBitMask = BodyType.Cow
        
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
        
        jumpButton.physicsBody = SKPhysicsBody(rectangleOf: jumpButton.size)
        jumpButton.physicsBody?.affectedByGravity = false
        jumpButton.physicsBody?.pinned = true
        jumpButton.physicsBody?.allowsRotation = false
        
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
        player.physicsBody?.collisionBitMask = 4
        player.physicsBody?.categoryBitMask = BodyType.Ground
        player.physicsBody?.contactTestBitMask = BodyType.Cow
        
        addChild(player)
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addCow), SKAction.wait(forDuration: waitTime)])))
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -4.45)
        physicsWorld.contactDelegate = self
        
        scoreLabel.fontColor = UIColor.white
        
        scoreLabel.fontSize = 40
        
        scoreLabel.position = CGPoint(x: 75, y: self.size.height-50)
        
        addChild(scoreLabel)
        
        livesLabel.text = "0"
        
        livesLabel.fontColor = UIColor.white
        
        livesLabel.fontSize = 40
        
        livesLabel.position = CGPoint(x: 75, y: self.size.height-100)
        
        addChild(livesLabel)
        
        livesLabel.text = "0"
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        //print("woerkign")
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        switch bodyA.categoryBitMask {
        case BodyType.Cow:
            switch bodyB.categoryBitMask {
            case BodyType.Cow:
                break //for later
            case BodyType.Winner:
                if let cowNode = bodyA.node as? Cow, let winnerNode = bodyB.node as? SKSpriteNode
                {
                    cowHitWinner(cowNode : cowNode, winnerNode : winnerNode)
                }
            case BodyType.Ground:
                break
            case BodyType.Player:
                print("cow hit the player")
                if let cowNode = bodyA.node as? Cow, let playerNode = bodyB.node as? SKSpriteNode
                {
                    cowHitPlayer(cowNode : cowNode, playerNode : playerNode)
                }
            case BodyType.Sea:
                print("cow hit the sea")
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
            //case BodyType.Player:
              //  break
            case BodyType.Sea:
                break
            default:
                break
            }
        case BodyType.Player:
            switch bodyB.categoryBitMask {
            case BodyType.Cow:
                print("player hit the cow")
                if  let playerNode = bodyA.node as? SKSpriteNode, let cowNode = bodyB.node as? Cow
                {
                    cowHitPlayer(cowNode : cowNode, playerNode : playerNode)
                }
            //case BodyType.Ground:
               //break
            case BodyType.Sea:
                break
            default:
                break
            }
        case BodyType.Sea:
            switch bodyB.categoryBitMask {
            case BodyType.Cow:
                print("sea hit the cow")
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
        case BodyType.Winner:
            switch bodyB.categoryBitMask {
            case BodyType.Cow:
                if let cowNode = bodyB.node as? Cow, let winnerNode = bodyA.node as? SKSpriteNode
                {
                    cowHitWinner(cowNode: cowNode, winnerNode: winnerNode)                }
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
    func cowHitWinner(cowNode : Cow, winnerNode : SKSpriteNode)
    {
        print("wimnner")
        score += 1
        cowNode.removeFromParent()
    }
    func cowHitSea(cowNode : Cow, seaNode : SKSpriteNode)
    {
        lives -= 1
        print("removing cow")
        cowNode.removeFromParent()
    }
    
    func addCow()
    {
        var cow : Cow
        
        var randSpeed : UInt32 = 10 + UInt32(score)
        
        randomBounce = Int(arc4random_uniform(UInt32(30) + UInt32(score)))
        randomSpeed = Int(arc4random_uniform(randSpeed))
        
        cow = Cow(imageNamed: "Cow")
        
        cow.size.height = 15
        cow.size.width = 20
        
        cow.position = CGPoint(x: cow.size.width/2, y: size.height/2 + cow.size.height/2 + 15)
        
        cow.physicsBody = SKPhysicsBody(circleOfRadius: 17.5/2)
        cow.physicsBody?.isDynamic = true
        cow.physicsBody?.restitution = CGFloat(1) + CGFloat(randomBounce/100)
        cow.physicsBody?.collisionBitMask = BodyType.Ground
        cow.physicsBody?.categoryBitMask = BodyType.Cow
        cow.physicsBody?.contactTestBitMask = BodyType.Sea | BodyType.Ground | BodyType.Player
        
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
        
        if touches.count == 1{
            if !jumpButton.contains(touchLocation){
                touchDown = true
            }
            else {
                // do jump button stuff
                touchDown = false
            }
        } else{
            
        }
        for t in touches {
            let tLoc = t.location(in: self)
            
        }
        
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
        scoreLabel.text = String("Score: \(score)")
        livesLabel.text = String("Lives: \(lives)")
        waitTime = 5.0 - 10 / Double(score)
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
                cow.physicsBody?.collisionBitMask = BodyType.Ground
            }
            if cow.position.y >  275
            {
                cow.physicsBody?.restitution = 1
            }
            if cow.position.x > 552
            {
                cow.physicsBody?.restitution = 0.5
            }
            
            
            //cow.physicsBody.
        }
    }
}
