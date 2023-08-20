//
//  Player.swift
//  gloopdrop
//
//  Created by Tammy Coron on 1/24/2020.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import Foundation
import SpriteKit

// This enum lets you easily switch between animations
enum PlayerAnimationType: String {
  case walk
  case die
}

class Player: SKSpriteNode {
  // MARK: - PROPERTIES
  
  // Textures (Animation)
  private var walkTextures: [SKTexture]?
  private var dieTextures: [SKTexture]?

  // MARK: - INIT
  
  init() {

    // Set default texture
    let texture = SKTexture(imageNamed: "blob-walk_0")

    // Call to super.init
    super.init(texture: texture, color: .clear, size: texture.size())

    // Setup animation textures
    self.walkTextures = self.loadTextures(atlas: "blob", prefix: "blob-walk_",
                                          startsAt: 0, stopsAt: 2)
    self.dieTextures = self.loadTextures(atlas: "blob", prefix: "blob-die_",
                                         startsAt: 0, stopsAt: 0)
    
    /* The call to the `loadTextures` extension essentially does this:
    self.walkTextures = [SKTexture(imageNamed: "blob-walk_0"),
                         SKTexture(imageNamed: "blob-walk_1"),
                         SKTexture(imageNamed: "blob-walk_2")] */

    // Setup other properties after init
    self.name = "player"
    self.setScale(1.0)
    self.anchorPoint = CGPoint(x: 0.5, y: 0.0) // center-bottom
    self.zPosition = Layer.player.rawValue
    
    // Add physics body
    self.physicsBody = SKPhysicsBody(rectangleOf: self.size, center: CGPoint(x: 0.0, y: self.size.height/2))
    self.physicsBody?.affectedByGravity = false
    
    // Set up physics categories for contacts
    self.physicsBody?.categoryBitMask = PhysicsCategory.player
    self.physicsBody?.contactTestBitMask = PhysicsCategory.collectible
    self.physicsBody?.collisionBitMask = PhysicsCategory.none
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - METHODS
  
  func setupConstraints(floor: CGFloat) {
    let range = SKRange(lowerLimit: floor, upperLimit: floor)
    let lockToPlatform = SKConstraint.positionY(range)

    constraints = [ lockToPlatform ]
  }
  
  func walk() {
    // Check for textures
    guard let walkTextures = walkTextures else {
      preconditionFailure("Could not find textures!")
    }
    
    // Stop the die animation
    removeAction(forKey: PlayerAnimationType.die.rawValue)
    
    // Run animation (forever)
    startAnimation(textures: walkTextures, speed: 0.25,
                   name: PlayerAnimationType.walk.rawValue,
                   count: 0, resize: true, restore: true)
  }
  
  func die() {
    // Check for textures
    guard let dieTextures = dieTextures else {
      preconditionFailure("Could not find textures!")
    }
    
    // Stop the walk animation
    removeAction(forKey: PlayerAnimationType.walk.rawValue)
    
    // Run animation (forever)
    startAnimation(textures: dieTextures, speed: 0.25,
                   name: PlayerAnimationType.die.rawValue,
                   count: 0, resize: true, restore: true)
  }
  
  func moveToPosition(pos: CGPoint, direction: String, speed: TimeInterval) {
    switch direction {
    case "L":
      xScale = -abs(xScale)
    default:
      xScale = abs(xScale)
    }

    let moveAction = SKAction.move(to: pos, duration: speed)
    run(moveAction)
  }
}
