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

// MARK: - NOTIFICATION EXTENSIONS

extension Notification.Name {
  static let presentAuthenticationViewController =
    Notification.Name("presentAuthenticationViewController")
  static let presentGameCenterViewController =
    Notification.Name("presentGameCenterViewController")
}
