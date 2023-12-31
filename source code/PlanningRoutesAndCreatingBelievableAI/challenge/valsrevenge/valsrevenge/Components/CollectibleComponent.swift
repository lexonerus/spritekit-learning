//
//  CollectibleComponent.swift
//  valsrevenge
//
//  Created by Tammy Coron on 7/4/20.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

struct Collectible {
  let type: GameObjectType
  
  let collectSoundFile: String
  let destroySoundFile: String
  
  let canDestroy: Bool
  
  init(type: GameObjectType, collectSound: String,
       destroySound: String, canDestroy: Bool = false) {
    self.type = type
    
    self.collectSoundFile = collectSound
    self.destroySoundFile = destroySound
    
    self.canDestroy = canDestroy
  }
}

// MARK: - COMPONENT CODE STARTS HERE

class CollectibleComponent: GKComponent {
  
  @GKInspectable var collectibleType: String =
    GameObject.defaultCollectibleType
  @GKInspectable var value: Int = 1
  
  private var collectSoundAction = SKAction()
  private var destroySoundAction = SKAction()
  private var canDestroy = false
  
  override func didAddToEntity() {
    guard let collectible =
      GameObject.forCollectibleType(GameObjectType(rawValue: collectibleType))
      else {
        return
    }
    
    collectSoundAction =
      SKAction.playSoundFileNamed(collectible.collectSoundFile,
                                  waitForCompletion: false)
    
    destroySoundAction =
      SKAction.playSoundFileNamed(collectible.destroySoundFile,
                                  waitForCompletion: false)
    
    canDestroy = collectible.canDestroy
  }
  
  func collectedItem() {
    componentNode.run(collectSoundAction, completion: {
      self.componentNode.removeFromParent()
    })
  }
  
  func destroyedItem() {
    if canDestroy == true {
      componentNode.run(destroySoundAction, completion: {
        self.componentNode.removeFromParent()
      })
    }
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
}
