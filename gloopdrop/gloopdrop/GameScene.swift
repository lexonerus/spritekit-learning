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
    }
    
    // MARK: - TOUCH HANDLING
    /* ######################################## */
    /*     TOUCH HANDLERS STARTS HERE           */
    /* ######################################## */
    func touchDown(atPoint pos : CGPoint) {
        let distance = hypot(pos.x-player.position.x, pos.y-player.position.y)
        let calculatedSpeed = TimeInterval(distance / playerSpeed) / 255
        print(" distance: \(distance) \n calculatedSpeed: \(calculatedSpeed)")
        //player.moveToPosition(pos: pos, speed: 1.0)
        if pos.x < player.position.x {
            player.moveToPosition(pos: pos, direction: "L", speed: calculatedSpeed)
        } else {
            player.moveToPosition(pos: pos, direction: "R", speed: calculatedSpeed)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }

}
