//
//  GameScene.swift
//  gloopdrop
//
//  Created by Alexey Krzywicki on 19.08.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: - Properties
    let player = Player()
    let playerSpeed: CGFloat = 1.5
    var level: Int = 8
    var numberOfDrops: Int = 10
    var dropSpeed: CGFloat = 1.0
    var minDropSpeed: CGFloat = 0.12 // (fastest drop)
    var maxDropSpeed: CGFloat = 1.0 // (slowest drop)
    
    // Player movement
    var movingPlayer = false
    var lastPosition: CGPoint?
    
    
    // MARK: - Lifecycle
    override func didMove(to view: SKView) {
        // Set up background
        let background = SKSpriteNode(imageNamed: "background_1")
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = .zero
        background.zOrder = .background
        // CGPoint(x: 0, y: 0) and .zero is the same
        addChild(background)
        
        // Set up foreground
        let foreground = SKSpriteNode(imageNamed: "foreground_1")
        foreground.anchorPoint = CGPoint(x: 0, y: 0)
        foreground.position = .zero
        foreground.zOrder = .foreground
        addChild(foreground)
        
        // Set up player
        player.position = CGPoint(x: size.width/2, y: foreground.frame.maxY)
        addChild(player)
        player.setupConstraints(floor: foreground.frame.maxY)
        player.walk()
        // Set up game
        spawnMultipleGloops()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchMoved(toPoint: t.location(in: self))
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
        }
    }
    
    // MARK: - TOUCH HANDLING
    /* ######################################## */
    /*     TOUCH HANDLERS STARTS HERE           */
    /* ######################################## */
//    func touchDown(atPoint pos : CGPoint) {
//        let distance = hypot(pos.x-player.position.x, pos.y-player.position.y)
//        let calculatedSpeed = TimeInterval(distance / playerSpeed) / 255
//        print(" distance: \(distance) \n calculatedSpeed: \(calculatedSpeed)")
//        //player.moveToPosition(pos: pos, speed: 1.0)
//        if pos.x < player.position.x {
//            player.moveToPosition(pos: pos, direction: "L", speed: calculatedSpeed)
//        } else {
//            player.moveToPosition(pos: pos, direction: "R", speed: calculatedSpeed)
//        }
//    }
    func touchDown(atPoint pos: CGPoint) {
        let touchedNode = atPoint(pos)
        if touchedNode.name == "player" {
            movingPlayer = true
        }
    }
    func touchMoved(toPoint pos: CGPoint) {
        if movingPlayer == true {
            // Clamp position
            let newPos = CGPoint(x: pos.x, y: player.position.y)
            player.position = newPos
            // Check last position; if empty set it
            let recordedPosition = lastPosition ?? player.position
            if recordedPosition.x > newPos.x {
                player.xScale = -abs(xScale)
            } else {
                player.xScale = abs(xScale)
            }
            // Save last known position
            lastPosition = newPos
        }
    }
    func touchUp(atPoint pos: CGPoint) {
        movingPlayer = false
    }
    
    // MARK: - GAME FUNCTIONS
    /* ####################################################################### */
    /*                      GAME FUNCTIONS START HERE                          */
    /* ####################################################################### */
    func spawnGloop() {
        let collectible = Collectible(collectibleType: CollectibleType.gloop)
        
//        collectible.position = CGPoint(x: player.position.x, y: player.position.y * 2.5)
//        addChild(collectible)
        let margin = collectible.size.width * 2
        let dropRange = SKRange(lowerLimit: frame.minX + margin, upperLimit: frame.maxX - margin)
        let randomX = CGFloat.random(in: dropRange.lowerLimit...dropRange.upperLimit)
        collectible.position = CGPoint(x: randomX, y: player.position.y * 2.5)
        addChild(collectible)
        collectible.drop(dropSpeed: TimeInterval(1.0), floorLevel: player.frame.minY)
    }
    func spawnMultipleGloops() {
        switch level {
        case 1, 2, 3, 4, 5:
            numberOfDrops = level * 10
        case 6:
            numberOfDrops = 75
        case 7:
            numberOfDrops = 100
        case 8:
            numberOfDrops = 150
        default:
            numberOfDrops = 150
        }
        
        // Set up drop speed
        dropSpeed = 1 / (CGFloat(level) +
                         (CGFloat(level) / CGFloat(numberOfDrops)))
        if dropSpeed < minDropSpeed {
            dropSpeed = minDropSpeed
        } else if dropSpeed > maxDropSpeed {
            dropSpeed = maxDropSpeed
        }
        
        // Set up repeating action
        let wait = SKAction.wait(forDuration: TimeInterval(dropSpeed))
        let spawn = SKAction.run { [unowned self] in self.spawnGloop() }
        let sequence = SKAction.sequence([wait, spawn])
        let repeatAction = SKAction.repeat(sequence, count: numberOfDrops)
        // Run action
        run(repeatAction, withKey: "gloop")
    }

}
