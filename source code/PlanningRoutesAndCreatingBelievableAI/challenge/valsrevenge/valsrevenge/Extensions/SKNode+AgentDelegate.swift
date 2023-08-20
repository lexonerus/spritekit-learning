//
//  SKNode+AgentDelegate.swift
//  valsrevenge
//
//  Created by Tammy Coron on 7/4/20.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

extension SKNode: GKAgentDelegate {
  
  // Update the agent position to match the node position
  public func agentWillUpdate(_ agent: GKAgent) {
    
    guard let agent2d = agent as? GKAgent2D else {
      return
    }
    agent2d.position = vector_float2(Float(position.x),
                                     Float(position.y))
  }
  
  // Update the node position to match the agent position
  public func agentDidUpdate(_ agent: GKAgent) {
    guard let agent2d = agent as? GKAgent2D else {
      return
    }
    
    position = CGPoint(x: CGFloat(agent2d.position.x),
                       y: CGFloat(agent2d.position.y))
  }
}
