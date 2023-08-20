//
//  GameKitHelper.swift
//  hog
//
//  Created by Tammy Coron on 10/31/2020.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import GameKit

class GameKitHelper: NSObject {
  
  // Leaderboard IDs
  static let leaderBoardIDMostWins = "net.justwritecode.hogdice.wins"
  
  // Shared GameKit Helper
  static let shared: GameKitHelper = {
    let instance = GameKitHelper()
    
    return instance
  }()
  
  // Game Center & GameKit Related View Controllers
  var authenticationViewController: UIViewController?
  var gameCenterViewController: GKGameCenterViewController?
  var matchmakerViewController: GKTurnBasedMatchmakerViewController?
  
  // Turn-based match properties
  var currentMatch: GKTurnBasedMatch?
  
  // MARK: - GAME CENTER METHODS
  
  func authenticateLocalPlayer() {
    
    // Prepare for new controller
    authenticationViewController = nil
    
    // Authenticate local player
    GKLocalPlayer.local.authenticateHandler = { viewController, error in
      
      if let viewController = viewController {
        // Present the view controller so the player can sign in
        self.authenticationViewController = viewController
        NotificationCenter.default.post(
          name: .presentAuthenticationViewController,
          object: self)
        return
      }
      else if GKLocalPlayer.local.isAuthenticated {
        GKLocalPlayer.local.register(self)
      }
      
      if error != nil {
        // Player could not be authenticated
        // Disable Game Center in the game
        return
      }
      
      // Player was successfully authenticated
      // Check if there are any player restrictions before starting the game
      
      if GKLocalPlayer.local.isUnderage {
        // Hide explicit game content
      }
      
      if GKLocalPlayer.local.isMultiplayerGamingRestricted {
        // Disable multiplayer game features
      }
      
      if GKLocalPlayer.local.isPersonalizedCommunicationRestricted {
        // Disable in game communication UI
      }
      
      // Place the access point on the upper-right corner
      // GKAccessPoint.shared.location = .topLeading
      // GKAccessPoint.shared.showHighlights = true
      // GKAccessPoint.shared.isActive = true
      
      // Perform any other configurations as needed
    }
  }
  
  // Report Score
  func reportScore(score: Int, forLeaderboardID leaderboardID: String,
                   errorHandler: ((Error?)->Void)? = nil) {
    guard GKLocalPlayer.local.isAuthenticated else { return }
    
    if #available(iOS 14, *) {
      GKLeaderboard.submitScore(score, context: 0,
                                player: GKLocalPlayer.local,
                                leaderboardIDs: [leaderboardID],
                                completionHandler: errorHandler ?? {
                                  error in
                                  print("error: \(String(describing: error))")
                                })
    } else {
      let gkScore = GKScore(leaderboardIdentifier: leaderboardID)
      gkScore.value = Int64(score)
      GKScore.report([gkScore], withCompletionHandler: errorHandler)
    }
  }
  
  // Report Achievement
  func reportAchievements(achievements: [GKAchievement],
                          errorHandler: ((Error?)->Void)? = nil) {
    guard GKLocalPlayer.local.isAuthenticated else { return }
    
    GKAchievement.report(achievements, withCompletionHandler: errorHandler)
  }
}

// MARK: - ACHIEVEMENTS HELPER CLASS

class AchievementsHelper {
  static let achievementIdFirstWin = "net.justwritecode.hogdice.first.win"
  
  class func firstWinAchievement(didWin: Bool) -> GKAchievement {
    let achievement = GKAchievement(
      identifier: AchievementsHelper.achievementIdFirstWin)
    
    if didWin {
      achievement.percentComplete = 100
      achievement.showsCompletionBanner = true
    }
    return achievement
  }
}

// MARK: - DELEGATE EXTENSIONS

extension GameKitHelper: GKGameCenterControllerDelegate {
  func gameCenterViewControllerDidFinish(_ gameCenterViewController:
                                          GKGameCenterViewController) {
    gameCenterViewController.dismiss(animated: true, completion: nil)
  }
  
