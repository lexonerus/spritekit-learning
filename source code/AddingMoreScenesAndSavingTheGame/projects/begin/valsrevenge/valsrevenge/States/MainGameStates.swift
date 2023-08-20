//
//  MainGameStates.swift
//  valsrevenge
//
//  Created by Tammy Coron on 7/4/20.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import GameplayKit

class PauseState: GKState {
  
  override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return stateClass == PlayingState.self
  }
}

class PlayingState: GKState {
  
  override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return stateClass == PauseState.self
  }
}
