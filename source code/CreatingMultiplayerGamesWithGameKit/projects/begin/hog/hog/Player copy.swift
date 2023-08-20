//
//  Player.swift
//  hog
//
//  Created by Tammy Coron on 10/31/20.
//

import SpriteKit
import GameplayKit

class Player: NSObject, GKGameModelPlayer {
  
  var playerId: Int // Required. Conformance of GKGameModelPlayer
  
  var mainStateMachine: GKStateMachine!
  
  var name: String!
  var isHuman: Bool!
  
  var totalPoints: Int = 0 {
    didSet {
      tPointsLabel?.text = "\(totalPoints)"
    }
  }
  
  var pointsThisRound: Int = 0 {
    didSet {
      rPointsLabel?.text = "\(pointsThisRound)"
    }
  }
  
  weak var scorecard: SKSpriteNode?
  
  lazy var tPointsLabel: SKLabelNode? = {
    scorecard?.childNode(withName: "totalPoints") as? SKLabelNode
  }()
  
  lazy var rPointsLabel: SKLabelNode? = {
    scorecard?.childNode(withName: "roundPoints") as? SKLabelNode
  }()
  
  lazy var turnIndicator: SKSpriteNode? = {
    scorecard?.childNode(withName: "turnIndicator") as? SKSpriteNode
  }()
  
  var totalRolls: Int = 0
  var rollsThisRound: Int = 0
  
  init(_ pNumber: Int = 0, name: String = "Computer", isHuman: Bool = false) {
    
    self.playerId = pNumber
    super.init()
    
    self.name = name
    self.isHuman = isHuman
    
    self.mainStateMachine =
      GKStateMachine(states: [WaitingForTurn(player: self),
                              TurnInProgress(player: self),
                              RollInProgress(player: self)])
  }
  
  func beginTurn() {
    turnIndicator?.alpha = 1
  }
  
  func rolled(_ number: Int) {
    mainStateMachine.enter(TurnInProgress.self)
  }
  
  func endTurn() {
    turnIndicator?.alpha = 0
    pointsThisRound = 0
  }
  
  func resetScore() {
    totalPoints = 0
    pointsThisRound = 0
    
    totalRolls = 0
    rollsThisRound = 0
  }
}

class WaitingForTurn: GKState {
  unowned let player: Player
  
  init(player: Player) {
    self.player = player
    super.init()
  }
  
  override func didEnter(from previousState: GKState?) {
    player.endTurn()
  }
  
  override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return stateClass == TurnInProgress.self
  }
}

class TurnInProgress: GKState {
  unowned let player: Player
  
  init(player: Player) {
    self.player = player
    super.init()
  }
  
  override func didEnter(from previousState: GKState?) {
    player.beginTurn()
  }
  
  override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return stateClass == RollInProgress.self ||
      stateClass == WaitingForTurn.self
  }
}

class RollInProgress: GKState {
  unowned let player: Player
  
  init(player: Player) {
    self.player = player
    super.init()
  }
  
  override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return stateClass == TurnInProgress.self
  }
}


