//
//  RenderComponent.swift
//  valsrevenge
//
//  Created by Tammy Coron on 7/4/20.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

class RenderComponent: GKComponent {
  
  lazy var spriteNode: SKSpriteNode? = {
    entity?.component(ofType: GKSKNodeComponent.self)?.node as? SKSpriteNode
  }()
  
  init(node: SKSpriteNode) {
    super.init()
    spriteNode = node
  }
  
  init(imageNamed: String, scale: CGFloat) {
    super.init()
    
    spriteNode = SKSpriteNode(imageNamed: imageNamed)
    spriteNode?.setScale(scale)
  }
  
  override func didAddToEntity() {
    spriteNode?.entity = entity
  }
  
  required init?(coder: NSCoder) {
    super.init(coder:coder)
  }
  
  override class var supportsSecureCoding: Bool {
    true
  }
}