  // Show the Game Center View Controller
  func showGKGameCenter(state: GKGameCenterViewControllerState) {
    guard GKLocalPlayer.local.isAuthenticated else { return }
    
    // Prepare for new controller
    gameCenterViewController = nil
    
    // Create the instance of the controller
    if #available(iOS 14, *) {
      gameCenterViewController = GKGameCenterViewController(state: state)
    } else {
      gameCenterViewController = GKGameCenterViewController()
      gameCenterViewController?.viewState = state
    }
    
    // Set the delegate
    gameCenterViewController?.gameCenterDelegate = self
    
    // Post the notification
    NotificationCenter.default.post(name: .presentGameCenterViewController,
                                    object: self)
  }
}

extension GameKitHelper: GKTurnBasedMatchmakerViewControllerDelegate {
  func turnBasedMatchmakerViewControllerWasCancelled(_ viewController:
                                                      GKTurnBasedMatchmakerViewController) {
    viewController.dismiss(animated: true, completion: nil)
  }
  
  func turnBasedMatchmakerViewController(_ viewController:
                                          GKTurnBasedMatchmakerViewController, didFailWithError error: Error) {
    print("MatchmakerViewController failed with error: \(error)")
  }
  
  // Show the Turn Based Matchmaker View Controller (Find Match)
  func findMatch() {
    guard GKLocalPlayer.local.isAuthenticated else { return }
    
    let request = GKMatchRequest()
    request.minPlayers = 2
    request.maxPlayers = 2
    request.defaultNumberOfPlayers = 2
    
    request.inviteMessage = "Do you want to play Hog Dice?"
    
    matchmakerViewController = nil
    
    matchmakerViewController =
      GKTurnBasedMatchmakerViewController(matchRequest: request)
    matchmakerViewController?.turnBasedMatchmakerDelegate = self
    
    NotificationCenter.default.post(name:
                                      .presentTurnBasedGameCenterViewController, object: nil)
  }
}

extension GameKitHelper: GKLocalPlayerListener {
  func player(_ player: GKPlayer,
              receivedTurnEventFor match: GKTurnBasedMatch,
              didBecomeActive: Bool) {
    
    matchmakerViewController?.dismiss(animated: true, completion: nil)
    NotificationCenter.default.post(name: .receivedTurnEvent,
                                    object: match)
  }
  
  // Is it the player's turn?
  func canTakeTurn() -> Bool {
    guard let match = currentMatch else { return false }
    return match.currentParticipant?.player == GKLocalPlayer.local
  }
  
  // The player's turn has ended
  func endTurn(_ gcDataModel: GameCenterData,
               errorHandler: ((Error?)->Void)? = nil) {
    guard let match = currentMatch else { return }
    
    do {
      match.message = nil
      match.endTurn(withNextParticipants: match.opponents,
                    turnTimeout: GKExchangeTimeoutDefault,
                    match: try JSONEncoder().encode(gcDataModel),
                    completionHandler: errorHandler)
      print("Game Center Data has been sent.")
    } catch {
      print("There was an error sending the match data: \(error)")
    }
  }
  
  // The player won the game
  func winGame(_ gcDataModel: GameCenterData,
               errorHandler: ((Error?)->Void)? = nil) {
    guard let match = currentMatch else { return }
    
    match.currentParticipant?.matchOutcome = .won
    
    match.opponents.forEach { participant in
      participant.matchOutcome = .lost
    }
    
    match.endMatchInTurn(withMatch: match.matchData ?? Data(),
                         completionHandler: {error in })
  }
  
  // The player lost the game
  func lostGame(_ gcDataModel: GameCenterData,
                errorHandler: ((Error?)->Void)? = nil) {
    guard let match = currentMatch else { return }
    
    match.currentParticipant?.matchOutcome = .lost
    
    match.opponents.forEach { participant in
      participant.matchOutcome = .won
    }
    
    match.endMatchInTurn(withMatch: match.matchData ?? Data(),
                         completionHandler: {error in })
  }
}

// MARK: - NOTIFICATION EXTENSIONS

extension Notification.Name {
  static let presentAuthenticationViewController =
    Notification.Name("presentAuthenticationViewController")
  static let presentGameCenterViewController =
    Notification.Name("presentGameCenterViewController")
  static let presentTurnBasedGameCenterViewController =
    Notification.Name("presentTurnBasedGameCenterViewController")
  static let receivedTurnEvent = Notification.Name("receivedTurnEvent")
}
