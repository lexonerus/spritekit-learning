//
//  PlayerStates.swift
//  valsrevenge
//
//  Created by Tammy Coron on 7/4/20.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import GameplayKit

class PlayerHasKeyState: GKState {
  
  override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return stateClass == PlayerHasKeyState.self ||
      stateClass == PlayerHasNoKeyState.self
  }
  
  override func didEnter(from previousState: GKState?) {
    print(" Entering PlayerHasKeyState")
  }
  
  override func willExit(to nextState: GKState) {
    // print("Exiting PlayerHasKeyState")
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    // print("Updating PlayerHasKeyState")
  }
}

class PlayerHasNoKeyState: GKState {
  
  override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return stateClass == PlayerHasKeyState.self ||
      stateClass == PlayerHasNoKeyState.self
  }
  
  override func didEnter(from previousState: GKState?) {
    print("Entering PlayerHasNoKeyState")
  }
  
  override func willExit(to nextState: GKState) {
    // print("Exiting PlayerHasNoKeyState")
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    // print("Updating PlayerHasNoKeyState")
  }
}
