//
//  SpriteKitHelper.swift
//  gloopdrop
//
//  Created by Tammy Coron on 1/24/2020.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import Foundation
import SpriteKit

// MARK: - SPRITEKIT HELPERS

// Setup shared z-positions
enum Layer: CGFloat {
  case background
  case foreground
  case player
}

// MARK: - SPRITEKIT EXTENSIONS

extension SKSpriteNode {
  
  // Used to load texture arrays for animations
  func loadTextures(atlas: String, prefix: String,
                    startsAt: Int, stopsAt: Int) -> [SKTexture] {
    var textureArray = [SKTexture]()
    let textureAtlas = SKTextureAtlas(named: atlas)
    for i in startsAt...stopsAt {
      let textureName = "\(prefix)\(i)"
      let temp = textureAtlas.textureNamed(textureName)
      textureArray.append(temp)
    }

    return textureArray
  }
  
  // Start the animation using a name and a count (0 = repeat forever)
  func startAnimation(textures: [SKTexture], speed: Double, name: String,
                      count: Int, resize: Bool, restore: Bool) {

    // Run animation only if animation key doesn't already exist
    if (action(forKey: name) == nil) {
      let animation = SKAction.animate(with: textures, timePerFrame: speed,
                                       resize: resize, restore: restore)

      if count == 0 {
        // Run animation until stopped
        let repeatAction = SKAction.repeatForever(animation)
        run(repeatAction, withKey: name)
      } else if count == 1 {
        run(animation, withKey: name)
      } else {
        let repeatAction = SKAction.repeat(animation, count: count)
        run(repeatAction, withKey: name)
      }
    }
  }
}
