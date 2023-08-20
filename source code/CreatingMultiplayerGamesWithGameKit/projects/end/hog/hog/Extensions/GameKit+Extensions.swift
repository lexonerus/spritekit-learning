//
//  GameKit+Extensions.swift
//  hog
//
//  Created by Tammy Coron on 10/31/2020.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import GameKit

extension GKTurnBasedMatch {
  
  var localPlayer: GKTurnBasedParticipant? {
    return participants.filter({ $0.player == GKLocalPlayer.local}).first
  }
  
  var opponents: [GKTurnBasedParticipant] {
    return participants.filter {
      return $0.player != GKLocalPlayer.local
    }
  }
}
