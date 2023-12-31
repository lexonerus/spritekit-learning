//
//  GameObjects.swift
//  valsrevenge
//
//  Created by Tammy Coron on 7/4/20.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

enum GameObjectType: String {
  
  // Monsters
  case skeleton
  case goblin
  
  // Collectibles
  case key
  case food
  case treasure
}

struct GameObject {
  
  static let defaultGeneratorType = GameObjectType.skeleton.rawValue
  static let defaultAnimationType = GameObjectType.skeleton.rawValue
  
  static let defaultCollectibleType = GameObjectType.key.rawValue
  
  static let skeleton = Skeleton()
  static let goblin = Goblin()
  
  static let key = Key()
  static let food = Food()
  static let treasure = Treasure()
  
  struct Goblin {
    let animationSettings = Animation(textures:
      SKTexture.loadTextures(atlas: "monster_goblin",
                             prefix: "goblin_", startsAt: 0, stopsAt: 1))
  }
  
  struct Skeleton {
    let animationSettings = Animation(textures:
      SKTexture.loadTextures(atlas: "monster_skeleton",
                             prefix: "skeleton_", startsAt: 0, stopsAt: 1),
                                      timePerFrame: TimeInterval(1.0 / 25.0))
  }
  
  struct Key {
    let collectibleSettings = Collectible(type: .key,
                                          collectSound: "key",
                                          destroySound: "destroyed")
  }
  
  struct Food {
    let collectibleSettings = Collectible(type: .food,
                                          collectSound: "food",
                                          destroySound: "destroyed",
                                          canDestroy: true)
  }
  
  struct Treasure {
    let collectibleSettings = Collectible(type: .treasure,
                                          collectSound: "treasure",
                                          destroySound: "destroyed")
  }
  
  static func forAnimationType(_ type: GameObjectType?) -> Animation? {
    switch type {
    case .skeleton:
      return GameObject.skeleton.animationSettings
    case .goblin:
      return GameObject.goblin.animationSettings
    default:
      return nil
    }
  }
  
  static func forCollectibleType(_ type: GameObjectType?) -> Collectible? {
    switch type {
    case .key:
      return GameObject.key.collectibleSettings
    case .food:
      return GameObject.food.collectibleSettings
    case .treasure:
      return GameObject.treasure.collectibleSettings
    default:
      return nil
    }
  }
}
