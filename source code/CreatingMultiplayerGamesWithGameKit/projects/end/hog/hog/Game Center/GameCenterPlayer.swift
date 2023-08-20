//
//  GameCenterPlayer.swift
//  hog
//
//  Created by Tammy Coron on 10/31/2020.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

class GameCenterPlayer: Codable, Equatable {
  
  var playerId: String
  var playerName: String
  
  var isLocalPlayer: Bool = false
  var isWinner: Bool = false
  
  var totalPoints: Int = 0
  
  // protocol required for `Equatable`
  static func == (lhs: GameCenterPlayer, rhs: GameCenterPlayer) -> Bool {
    return lhs.playerId == rhs.playerId && lhs.playerName == rhs.playerName
  }
  
  init(playerId: String, playerName: String) {
    self.playerId = playerId
    self.playerName = playerName
  }
}
